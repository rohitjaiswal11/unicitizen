import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Blue_Buttons.dart';
import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';



class ChangeWalletNamePage extends StatefulWidget {
  const ChangeWalletNamePage({super.key});

  @override
  State<ChangeWalletNamePage> createState() => _ChangeWalletNamePageState();
}

class _ChangeWalletNamePageState extends State<ChangeWalletNamePage> {
  final walletNameController = TextEditingController();

  @override
  void initState() {
    ToastContext().init(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false, // Don't show the leading button

          leading:   Padding(
            padding: EdgeInsets.only(top: CustomDimension.myheight(context)/35),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,
                    size: 32, color: Colors.white)),
          ),
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: CustomDimension.myheight(context)/35),
            child: CustomFonts.heading20('Change Wallet Name', Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors:[ColorsCustom.darkPurple, ColorsCustom.lightPurple],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
            ),
          ),

        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Padding(
                  padding:  EdgeInsets.only(left: CustomDimension.mywidth(context)/20,right: CustomDimension.mywidth(context)/20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(height: height * 0.015),
                        orangecard(context,
                            toppadding: CustomDimension.myheight(context)/150,
                            leftpadding: CustomDimension.myheight(context)/35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: ColorsCustom.black12),
                            ),
                            mychild: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Enter valid Name';
                              },
                              controller: walletNameController,decoration:InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle:  TextStyle(
                                color: ColorsCustom.black38,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,

                              ),
                              labelStyle: TextStyle(
                                color: ColorsCustom.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),),)),
                      ]),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFonts.text12('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea .',
                    ColorsCustom.black38),

                SizedBox(height: height * 0.025),
                blueButton(width, height,
                    title: 'Save', padding: EdgeInsets.zero,onTap:(){
                     setState(() {
                       ConstantClass.Name=walletNameController.text.toString();
                       savedata();
                       ConstantClass.showToast(
                         'Name Saved',);
                       Navigator.pop(context);

                     });
                    } ),
              ],
            ),
          )
        ],
      ),
    );
  }
  savedata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', ConstantClass.Name.toString());

  }
}
