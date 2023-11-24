// ignore_for_file: no_logic_in_create_state

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/Colors.dart';
import '../utils/CustomImages.dart';



class BottomNavigation extends StatefulWidget {
  int? index;
  int? swapindex;
   BottomNavigation({super.key, this.index,this.swapindex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState(index,swapindex);
}

class _BottomNavigationState extends State<BottomNavigation> {


  int? _selectedIndex;
  int? swapindexs;

  _BottomNavigationState(this._selectedIndex,this.swapindexs);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static  final List<Widget> _pages = <Widget>[
   // const HomePage(),
   //  Earn_Swap(),
   //  Discover_Screen(),
   // const MyWalletPage(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex!),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex!,
        showUnselectedLabels: true,
        elevation:0,

        onTap: _onItemTapped,
        selectedLabelStyle:  const TextStyle(color: Color(0xff3c34d9),fontSize: 12.2,fontFamily: 'Poppins',fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(color: ColorsCustom.black54,fontSize: 12.2,fontFamily: 'Poppins',fontWeight: FontWeight.w500),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  CustomImages.Customimg(context,CustomImages.home,scale: 1.8,color: _selectedIndex==0?const Color(0xff3c34d9):ColorsCustom.black54),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomImages.Customimg(context,CustomImages.market,scale:1.8,color: _selectedIndex==1?const Color(0xff3c34d9):ColorsCustom.black54),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: CustomImages.Customimg(context,CustomImages.discover,scale:1.8,color: _selectedIndex==2?const Color(0xff3c34d9):ColorsCustom.black54),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: CustomImages.Customimg(context,CustomImages.profile,scale:1.8,color: _selectedIndex==3?const Color(0xff3c34d9):ColorsCustom.black54),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


