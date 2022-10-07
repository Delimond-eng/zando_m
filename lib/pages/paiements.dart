import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_m/global/controllers.dart';
import '../responsive/base_widget.dart';
import '../widgets/costum_table.dart';
import '../widgets/custom_page.dart';
import '../widgets/filter_btn.dart';
import '../widgets/search_input.dart';
import 'modals/payModal.dart';

class Paiements extends StatefulWidget {
  const Paiements({Key key}) : super(key: key);

  @override
  State<Paiements> createState() => _PaiementsState();
}

class _PaiementsState extends State<Paiements> {
  @override
  void initState() {
    super.initState();
    dataController.loadPayments();
  }

  final List<Map> _filters = [
    {"keyw": "all", "title": "Tous les paiements"},
    {"keyw": "date", "title": "Filtrer par date"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black12,
      backgroundColor: Colors.transparent,
      body: CustomPage(
        title: "Paiements",
        icon: CupertinoIcons.doc_checkmark_fill,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Responsive(
              builder: (context, responsive) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Liste des Paiements",
                        style: GoogleFonts.didactGothic(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    _topFilters(context),
                    _dataTableViewer(context)
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _dataTableViewer(BuildContext context) {
    return Expanded(
      child: FadeInUp(
        child: Obx(() {
          return ListView(
            padding: const EdgeInsets.all(10.0),
            children: [
              CostumTable(
                cols: const [
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
          );
        }),
      ),
    );
  }

  Widget _topFilters(BuildContext context) {
    var _selectedFilterKeyword = "all";
    return FadeInUp(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: StatefulBuilder(builder: (context, setter) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ..._filters.map((e) {
                    return FilterBtn(
                      isSelected: e['keyw'] == _selectedFilterKeyword,
                      title: e['title'],
                      margin: 10.0,
                      icon: Icons.filter_list_rounded,
                      onPressed: () {
                        setter(() {
                          _selectedFilterKeyword = e['keyw'];
                        });
                      },
                    );
                  })
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Flexible(
                child: SearchInput(
                  spacedLeft: 0,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  List<DataRow> _createRows(BuildContext context) {
    return dataController.paiements
        .map(
          (data) => DataRow(
            cells: [
              DataCell(
                Text(
                  data.operationDate,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.facture.factureMontant,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.totalPayment.toString(),
                  style: GoogleFonts.didactGothic(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${((double.parse(data.facture.factureMontant) - data.totalPayment))}',
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.operationMode,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: (data.facture.factureStatut == "paie")
                        ? Colors.green[200]
                        : Colors.pink[100],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    data.facture.factureStatut,
                    style: GoogleFonts.didactGothic(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      color: (data.facture.factureStatut == "paie")
                          ? Colors.green[700]
                          : Colors.pink,
                    ),
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.clientNom,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    if (data.facture.factureStatut != "paie") ...[
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 2,
                          padding: const EdgeInsets.all(8.0),
                        ),
                        child: Text(
                          "Payer",
                          style: GoogleFonts.didactGothic(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                        onPressed: () {
                          showPayModal(context, data.facture);
                        },
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                    ],
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
                      onPressed: () async {
                        await dataController.loadPayments();
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
}
