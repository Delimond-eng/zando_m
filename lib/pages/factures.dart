import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../responsive/base_widget.dart';
import '../widgets/costum_table.dart';
import '../widgets/custom_page.dart';
import '../widgets/filter_btn.dart';
import '../widgets/search_input.dart';
import 'modals/facture_details_modal.dart';

class Factures extends StatefulWidget {
  const Factures({Key key}) : super(key: key);

  @override
  State<Factures> createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  final List<Map> _filters = [
    {"keyw": "all", "title": "Toutes les factures"},
    {"keyw": "pending", "title": "Factures en cours"},
    {"keyw": "completed", "title": "Factures réglées"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.black12,
      backgroundColor: Colors.transparent,
      body: CustomPage(
        title: "Factures",
        icon: CupertinoIcons.doc_on_doc_fill,
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
                        "Liste des factures",
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
              data: _createRows(),
            ),
          ],
        ),
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
  ];

  List<DataRow> _createRows() {
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
              DataCell(Row(
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
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
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
                    onPressed: () {},
                  ),
                ],
              ))
            ],
          ),
        )
        .toList();
  }
}
