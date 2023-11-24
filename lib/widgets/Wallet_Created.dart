import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';


import 'Backup.dart';

class Wallet_Created extends StatefulWidget {
  const Wallet_Created({super.key});

  @override
  State<Wallet_Created> createState() => _Wallet_CreatedState();
}

class _Wallet_CreatedState extends State<Wallet_Created> {
  @override
  void initState() {
    // mysharedData();
    // TODO: implement initState
    super.initState();
  }

  // Future<void> mysharedData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('name', ConstantClass.Name.toString());
  //   await prefs.setString('password', ConstantClass.password.toString());
  //   await prefs.setString('wallet', ConstantClass.wallet.toString());
  //   await prefs.setString('seedPhrase', ConstantClass.mnemonic.toString());
  //   await prefs.setString('fakewallet', ConstantClass.fakewallet.toString());
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomDimension.myheight(context) / 9,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 32, color: ColorsCustom.black)),
        centerTitle: true,
        title: CustomFonts.heading20('Create Wallet', ColorsCustom.black),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: CustomDimension.mywidth(context) / 20,
            right: CustomDimension.mywidth(context) / 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImages.Customimg(context, CustomImages.thumbup,
                    scale: 1.8),
                SizedBox(
                  height: CustomDimension.myheight(context) / 75,
                ),
                CustomFonts.heading18("Wallet Created", ColorsCustom.black),
                CustomFonts.text11(
                    "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempor \n "
                    "incididunt ut labore et dolore magna \n aliqua. Ut enim",
                    ColorsCustom.black.withOpacity(0.5)),
                 SizedBox(height:  CustomDimension.myheight(context)/15,),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BackUpMnemonic()));

              },
              child: orangecard(
                context,
                height: CustomDimension.myheight(context) / 15,
                width: CustomDimension.myheight(context),
                toppadding: 10,
                leftpadding: 10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff130c06),
                      Color(0xff130c06),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                mychild: Center(
                    child:
                        CustomFonts.text15("Back Up Now", ColorsCustom.white)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
