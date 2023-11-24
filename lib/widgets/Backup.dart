import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';


import 'Backup_Mnemonic.dart';

class BackUpMnemonic extends StatefulWidget {
  const BackUpMnemonic({super.key});

  @override
  State<BackUpMnemonic> createState() => _BackUpMnemonicState();
}

class _BackUpMnemonicState extends State<BackUpMnemonic> {


  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset("Assets/Register/anim.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(false);
      setState(() {
        _controller.play();
      });
    });
  }





    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomDimension.myheight(context)/9,
        leading:  Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context)/35),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,
                  size: 32, color: ColorsCustom.black)),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context)/35),
          child: CustomFonts.heading20('Back Up Mnemonic', ColorsCustom.black),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: CustomDimension.mywidth(context)/20,right: CustomDimension.mywidth(context)/20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisAlignment: MainAxisAlignment.start,
           children: [
             SizedBox(height:  CustomDimension.myheight(context)/45,),

             CustomFonts.text12("The mnemonic of 12-24 words is your private key.\n Please be sure to store your mnemonic safely, as you\n will lose access to your assets should you lose your\n mnemonic.", ColorsCustom.black.withOpacity(0.5)),
             SizedBox(height: 15,),
             Container(
               // color: Colors.,
                 height: CustomDimension.myheight(context)/2,
                 width: CustomDimension.mywidth(context),
                 child: VideoPlayer(_controller)),
             Spacer(),
             Center(child: CustomFonts.text11("Please write down the mnemonic on piese of paper \n                        and keep it offline.", ColorsCustom.black.withOpacity(0.5))),

             SizedBox(height: 15,),
             InkWell(
               onTap: (){

                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  BackUp_Mnemonic(view: false,)));

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
                       Color(0xff130c06),
                       Color(0xff130c06),
                     ],
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                   ),
                 ),
                 mychild: Center(child: CustomFonts.text15("Back Up Now", ColorsCustom.white)),
               ),
             ),
             SizedBox(height: 15,),
           ],
         ),



      ),
    );
  }
}
