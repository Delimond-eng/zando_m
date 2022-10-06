import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotItem extends StatelessWidget {
  final MainAxisAlignment alignment;
  final String title;
  final String value;
  final String currency;
  const TotItem({
    Key key,
    this.alignment,
    this.value,
    this.currency,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300])),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: alignment ?? MainAxisAlignment.end,
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " $value ",
                      style: GoogleFonts.staatliches(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: " $currency",
                      style: GoogleFonts.didactGothic(
                        color: Colors.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
