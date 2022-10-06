import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_m/global/controllers.dart';
import 'package:zando_m/pages/modals/facture_create_modal.dart';
import 'package:zando_m/utilities/modals.dart';

import '../services/db_helper.dart';
import '../widgets/costum_table.dart';
import '../widgets/custom_page.dart';
import '../widgets/search_input.dart';

class Clients extends StatefulWidget {
  const Clients({Key key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  void initState() {
    super.initState();
    dataController.loadClients();
  }

  List<DataRow> _createRows() {
    return dataController.clients
        .map(
          (client) => DataRow(
            cells: [
              DataCell(
                Text(
                  client.clientCreatAt,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  client.clientNom,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  client.clientTel,
                  style: GoogleFonts.didactGothic(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  client.clientAdresse,
                  style: GoogleFonts.didactGothic(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink,
                      elevation: 2,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    child: Text(
                      "Supprimer",
                      style: GoogleFonts.didactGothic(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    onPressed: () async {
                      var db = await DbHelper.initDb();

                      XDialog.show(context,
                          message:
                              "Etes-vous sûr de vouloir supprimér ce client ?",
                          onValidated: () async {
                        await db.delete("clients",
                            where: "client_id=?",
                            whereArgs: [client.clientId]).then(
                          (id) {
                            dataController.loadClients();
                            XDialog.showMessage(context,
                                message: "client supprimé avec succès !",
                                type: "success");
                          },
                        );
                      }, onFailed: () {});
                    },
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      elevation: 2,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    child: Text(
                      "Créer facture",
                      style: GoogleFonts.didactGothic(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    onPressed: () {
                      createFactureModal(
                        context,
                        showClientList: false,
                        client: client,
                      );
                    },
                  ),
                ],
              ))
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Clients",
      icon: CupertinoIcons.group_solid,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => dataController.clients.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Liste des clients",
                          style: GoogleFonts.didactGothic(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Obx(() {
                if (dataController.clients.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(
                          child: SearchInput(
                            spacedLeft: 0,
                            hintText: "Recherche client...",
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              }),
              Expanded(
                child: Obx(() {
                  if (dataController.clients.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucun client répertorié !",
                        style: GoogleFonts.didactGothic(
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      padding: const EdgeInsets.all(10.0),
                      children: [
                        CostumTable(
                          cols: const [
                            "Date création",
                            "Nom",
                            "Téléphone",
                            "Adresse",
                            ""
                          ],
                          data: _createRows(),
                        )
                      ],
                    );
                  }
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
