import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/topbar.dart';
import '../../widgets/round_icon_btn.dart';

sellingInfoModal(BuildContext context) {
  showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return FadeInLeft(
        child: Dialog(
          insetPadding: const EdgeInsets.all(20.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ), //this right here
          child: Container(
            color: Colors.grey[100],
            height: 180,
            width: MediaQuery.of(context).size.width / 1.80,
            child: Column(
              children: [
                TopBar(
                  color: Colors.blue,
                  height: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Situation des ventes journalières",
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
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.5,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: 3,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
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
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: .5,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.mobile_friendly,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Cash",
                                        style: GoogleFonts.didactGothic(
                                          color: Colors.blue,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "400",
                                              style: GoogleFonts.staatliches(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "  USD",
                                              style: GoogleFonts.didactGothic(
                                                color: Colors.grey[600],
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
