import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicitizen/Screens/dashboard/dashboard.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 3     : market',
    ),
  ];

  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <Image>[
    Image.asset("assets/nav/icon_card.png",
        height: 10, width: 5, fit: BoxFit.contain),

    Image.asset(
      "assets/nav/Wallet.png",
      // color: Colors.blue,
      fit: BoxFit.contain,
    ),
    Image.asset(
      "assets/nav/order-history.png",
      //  color: Colors.blue,
    ),
    Image.asset(
      "assets/nav/logout.png", height: 2, width: 5,
      //   color: Colors.blue,
    ),
    // FontAwesomeIcons.creditCard, FontAwesomeIcons.wallet,
    // FontAwesomeIcons.jediOrder, FontAwesomeIcons.creditCard,
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: _widgetOptions.elementAt(_bottomNavIndex),
      )), //destination screen
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.orange,

//           gradient: LinearGradient(colors: [
//               Colors.yellow,

//              Colors.orange,  Colors.yellow, Colors.yellow,
// // Color.fromARGB(1,233, 112, 0,),
// // Color.fromARGB(1,225, 176, 0,),
// // Color.fromARGB(1,255, 137, 0),
// //  Color.fromARGB(1,255, 255, 255)

//           ]

          //    ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {},
          child: Image.asset(
            height: 20,
            "assets/nav/dashboard.png",
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        iconSize: 20,
        activeColor: Colors.orange,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        height: 70,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
