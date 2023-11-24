import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:unicitizen/Screens/profile.dart';

import '../Controller/theme.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import 'Create_Wallet.dart';
import 'ImportWalletPage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 
  TabController? tabController;
  int listindex = 0;
  bool? diverse = true, secure = false, convenient = false;
  late PageController _pageController;
  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;

  @override
  void initState() {
    // MnemonicCreater();
    // TrustWalletCoreLib.init();
    // _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusbatheight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        height: CustomDimension.myheight(context),
        width: CustomDimension.mywidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            diverse == true
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: CustomDimension.myheight(context) / 15,
                            left: CustomDimension.mywidth(context) / 20,
                            right: CustomDimension.mywidth(context) / 20),
                        child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 0),
                            ),
                            CustomFonts.text12("Switch to cold Wallet mode",
                                Theme.of(context).textTheme.bodyLarge!.color!),
                            // Text("no data tect is ",style: CustomFonts.sty(context).copyWith(fontSize: 19,fontWeight: FontWeight.w200),),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomImages.Customimg(
                                context, CustomImages.exchange,
                                scale: 4.0, color: ColorsCustom.black),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: CustomDimension.myheight(context) / 45,
                      ),
                      CustomFonts.text18("The most well-rounded UNI features",
                          ColorsCustom.black),
                      CustomFonts.text11next(
                          "Full support for UNI and all types of Mainnet tokens\n                          and functions",
                          ColorsCustom.black.withOpacity(0.5)),
                      SizedBox(
                        height: CustomDimension.myheight(context) / 50,
                      ),
                      Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          width: double.infinity,
                          height: CustomDimension.myheight(context) / 2,
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //       image: AssetImage(CustomImages.handback),
                          //       alignment: Alignment.bottomRight,
                          //       scale: 1.8),
                          // ),
                          child: AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: -120,
                              child: Align(
                                  alignment: Alignment(-0.01, 0.1),
                                 child: Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 60, vertical: 60),
    child: Image.asset(
    CustomImages.Diverse,
    scale: 1.0,
    ),
    )),
                            ),
                          ))
                    ],
                  )
                : secure == true
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: CustomDimension.myheight(context) / 15,
                                left: CustomDimension.mywidth(context) / 20,
                                right: CustomDimension.mywidth(context) / 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomFonts.text12("Switch to cold Wallet mode",
                                    ColorsCustom.black),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomImages.Customimg(
                                    context, CustomImages.exchange,
                                    scale: 4.0, color: ColorsCustom.black),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: CustomDimension.myheight(context) / 80,
                          ),
                          CustomFonts.text18(
                              "The most secure asset management \noption",
                              ColorsCustom.black),
                          CustomFonts.text11(
                              "Multi-layer protection guarantee by the POX security\n team and private key holding by yourself ",
                              ColorsCustom.black.withOpacity(0.5)),
                          // SizedBox(height:  CustomDimension.myheight(context)/120,),
                          AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: const Duration(milliseconds: 500),
                            child: Container(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                width: double.infinity,
                                height: CustomDimension.myheight(context) / 2,
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //       image: AssetImage(CustomImages.handback),
                                //       alignment: Alignment.bottomRight,
                                //       scale: 1.8),
                                // ),
                                child: Align(
                                    alignment: Alignment(-0.01, 0.1),
                                    child: SlideAnimation(
                                        horizontalOffset: -120,
                                        // verticalOffset: 120.0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 80, vertical: 80),
                                          child: Image.asset(
                                            CustomImages.secure,
                                            scale: 1.0,
                                          ),
                                        )))),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: CustomDimension.myheight(context) / 15,
                                left: CustomDimension.mywidth(context) / 20,
                                right: CustomDimension.mywidth(context) / 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomFonts.text12("Switch to cold Wallet mode",
                                    ColorsCustom.black),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomImages.Customimg(
                                    context, CustomImages.exchange,
                                    scale: 4.0, color: ColorsCustom.black),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: CustomDimension.myheight(context) / 45,
                          ),
                          CustomFonts.text18(
                              "The most convenient user experience",
                              ColorsCustom.black),
                          CustomFonts.text11(
                              "One-click wallet creation to get started easily; multiple\n accounts to achieve unified management",
                              ColorsCustom.black.withOpacity(0.5)),
                          SizedBox(
                            height: CustomDimension.myheight(context) / 50,
                          ),
                          Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              width: double.infinity,
                              height: CustomDimension.myheight(context) / 2,
                              child: AnimationConfiguration.staggeredList(
                                position: 1,
                                duration: const Duration(milliseconds: 500),
                                child: SlideAnimation(
                                  verticalOffset: -120,
                                  child: Align(
                                      alignment: Alignment(-0.01, 0.5),
                                        child: Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 40, vertical: 40),
    child: Image.asset(
    CustomImages.images,
    scale: 1.0,
    ),
    )),
                                ),
                              ))
                        ],
                      ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomDimension.mywidth(context) / 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            diverse = true;
                            secure = false;
                            convenient = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              CustomFonts.text14(
                                  "Diverse",
                                  diverse == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.black.withOpacity(0.4)),
                              CustomImages.Customimg(
                                  context, CustomImages.linetabs,
                                  scale: 2.0,
                                  color: diverse == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.transparent,
                                  height: 3),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            diverse = false;
                            secure = true;
                            convenient = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              CustomFonts.text14(
                                  "Secure",
                                  secure == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.black.withOpacity(0.4)),
                              CustomImages.Customimg(
                                  context, CustomImages.linetabs,
                                  scale: 2.0,
                                  color: secure == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.transparent,
                                  height: 3),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            diverse = false;
                            secure = false;
                            convenient = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              CustomFonts.text14(
                                  "Convenient",
                                  convenient == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.black.withOpacity(0.4)),
                              CustomImages.Customimg(
                                  context, CustomImages.linetabs,
                                  scale: 2.0,
                                  color: convenient == true
                                      ? Color(0xff423BB4)
                                      : ColorsCustom.transparent,
                                  height: 3,
                                  width: 80),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                orangecard(context,
                    height:
                        (CustomDimension.myheight(context) - statusbatheight) /
                            5,
                    width: CustomDimension.myheight(context) / 0,
                    toppadding: CustomDimension.myheight(context) / 50,
                    leftpadding: 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25)),
                      color: Color(0xff423BB4),
                    ),
                    mychild: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Create_Wallet()));

                                /////Cretawallet
                              },
                              child: Container(
                                  // height: CustomDimension.myheight(context)/12,
                                  width: CustomDimension.mywidth(context) / 2.3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical:
                                          CustomDimension.myheight(context) /
                                              50),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: ColorsCustom.white),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImages.Customimg(
                                          context, CustomImages.plus,
                                          scale: 2.0,
                                          color: ColorsCustom.black),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomFonts.text15(
                                          "Create Wallet", ColorsCustom.black),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ImportWalletPage(false)));
                              },
                              child: Container(
                                  // height: CustomDimension.myheight(context)/12,
                                  width: CustomDimension.mywidth(context) / 2.3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3,
                                      vertical:
                                          CustomDimension.myheight(context) /
                                              50),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff181309),
                                        Color(0xff130c06),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_download_outlined,
                                        color: ColorsCustom.white,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomFonts.text15(
                                          "Import Wallet", ColorsCustom.white),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  CustomDimension.mywidth(context) / 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           PairColdWalletPage(),
                                  //     ),
                                  //   );
                                  // },
                                  child: CustomFonts.text11underline(
                                      "Pair Cold Wallet", ColorsCustom.white)),
                              InkWell(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => WatchOnlyPage(),
                                  //     ),
                                  //   );
                                  // },
                                  child: CustomFonts.text11underline(
                                      "Watch-only wallet", ColorsCustom.white)),
                              InkWell(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           AddNewDevicePage(),
                                  //     ),
                                  //   );
                                  // },
                                  child: CustomFonts.text11underline(
                                      "Ledger", ColorsCustom.white)),
                            ],
                          ),
                        ),
                        // SizedBox(height:  CustomDimension.myheight(context)/65,),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

}


