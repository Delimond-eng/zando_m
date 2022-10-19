import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/topbar.dart';
import '../../widgets/round_icon_btn.dart';

showStockDetails(BuildContext context) {
  showDialog(
    barrierColor: Colors.black12,
    context: context,
    builder: (BuildContext context) {
      return FadeInUp(
        child: Dialog(
          insetPadding: const EdgeInsets.all(20.0),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ), //this right here
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TopBar(
                  color: Colors.indigo,
                  height: 70.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stock détails",
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
              ],
            ),
          ),
        ),
      );
    },
  );
}
