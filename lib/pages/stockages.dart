import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_m/pages/components/stock_create_drawer.dart';
import 'package:zando_m/pages/modals/stock_detail_modal.dart';
import 'package:zando_m/widgets/search_input.dart';

import '../repositories/stock_repo/models/stock.dart';
import '../repositories/stock_repo/services/db_stock_helper.dart';
import '../responsive/base_widget.dart';
import '../widgets/costum_table.dart';
import '../widgets/custom_page.dart';

class Stockages extends StatefulWidget {
  const Stockages({Key key}) : super(key: key);

  @override
  State<Stockages> createState() => _StockagesState();
}

class _StockagesState extends State<Stockages> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<Stock> stocks = <Stock>[];

  initData() async {
    var db = await DbStockHelper.initDb();
    var query = await db.rawQuery(
        "SELECT SUM(mouvements.mouvt_qte_en) AS entrees,SUM(mouvements.mouvt_qte_so) AS sorties, * FROM stocks INNER JOIN articles ON stocks.stock_article_id = articles.article_id INNER JOIN mouvements ON stocks.stock_id = mouvements.mouvt_stock_id WHERE NOT stocks.stock_state = 'deleted' AND NOT mouvements.mouvt_state='deleted' AND NOT articles.article_state = 'deleted' GROUP BY stocks.stock_id,mouvements.mouvt_create_At ORDER BY mouvements.mouvt_create_At DESC");
    stocks.clear();
    for (var e in query) {
      stocks.add(Stock.fromMap(e));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: const StockCreateDrawer(),
      drawerScrimColor: Colors.transparent,
      body: CustomPage(
        title: "Stockage",
        icon: Icons.backpack_rounded,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.doc_chart_fill,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Rapport global stocks",
                                style: GoogleFonts.didactGothic(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: SearchInput(
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              _key.currentState.openEndDrawer();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20.0),
                              backgroundColor: Colors.indigo,
                            ),
                            icon: const Icon(
                              CupertinoIcons.add,
                              size: 15.0,
                            ),
                            label: Text(
                              "Nouveau stock",
                              style: GoogleFonts.didactGothic(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          CostumTable(
                            cols: const [
                              "Date stockage",
                              "Article",
                              "Prix d'achat",
                              "Qté entrée",
                              "Qté sortie",
                              "Solde",
                              "Status",
                              ""
                            ],
                            data: _createRows(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<DataRow> _createRows(BuildContext context) {
    return stocks
        .map(
          (data) => DataRow(
            onSelectChanged: (val) {
              if (val) {
                showStockDetails(context);
              }
            },
            cells: [
              DataCell(
                Text(
                  data.stockDate,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.article.articleLibelle,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  '${data.stockPrixAchat} ${data.stockPrixAchatDevise}',
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.stockEn.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.didactGothic(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  data.stockSo.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  (int.parse(data.stockEn.toString()) -
                          int.parse(data.stockSo.toString()))
                      .toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: data.stockStatus == "actif"
                        ? Colors.green[200]
                        : Colors.pink[100],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    data.stockStatus,
                    style: GoogleFonts.didactGothic(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                      color: data.stockStatus == "actif"
                          ? Colors.green[700]
                          : Colors.pink[800],
                    ),
                  ),
                ),
              ),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 2,
                        padding: const EdgeInsets.all(8.0),
                      ),
                      icon: const Icon(
                        Icons.add_circle,
                        size: 14.0,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Entrée",
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: () async {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        elevation: 2,
                        padding: const EdgeInsets.all(8.0),
                      ),
                      icon: const Icon(
                        Icons.remove_circle,
                        size: 14.0,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Sortie",
                        style: GoogleFonts.didactGothic(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: () async {},
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
