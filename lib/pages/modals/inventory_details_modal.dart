import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/topbar.dart';
import '../../widgets/costum_table.dart';
import '../../widgets/round_icon_btn.dart';
import 'facture_details_modal.dart';

inventoryDetailsModal(BuildContext context) {
  showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return FadeInUp(
        child: Dialog(
          insetPadding: const EdgeInsets.all(50.0),
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ), //this right here
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TopBar(
                  color: Colors.blue,
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inventaire détails",
                          style: GoogleFonts.didactGothic(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        RoundedIconBtn(
                          size: 30.0,
                          iconColor: Colors.pink,
                          color: Colors.white,
                          icon: CupertinoIcons.clear,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Date : 20-12-22",
                                style: GoogleFonts.didactGothic(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.all(10.0),
                                children: [
                                  CostumTable(
                                    cols: const [
                                      "N° Fac.",
                                      "Date",
                                      "Montant",
                                      "Paiement",
                                      "Reste",
                                      "Mode",
                                      "Status",
                                      "Client",
                                      ""
                                    ],
                                    data: _createRows(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

List<DataRow> _createRows(BuildContext context) {
  final List<Map> _factures = [
    {
      'id': 021,
      'date': "02-03-22",
      'montant': 3500,
      "paie": 1500,
      "rest": 2000,
      "mode": "cash",
      "status": "payé",
      "client": "Gaston Delimond"
    },
    {
      'id': 021,
      'date': "02-03-22",
      'montant': 3500,
      "paie": 1500,
      "rest": 2000,
      "mode": "cash",
      "status": "payé",
      "client": "Gaston Delimond"
    },
    {
      'id': 021,
      'date': "02-03-22",
      'montant': 3500,
      "paie": 1500,
      "rest": 2000,
      "mode": "cash",
      "status": "payé",
      "client": "Gaston Delimond"
    },
  ];
  return _factures
      .map(
        (book) => DataRow(
          cells: [
            DataCell(
              Text(
                book['id'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                book['date'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                book['montant'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                book['paie'].toString(),
                style: GoogleFonts.didactGothic(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                book['rest'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Text(
                book['mode'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  book['status'].toString(),
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                    fontSize: 10.0,
                    color: Colors.green[700],
                  ),
                ),
              ),
            ),
            DataCell(
              Text(
                book['client'].toString(),
                style: GoogleFonts.didactGothic(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DataCell(
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 2,
                      padding: const EdgeInsets.all(8.0),
                    ),
                    child: Text(
                      "Voir détals",
                      style: GoogleFonts.didactGothic(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    onPressed: () {
                      factureDetailsModal(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
      .toList();
}
