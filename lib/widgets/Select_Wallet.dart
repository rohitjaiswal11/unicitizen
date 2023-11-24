import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../Screens/AddWalletPage.dart';
import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';



class Select_Wallet extends StatefulWidget {
  const Select_Wallet({super.key});

  @override
  State<Select_Wallet> createState() => _Select_WalletState();
}

class _Select_WalletState extends State<Select_Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomDimension.myheight(context)/9,
        automaticallyImplyLeading: false, // Don't show the leading button
        leading:   InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                size: 32, color: Colors.white)),
        centerTitle: true,
        title: CustomFonts.heading20("Select Wallet", Colors.white),
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddWalletPage()));


            },
            child: Padding(
              padding:  EdgeInsets.only(right: CustomDimension.myheight(context)/55),
              child: Image.asset(
                CustomImages.walletselect,
                height: 22,
                width: 22,
              ),
            ),
          ),
          InkWell(
            onTap: (){
            },
            child: Padding(
              padding:  EdgeInsets.only(right: CustomDimension.myheight(context)/55 ),
              child: Image.asset(
                CustomImages.exchangeselect,
                height: 25,
                width: 25,
              ),
            ),
          ),


        ],
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
      body: Container(
        height: CustomDimension.myheight(context),
        child: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context)/30),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: CustomDimension.mywidth(context) / 20,
            right: CustomDimension.mywidth(context) / 20),
                child: Row(
                  children: [
                    CustomImages.Customimg(context, CustomImages.wallet,scale: 1.2,color: ColorsCustom.black),
                    SizedBox(width: 15,),
                    CustomFonts.heading16("Hot Wallet", ColorsCustom.black),
                  ],
                ),
              ),
              SizedBox(height: CustomDimension.myheight(context)/30,),

              orangecard(context,
                toppadding: CustomDimension.myheight(context)/55,
                leftpadding: CustomDimension.mywidth(context)/25,
                decoration:    BoxDecoration(
                  borderRadius:BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 15
                    ),
                  ],
                  color: Color(0xffEF9E47).withOpacity(0.1),),

                mychild: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomFonts.heading16("HD", ColorsCustom.black),
                        SizedBox(width: 5,),
                        CustomImages.Customimg(context, CustomImages.question,scale: 3,color: ColorsCustom.black38),
                        Spacer(),
                        CustomFonts.text12("Total Value: 0 TRX", ColorsCustom.black),
                      ],
                    ),
                    SizedBox(height: CustomDimension.myheight(context)/50,),

                    orangecard(context,
                      toppadding: CustomDimension.myheight(context)/55,
                      leftpadding: CustomDimension.mywidth(context)/25,
                      decoration:    BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(15)),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffeeb954),
                              Color(0xfff59141),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),),

                      mychild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomFonts.text12("Navjot", ColorsCustom.white),
                              Icon(Icons.check_circle,color: ColorsCustom.black,size: 25),
                            ],
                          ),
                          SizedBox(height: CustomDimension.myheight(context)/55,),
                          CustomFonts.heading22("0 TRX", ColorsCustom.white),
                          Row(
                            children: [
                              CustomFonts.text12("hjdjsnjksjkxnasjknxjknkjsankajns", ColorsCustom.white),
                              SizedBox(width: 10,),
                              Icon(Icons.copy,size: 20,color: ColorsCustom.white,),
                            ],
                          ),
                          SizedBox(height: CustomDimension.myheight(context)/55,),
                          orangecard(context,
                          toppadding: 5,leftpadding: 5,
                            decoration: BoxDecoration(
                              color: ColorsCustom.white24,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            mychild: CustomFonts.text12("Path:m/44/4554/5445", ColorsCustom.white),
                          )

                        ],
                      )

                    ),
                  ],
                )

              ),

              // SizedBox(height: CustomDimension.myheight(context)/20,),
              //
              //
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: CustomDimension.mywidth(context) / 20,
                    right: CustomDimension.mywidth(context) / 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: orangecard(context,
                    height: CustomDimension.myheight(context)/20,
                    width: CustomDimension.mywidth(context)/1.8,
                    toppadding: 0,
                    leftpadding: CustomDimension.mywidth(context)/35,
                    decoration:    BoxDecoration(
                      borderRadius:BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 15
                        ),
                      ],
                      color: ColorsCustom.white,),

                    mychild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time,color: ColorsCustom.grey.withOpacity(0.4),size: 30,),
                        Icon(Icons.account_balance_wallet_outlined,color: ColorsCustom.black,size: 30),
                        CustomImages.Customimg(context, CustomImages.securitytick,scale: 1.5),
                        CustomImages.Customimg(context, CustomImages.snow,scale: 1.5),
                        Icon(Icons.search,color: ColorsCustom.grey.withOpacity(0.4),size: 30),

                      ],
                    )

                  ),
                ),
              ),
              SizedBox(height: CustomDimension.myheight(context)/30,),



            ],
          ),
        ),
      )
    );
  }
}
