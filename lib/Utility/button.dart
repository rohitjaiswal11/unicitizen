// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../UI/SelectCrypto/selectcrypto.dart';

class CustomButton extends StatelessWidget {
  String btnname;
  double ?width;
    double ?height;
  VoidCallback pressed;
  Widget? iconwidget;
  Color? textcolor;
  Color?backcolor;
  CustomButton({
    Key? key,
    this. width,
      this. height,
    required this.btnname,
    required this.pressed,
    this.iconwidget,
    this.textcolor,this.backcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Container(
        // padding: EdgeInsets.all(10),
        height: height??Get.height / 15,
       width:width?? Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13), color:backcolor?? Colors.black),

        child: Center(
            child: Row( mainAxisAlignment: 
            MainAxisAlignment.center,
          children: [
           iconwidget?? SizedBox(),
            Text(
              btnname,
              style: TextStyle(color: textcolor??Colors.white, fontSize: 18),
            ),
          ],
        )),
      ),
    );
  }
}
