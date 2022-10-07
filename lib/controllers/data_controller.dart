import 'package:get/get.dart';
import 'package:zando_m/models/operation.dart';
import 'package:zando_m/reports/report.dart';

import '../models/client.dart';
import '../models/compte.dart';
import '../models/currency.dart';
import '../models/facture.dart';
import '../models/user.dart';
import '../reports/models/dashboard_count.dart';
import '../services/db_helper.dart';
import '../services/native_db_helper.dart';
import '../services/synchonisation.dart';

class DataController extends GetxController {
  static DataController instance = Get.find();
  var users = <User>[].obs;
  var factures = <Facture>[].obs;
  var filteredFactures = <Facture>[].obs;
  var clients = <Client>[].obs;
  var clientFactures = <Client>[].obs;
  var comptes = <Compte>[].obs;
  var allComptes = <Compte>[].obs;
  var currency = Currency().obs;
  var dashboardCounts = <DashboardCount>[].obs;
  var paiements = <Operations>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshDatas();
  }

  Future<void> refreshDatas() async {
    refreshCurrency();
    loadActivatedComptes();
  }

  loadUsers() async {
    var db = await DbHelper.initDb();
    var userData = await db.query("users");
    if (userData != null) {
      users.clear();
      userData.forEach((e) {
        users.add(User.fromMap(e));
      });
    }
  }

  loadFilterFactures(String key) async {
    try {
      var query;
      switch (key) {
        case "all":
          query = await NativeDbHelper.rawQuery(
              "SELECT * FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE NOT factures.facture_state='deleted' ORDER BY factures.facture_id DESC");
          break;
        case "pending":
          query = await NativeDbHelper.rawQuery(
              "SELECT * FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_statut='en cours' AND NOT factures.facture_state='deleted' ORDER BY factures.facture_id DESC");
          break;
        case "completed":
          query = await NativeDbHelper.rawQuery(
              "SELECT * FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_statut='paie' AND NOT factures.facture_state='deleted' ORDER BY factures.facture_id DESC");
          break;
        default:
          print("other");
      }
      if (query != null) {
        filteredFactures.clear();
        query.forEach((e) {
          filteredFactures.add(Facture.fromMap(e));
        });
      }
    } catch (e) {}
  }

  refreshDashboardCounts() async {
    var counts = await Report.getCount();
    dashboardCounts.clear();
    dashboardCounts.addAll(counts);
  }

  refreshCurrency() async {
    var db = await DbHelper.initDb();
    var taux = await db.query("currencies");
    if (taux != null && taux.isNotEmpty) {
      currency.value = Currency.fromMap(taux.first);
    }
  }

  loadFacturesEnAttente() async {
    try {
      var allFactures = await NativeDbHelper.rawQuery(
          "SELECT * FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_statut = 'en cours' AND NOT factures.facture_state='deleted' ORDER BY facture_id DESC");
      if (allFactures != null) {
        factures.clear();
        allFactures.forEach((e) {
          factures.add(Facture.fromMap(e));
        });
      }
    } catch (e) {}
  }

  loadClients() async {
    try {
      var allClients = await NativeDbHelper.rawQuery(
          "SELECT * FROM clients WHERE NOT client_state='deleted' ORDER BY client_id DESC");
      if (allClients != null) {
        clients.clear();
        allClients.forEach((e) {
          clients.add(Client.fromMap(e));
        });
      }
    } catch (e) {}
  }

  loadPayments() async {
    String statmentOp =
        "operations.operation_id,operations.operation_libelle,operations.operation_type ,operations.operation_montant, operations.operation_devise, operations.operation_facture_id, operations.operation_mode, operations.operation_create_At";
    String statmentFac =
        "factures.facture_id, factures.facture_montant, factures.facture_devise, factures.facture_client_id, factures.facture_create_At, factures.facture_statut";
    String statmentClient =
        "clients.client_id, clients.client_nom,clients.client_tel, clients.client_adresse";
    var query = await NativeDbHelper.rawQuery(
      "SELECT $statmentOp,$statmentFac, $statmentClient, SUM(operations.operation_montant) AS totalPay FROM factures INNER JOIN operations ON factures.facture_id = operations.operation_facture_id INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE NOT operations.operation_state='deleted' GROUP BY operations.operation_facture_id",
    );
    paiements.clear();
    query.forEach((e) {
      paiements.add(Operations.fromMap(e));
    });
  }

  loadActivatedComptes() async {
    try {
      var allAccounts = await NativeDbHelper.rawQuery(
          "SELECT * FROM comptes WHERE compte_status='actif' AND NOT compte_state='deleted'");
      if (allAccounts != null) {
        comptes.clear();
        allAccounts.forEach((e) {
          comptes.add(Compte.fromMap(e));
        });
      }
    } catch (e) {}
  }

  loadAllComptes() async {
    try {
      var db = await DbHelper.initDb();
      var json = await NativeDbHelper.rawQuery(
          "SELECT * FROM comptes WHERE NOT compte_state='deleted'");
      if (json != null) {
        allComptes.clear();
        json.forEach((e) {
          allComptes.add(Compte.fromMap(e));
        });
      }
    } catch (e) {}
  }

  editCurrency({String value}) async {
    try {
      var db = await DbHelper.initDb();
      var data = Currency(currencyValue: value);
      var checked = await db.query("currencies");
      if (checked.isEmpty && value == null) {
        var data = Currency(currencyValue: "2000");
        await db.insert("currencies", data.toMap());
      }
      if (value != null) {
        var lastUpdatedId = await db.update(
          "currencies",
          data.toMap(),
          where: "cid=?",
          whereArgs: [1],
        );
        if (lastUpdatedId != null) {
          refreshCurrency();
        }
      }
    } catch (e) {}
  }

  deleteUnavailableData() async {
    var db = await DbHelper.initDb();
    try {
      await db.transaction((txn) async {
        await txn
            .rawDelete("DELETE FROM clients WHERE client_state=?", ['deleted']);
        await txn
            .rawDelete("DELETE FROM comptes WHERE compte_state=?", ['deleted']);
        await txn.rawDelete(
            "DELETE FROM factures WHERE facture_state=?", ['deleted']);
        await txn.rawDelete(
            "DELETE FROM facture_details WHERE facture_detail_state=?",
            ['deleted']);
        await txn.rawDelete(
            "DELETE FROM operations WHERE operation_state=?", ['deleted']);
      });
    } catch (err) {}
  }

  syncData() async {
    var db = await DbHelper.initDb();
    await deleteUnavailableData();
    var syncDatas = await Synchroniser.outPutData();
    try {
      if (syncDatas.users.isNotEmpty) {
        print("users: ${syncDatas.users.length}");
        for (var user in syncDatas.users) {
          var check = await db.rawQuery(
            "SELECT * FROM users WHERE user_id = ?",
            [user.userId],
          );
          if (check.isEmpty) {
            await db.insert("users", user.toMap());
          } else {
            await db.update(
              "users",
              user.toMap(),
              where: "user_id=?",
              whereArgs: [user.userId],
            );
          }
        }
      }
      if (syncDatas.clients.isNotEmpty) {
        print("clients : ${syncDatas.clients.length}");
        try {
          for (var client in syncDatas.clients) {
            if (client.clientState == "allowed") {
              var check = await db.rawQuery(
                "SELECT * FROM clients WHERE client_id = ?",
                [client.clientId],
              );
              if (check.isEmpty) {
                await db.insert("clients", client.toMap());
              }
            } else {
              await db.delete("clients",
                  where: "client_id = ?", whereArgs: [client.clientId]);
            }
          }
        } catch (err) {}
      }
      if (syncDatas.factures.isNotEmpty) {
        print("factures : ${syncDatas.factures.length}");
        try {
          for (var facture in syncDatas.factures) {
            if (facture.factureState == "allowed") {
              var check = await db.rawQuery(
                "SELECT * FROM factures WHERE facture_id = ?",
                [facture.factureId],
              );
              if (check.isEmpty) {
                await db.insert("factures", facture.toMap());
              } else {
                Get.back();
              }
            } else {
              await db.delete("factures",
                  where: "facture_id = ?", whereArgs: [facture.factureId]);
            }
          }
        } catch (e) {
          print(e);
        }
      }
      if (syncDatas.factureDetails.isNotEmpty) {
        print("details : ${syncDatas.factureDetails.length}");
        try {
          for (var detail in syncDatas.factureDetails) {
            if (detail.factureDetailState == "allowed") {
              var check = await db.rawQuery(
                "SELECT * FROM facture_details WHERE facture_detail_id = ?",
                [detail.factureDetailId],
              );
              if (check.isEmpty) {
                await db.insert("facture_details", detail.toMap());
              } else {
                Get.back();
              }
            } else {
              await db.delete("facture_details",
                  where: "facture_detail_id = ?",
                  whereArgs: [detail.factureDetailId]);
            }
          }
        } catch (e) {}
      }
      if (syncDatas.operations.isNotEmpty) {
        print("operations : ${syncDatas.operations.length}");
        try {
          for (var operation in syncDatas.operations) {
            if (operation.operationState == "allowed") {
              var check = await db.rawQuery(
                "SELECT * FROM operations WHERE operation_id = ?",
                [operation.operationId],
              );
              if (check.isEmpty) {
                await db.insert("operations", operation.toMap());
              }
            } else {
              await db.delete("operations",
                  where: "operation_id = ?",
                  whereArgs: [operation.operationId]);
            }
          }
        } catch (e) {}
      }
      if (syncDatas.comptes.isNotEmpty) {
        print("comptes : ${syncDatas.comptes.length}");
        try {
          for (var compte in syncDatas.comptes) {
            if (compte.compteState == "allowed") {
              var check = await db.rawQuery(
                "SELECT * FROM comptes WHERE compte_id = ? ",
                [compte.compteId],
              );
              if (check.isEmpty) {
                await db.insert("comptes", compte.toMap());
              } else {
                await db.update(
                  "comptes",
                  compte.toMap(),
                  where: "compte_id=?",
                  whereArgs: [compte.compteId],
                );
              }
            } else {
              await db.delete("comptes",
                  where: "compte_id = ?", whereArgs: [compte.compteId]);
            }
          }
        } catch (e) {}
      }

      await refreshDatas();
    } catch (err) {
      print(err);
    }
  }
}
