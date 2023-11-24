import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';


class UncollectedYields extends StatefulWidget {
  const UncollectedYields({super.key});

  @override
  State<UncollectedYields> createState() => _UncollectedYieldsState();
}

class _UncollectedYieldsState extends State<UncollectedYields> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: CustomDimension.myheight(context),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Color(0xff231f63),
                Color(0xff030035),
              ],
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: CustomDimension.myheight(context)/ 15,left: CustomDimension.mywidth(context)/20
                    ,right: CustomDimension.mywidth(context)/20 ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              size: 32, color: Colors.white)),
                      SizedBox(width: CustomDimension.mywidth(context)/5,),
                      CustomFonts.heading18(
                          'Uncollected Yields', Colors.white),]
                ),
              ),
              SizedBox(height: CustomDimension.myheight(context) * 0.03),
              Padding(
                padding:  EdgeInsets.only(left: CustomDimension.mywidth(context)/20
                    ,right: CustomDimension.mywidth(context)/20,),
                child: orangecard(context,
                  width: CustomDimension.mywidth(context),
                  toppadding: 20,
                  leftpadding: 20,
                  decoration:   BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff443755),
                        Color(0xff402748),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  mychild: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomFonts.text12("Total Yields uncollected", ColorsCustom.white),
                              SizedBox(width: 10,),
                              CustomImages.Customimg(context, CustomImages.question, scale:3.0),
                            ],
                          ),
                          SizedBox(height: 10,),

                          CustomFonts.Text16("\$0", Color(0XFFDDAE36)),
                          SizedBox(height: 10,),

                          CustomFonts.text12("LBM (GBJWMBCSAZN)", Color(0XFFDDAE36)),

                        ],
                      ),
                      CustomImages.Customimg(context, CustomImages.uncollectedyield,scale: 1.5),

                    ],
                  )
                ),
              ),
              SizedBox(height: CustomDimension.myheight(context) * 0.03),
              orangecard(context,
                height: CustomDimension.myheight(context)/1.4,
                width: CustomDimension.myheight(context),
                toppadding: 15,
                leftpadding: 15,
                mychild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: CustomDimension.myheight(context) / 40,),
                      Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),

                      decoration: BoxDecoration(
                      color: ColorsCustom.white,
                      boxShadow: [
                      BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 5, //New
                      ),
                      ],
                      borderRadius: const BorderRadius.all(
                      Radius.circular(12)),

                      ),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      ListTile(contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                      CustomImages.trx),
                      ),
                      title: CustomFonts.text14(
                      "TRON Stake 2.0",
                      ColorsCustom.black),
                      subtitle: CustomFonts.text10(
                      "TRON DAO",
                      ColorsCustom.black),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: ColorsCustom.black26)
                        ),
                      padding: EdgeInsets.only(top: 3,bottom: 3,left: 5,right: 5),
                      child: CustomFonts.text10("Collect", ColorsCustom.black26),
                      ),
                      ),
                      Divider(color:  ColorsCustom.black12,),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      CustomFonts.text10(
                      "Uncollected Mining Rewards", ColorsCustom.black38),
                      const SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomFonts.text12(
                          " 0 USDT", ColorsCustom.black),
                          CustomFonts.text10(
                          " \$0", ColorsCustom.black26),
                        ],
                      ),
                    ],
                    ),
                    ],
                    )
                    ,
                    ),



                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffffffff),
                      Color(0xffffffff),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}
