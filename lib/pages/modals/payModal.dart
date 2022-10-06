import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_m/widgets/costum_dropdown.dart';

import '../../components/topbar.dart';
import '../../widgets/round_icon_btn.dart';
import '../../widgets/simple_field_text.dart';

showPayModal(BuildContext context) {
  showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return FadeInRight(
        child: Dialog(
          insetPadding: const EdgeInsets.all(20.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ), //this right here
          child: Container(
            color: Colors.white,
            height: 350.0,
            width: MediaQuery.of(context).size.width / 1.80,
            child: Column(
              children: [
                TopBar(
                  color: Colors.green,
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Paiement facture",
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SimpleField(
                          hintText: "Saisir le montant paiement... ",
                          iconColor: Colors.green,
                          icon: CupertinoIcons.money_dollar_circle_fill,
                          title: "Montant paiement",
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: DropField(
                                filledColor: Colors.grey[300],
                                hintText: "Sélectionnez le mode de paiement",
                                icon: CupertinoIcons.creditcard,
                                iconColor: Colors.green,
                                onChanged: (value) {
                                  debugPrint(value);
                                },
                                data: const [
                                  "Cash",
                                  "Virement",
                                  "Chèque",
                                  "Paiement mobile",
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Flexible(
                              child: DropField(
                                filledColor: Colors.grey[300],
                                hintText: "Sélectionnez un compte",
                                icon: CupertinoIcons.archivebox_fill,
                                iconColor: Colors.green,
                                onChanged: (value) {
                                  debugPrint(value);
                                },
                                data: const [
                                  "Caisse",
                                  "Orange money",
                                  "MPESA",
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                          "Annuler",
                          style: GoogleFonts.didactGothic(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20.0),
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Valider le paiement",
                          style: GoogleFonts.didactGothic(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
