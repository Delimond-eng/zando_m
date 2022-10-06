import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_m/pages/modals/inventory_details_modal.dart';
import 'package:zando_m/widgets/filter_drop.dart';

import '../responsive/base_widget.dart';
import '../widgets/costum_table.dart';
import '../widgets/custom_page.dart';
import '../widgets/filter_btn.dart';

class Inventories extends StatefulWidget {
  const Inventories({Key key}) : super(key: key);

  @override
  State<Inventories> createState() => _InventoriesState();
}

class _InventoriesState extends State<Inventories> {
  final ScrollController hScrollController = ScrollController();
  final ScrollController vScrollController = ScrollController();
  bool viewCategories = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPage(
        title: "Inventaires",
        icon: CupertinoIcons.doc_chart_fill,
        child: LayoutBuilder(builder: (context, constraints) {
          return Responsive(builder: (context, responsive) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _inventoriesFilters(context),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(10.0),
                          children: [
                            CostumTable(
                              cols: const [
                                "Date",
                                "Entrées",
                                "Sorties",
                                "Solde",
                                "Compte",
                                "Status",
                                ""
                              ],
                              data: _createRows(),
                            ),
                          ],
                        ),
                      ),
                      _rightSide(context),
                    ],
                  ),
                )
              ],
            );
          });
        }),
      ),
    );
  }

  Widget _rightSide(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160.0,
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          bottom: BorderSide(color: Colors.indigo, width: 6.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 3,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Vue synthétique",
                    style: GoogleFonts.didactGothic(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: SyntheseInfo(
                    amount: 300.0,
                    currency: "USD",
                    title: "Total des entrées",
                    icon: CupertinoIcons.up_arrow,
                    thikness: .1,
                    titleColor: Colors.green[700],
                  ),
                ),
                const Flexible(
                  child: SyntheseInfo(
                    amount: 0.0,
                    currency: "USD",
                    title: "Total des sortie",
                    titleColor: Colors.red,
                    icon: CupertinoIcons.down_arrow,
                    thikness: .1,
                  ),
                ),
                const Flexible(
                  child: SyntheseInfo(
                    amount: 300.0,
                    currency: "USD",
                    title: "Solde",
                    titleColor: Colors.indigo,
                    icon: CupertinoIcons.arrow_right_circle_fill,
                    thikness: .1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inventoriesFilters(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                top: BorderSide(color: Colors.indigo, width: 2.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Filtrer par : ",
                    style: GoogleFonts.didactGothic(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const FilterBtn(
                    width: 80.0,
                    icon: Icons.filter_alt_rounded,
                    title: "Tous",
                    isSelected: true,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const FilterBtn(
                    icon: Icons.filter_list_sharp,
                    title: "Date",
                    width: 120.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  FilterDrop(
                    icon: Icons.filter_list_sharp,
                    data: const [
                      "Janvier",
                      "Février",
                      "Mars",
                      "Avril",
                      "Mai",
                      "Juin",
                      "..."
                    ],
                    hintText: "Mois",
                    onChanged: (value) {
                      debugPrint(value);
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  FilterDrop(
                    icon: Icons.filter_list_sharp,
                    data: const [
                      "Caisse",
                      "MPesa",
                      "Airtel money",
                      "Orange money",
                    ],
                    hintText: "Compte",
                    onChanged: (value) {
                      debugPrint(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  final List<Map> _inventories = [
    {
      'date': "02-03-22",
      "entree": 1500,
      "sortie": "0",
      "compte": "Caisse",
      "status": "actif",
    },
    {
      'date': "02-03-22",
      "entree": 1500,
      "sortie": "0",
      "compte": "Caisse",
      "status": "actif",
    },
    {
      'date': "02-03-22",
      "entree": 1500,
      "sortie": "0",
      "compte": "Caisse",
      "status": "actif",
    },
    {
      'date': "02-03-22",
      "entree": 1500,
      "sortie": "0",
      "compte": "Caisse",
      "status": "actif",
    },
  ];

  List<DataRow> _createRows() {
    return _inventories
        .map(
          (book) => DataRow(
            cells: [
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
                  book['entree'].toString(),
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  book['sortie'].toString(),
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  "1500",
                  style: GoogleFonts.didactGothic(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataCell(
                Text(
                  book['compte'].toString(),
                  style: GoogleFonts.didactGothic(
                    fontSize: 16,
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
                        inventoryDetailsModal(context);
                      },
                    ),
                    const SizedBox(
                      width: 5.0,
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

class SyntheseInfo extends StatelessWidget {
  final Color titleColor;
  final String title, currency;
  final double thikness;
  final double amount;
  final IconData icon;
  const SyntheseInfo({
    Key key,
    this.titleColor,
    this.title,
    this.thikness,
    this.amount,
    this.currency,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: thikness ?? .5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: titleColor,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.didactGothic(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: titleColor ?? Colors.green[700],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$amount",
                          style: GoogleFonts.staatliches(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20.0,
                          ),
                        ),
                        TextSpan(
                          text: " $currency",
                          style: GoogleFonts.didactGothic(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class XButton extends StatelessWidget {
  final bool isActived;
  final Function onPressed;
  const XButton({
    Key key,
    this.isActived,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.withOpacity(.3),
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            child: Row(
              children: [
                Text(
                  isActived ? "Réduire catégories" : "Voir catégories",
                  style: GoogleFonts.didactGothic(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Icon(
                  isActived
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: Colors.black,
                  size: 14.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
