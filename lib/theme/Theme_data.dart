import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.black,
    hintColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    colorScheme: ColorScheme.dark(
      background: Colors.white,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
      ),
    ));




ThemeData darktheme = ThemeData
  (
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    canvasColor: Colors.white,
    hintColor: Colors.white,
    dividerColor: Colors.orange,
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.black)
    ),
    dialogBackgroundColor: Colors.black87,
    colorScheme: ColorScheme.dark(

      background: Colors.black,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
        )
    )
);
