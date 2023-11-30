import 'package:dappwallet/utils/export.dart';

class AppThemedata {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: AppColor.bluecolors,
    cardColor: AppColor.graycolors,
    hoverColor: AppColor.grayTextcolors,
    canvasColor: Colors.black,
    hintColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    dividerColor: AppColor.fadecolors,
    shadowColor: AppColor.lightbluecolors, // it use for bottom navigation bar
    textTheme: TextTheme(
      bodySmall: TextStyle(
          color: Colors.black87,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      bodyLarge: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      headlineSmall: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins"),
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        fontFamily: "Poppins",
      ),
      headlineLarge: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: "Poppins"),
    ),
  );
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Colors.black87,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: AppColor.bluecolors,
    cardColor: AppColor.graycolorsdark,
    hoverColor: AppColor.grayTextcolorsdark,
    canvasColor: Colors.white,
    hintColor: Colors.white,
    shadowColor: AppColor.lightbluecolorsdark,
    dialogBackgroundColor: Colors.black87,
    dividerColor: AppColor.fadecolorsdark,
    textTheme: TextTheme(
      bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins"),
      headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          fontFamily: "Poppins"),
      headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: "Poppins"),
    ),
  );
}
