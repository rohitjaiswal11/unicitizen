import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicitizen/Controller/theme.dart';
import 'package:unicitizen/Screens/Register_1.dart';
import 'package:unicitizen/UI/dashboard/dashboard.dart';
import 'package:unicitizen/theme/themedata.dart';
import 'package:unicitizen/Utility/bottom_navigation.dart';
import 'package:unicitizen/Utility/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<themedata>(builder: (child) {
     // child.getshared();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
       // themeMode: child.gettheme,
        theme: AppThemedata.light,
        darkTheme: AppThemedata.dark,
        defaultTransition: Transition.topLevel,
        // getPages: AppRoute.pages,
        // initialRoute: AppRoute.dashboard,

        home: Register()
        //  BottomNavBar(),
      );
    
    //);
  }
}
