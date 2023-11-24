import 'package:flutter/material.dart';

import 'Fonts.dart';

Widget blueButton(double width, double height,
    {Function()? onTap, EdgeInsetsGeometry? padding, required String title}) {
  return Padding(
    padding: padding ??
        EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.05),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color(0xFF150CD1),
            Color(0xFF6E68EF),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: CustomFonts.text15(
          title, Colors.white,
        ),
      ),
    ),
  );
}
