import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/topbar.dart';
import '../../widgets/costum_table.dart';
import '../../widgets/round_icon_btn.dart';
import '../../widgets/tot_info_view.dart';

factureDetailsModal(BuildContext context) {
  showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return FadeInRightBig(
        child: Dialog(
          insetPadding: const EdgeInsets.all(100.0),
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
                          "Facture détails",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 5,
                                            offset: const Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Client Infos",
                                              style: GoogleFonts.didactGothic(
                                                color: Colors.indigo,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            _clientInfoField(
                                                title: "Nom",
                                                value: "Gaston Delimond"),
                                            _clientInfoField(
                                                title: "Téléphone",
                                                value: "(+243) 81 371 99 44"),
                                            _clientInfoField(
                                                title: "Adresse",
                                                value:
                                                    "03, Bismark Gombe Kinshasa"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 5,
                                            offset: const Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Info montant facture",
                                              style: GoogleFonts.didactGothic(
                                                color: Colors.indigo,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            const TotItem(
                                              alignment:
                                                  MainAxisAlignment.start,
                                            ),
                                            const TotItem(
                                              alignment:
                                                  MainAxisAlignment.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            _dataTableView(context)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: Colors.grey[800],
                              ),
                              child: Text(
                                "Fermer",
                                style: GoogleFonts.didactGothic(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: Colors.blue,
                              ),
                              icon: const Icon(CupertinoIcons.printer_fill,
                                  size: 15.0),
                              label: Text(
                                "Imprimer facture",
                                style: GoogleFonts.didactGothic(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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

Widget _clientInfoField({String title, String value}) {
  return Container(
    height: 40.0,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: Colors.grey[300])),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title : ",
                    style: GoogleFonts.didactGothic(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "$value ",
                    style: GoogleFonts.didactGothic(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

_dataTableView(BuildContext context) {
  final List<Map> _books = [
    {'id': 100, 'title': 'Flutter Basics', 'pu': 25, 'qty': 1},
    {'id': 102, 'title': 'Git and GitHub', 'pu': 10, 'qty': 2},
  ];
  return Expanded(
    child: ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      children: [
        CostumTable(
          cols: const ["id", "Libellé", "PU", "QTE", ""],
          data: _books
              .map(
                (book) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        'n° ' + book['id'].toString(),
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        book['title'],
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        "${book['pu'].toString()} USD",
                        style: GoogleFonts.didactGothic(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        book['qty'].toString(),
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
                            "Effacer",
                            style: GoogleFonts.didactGothic(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ))
                  ],
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
