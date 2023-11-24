import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';




class About_Mnemonic extends StatefulWidget {
  const About_Mnemonic({super.key});

  @override
  State<About_Mnemonic> createState() => _About_MnemonicState();
}

class _About_MnemonicState extends State<About_Mnemonic> {
  bool show=false;
  TextEditingController password_controller = TextEditingController();
  String? title="About Mnemonic";

  Future<void> dontShow (bool show) async {
    if(show==true){
      ConstantClass.DontShowmnemonic=show;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('DontShowmnemonic', ConstantClass.DontShowmnemonic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        toolbarHeight: CustomDimension.myheight(context)/10,
        leading:   InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                size: 32, color: Colors.white)),
        centerTitle: true,
        title: CustomFonts.heading20(title.toString(), Colors.white),
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
      body: SingleChildScrollView(
        child: Container(
          height: CustomDimension.myheight(context)/1.15,
          padding:  EdgeInsets.symmetric(horizontal: CustomDimension.mywidth(context)/20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: CustomDimension.myheight(context)/40,),
                    CustomFonts.heading16500("What is Mnemonic?", ColorsCustom.black),
                    SizedBox(height:10),
                    CustomFonts.text12("Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et doloremagna aliqua. Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit involuptate velit esse cillum dolore eu fugiat nulla pariatur.",ColorsCustom.black38 ),
                    SizedBox(height: CustomDimension.myheight(context)/30,),
                    orangecard(context,
                        toppadding: CustomDimension.myheight(context)/55,
                        leftpadding: CustomDimension.mywidth(context)/25,
                        decoration:    BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(CustomImages.backgroundprivatekey),
                              scale: 1.6
                          ),
                          borderRadius:BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: ColorsCustom.grey.withOpacity(0.4)),),
                        mychild:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFonts.heading16500("How to keep it Secure?", ColorsCustom.black),
                            SizedBox(height:10),

                            ListTile(contentPadding: EdgeInsets.zero,
                              leading: CustomImages.Customimg(context, CustomImages.coldwallet,scale: 1.6),
                              title: CustomFonts.text12("Write it downor store it in an offline device\n such as a cold wallet.",ColorsCustom.black ),
                            ), SizedBox(height:10),

                            ListTile(contentPadding: EdgeInsets.zero,
                              leading: CustomImages.Customimg(context, CustomImages.screenshot,scale: 1.6),
                              title: CustomFonts.text12("Never store it by taking screenshot.",ColorsCustom.black ),
                            ), SizedBox(height:10),

                            ListTile(contentPadding: EdgeInsets.zero,
                              leading: CustomImages.Customimg(context, CustomImages.coldwallet,scale: 1.6),
                              title: CustomFonts.text12("Never store it in social media apps,emails,\n mobile memos,cloud services, etc.",ColorsCustom.black ),
                            ),

                          ],
                        )),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            checkColor: ColorsCustom.white,
                            activeColor: Color(0xff150CD1),
                            value: show,
                            side: BorderSide(
                              // ======> CHANGE THE BORDER COLOR HERE <======
                              color: Colors.grey,
                              // Give your checkbox border a custom width
                              width: 1.5,
                            ),
                            onChanged: (checked) {
                              setState(() {
                                show = checked!;
                              });
                              dontShow(show);
                            }),
                        CustomFonts.text12("Don't show this again",ColorsCustom.black38),
                      ],
                    ) ,
                  ],
                ),
                // SizedBox(height: CustomDimension.myheight(context)/3.5,),


              ]),
        ),
      ),
      bottomSheet:   Container(
        color: ColorsCustom.white.withOpacity(0.8),
        padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: InkWell(
          onTap: (){
           ConstantClass.enterPassword(context, false,false, 2);

          },
          child: orangecard(context,
            height: CustomDimension.myheight(context)/15,
            width: CustomDimension.myheight(context),
            toppadding: 10,
            leftpadding: 10,
            decoration:   const BoxDecoration(
              borderRadius:BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                colors: [
                  Color(0xff6E68EF),
                  Color(0xff150CD1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            mychild: Center(child: CustomFonts.text15("View Private Key", ColorsCustom.white)),
          ),
        ),
      ),
    );
  }




}
