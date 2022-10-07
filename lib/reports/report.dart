import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zando_m/global/utils.dart';
import 'package:zando_m/reports/models/dashboard_count.dart';

import '../services/db_helper.dart';

class Report {
  static Future<int> _count(String keyword) async {
    final DateTime now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    int date = convertToTimestamp(now);
    var db = await DbHelper.initDb();
    switch (keyword) {
      case "costumers":
        var res = await db.rawQuery(
            "SELECT COUNT(*) as costumers FROM clients WHERE NOT client_state='deleted'");
        return res.isEmpty ? 0.0 : res.first['costumers'];
      case "daily":
        var res = await db.rawQuery(
            "SELECT COUNT(*) as daily FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_create_At LIKE '%$date%' AND NOT factures.facture_state='deleted' AND NOT clients.client_state='deleted'");
        return res.isEmpty ? 0.0 : res.first['daily'];
      case "pending":
        var res = await db.rawQuery(
            "SELECT COUNT(*) as pending FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_statut='en cours' AND NOT factures.facture_state='deleted' AND NOT clients.client_state='deleted'");
        return res.isEmpty ? 0.0 : res.first['pending'];
      case "completed":
        var res = await db.rawQuery(
            "SELECT COUNT(*) as completed FROM factures INNER JOIN clients ON factures.facture_client_id = clients.client_id WHERE factures.facture_statut='paie' AND NOT factures.facture_state='deleted' AND NOT clients.client_state='deleted'");
        return res.isEmpty ? 0.0 : res.first['completed'];
      default:
        return 0;
    }
  }

  static Future<List<DashboardCount>> getCount() async {
    final List<DashboardCount> counts = <DashboardCount>[];

    /*count daily factures*/

    var dailyFac = await _count("daily");
    var dailyFacData = DashboardCount(
      countValue: dailyFac,
      icon: CupertinoIcons.calendar_today,
      title: "Factures journalières",
      color: Colors.indigo,
    );
    counts.add(dailyFacData);

    /* end & push data */

    /*pending factures count */

    var pendingCount = await _count("pending");
    var pendingData = DashboardCount(
      countValue: pendingCount,
      icon: CupertinoIcons.doc_circle_fill,
      title: "Factures en cours",
      color: Colors.brown,
    );
    counts.add(pendingData);

    /*end & push data*/

    /* count costumers */
    var costumers = await _count("costumers");
    var costumersData = DashboardCount(
      countValue: costumers,
      icon: CupertinoIcons.group_solid,
      title: "Clients",
      color: Colors.blue,
    );
    counts.add(costumersData);

    /*en & push data to list*/

    /* count completed factures */

    var completedCount = await _count("completed");
    var completedCountData = DashboardCount(
      countValue: completedCount,
      icon: CupertinoIcons.doc_checkmark_fill,
      title: "Factures réglées",
      color: Colors.green,
    );
    counts.add(completedCountData);
    /*end & push data*/

    /*return list completed */
    return counts;
  }
}
