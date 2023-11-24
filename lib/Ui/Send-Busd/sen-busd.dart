// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:unicitizen/Ui/Send/coin_modal.dart';
import 'package:unicitizen/Utility/custm_container.dart';
import 'package:unicitizen/Utility/button.dart';

import '../SelectCrypto/selectcrypto.dart';

class SendBUSD extends StatelessWidget {
  const SendBUSD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
       // automaticallyImplyLeading: false,
        title: Text("Send BUSD(BEP20)"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20,),
          Text(
            "Recipient Address",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              container_grey(
                  height: Get.height / 20,
                  width: Get.width * 0.55,
                  w1: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  )),
              container_grey(
                  height: Get.height / 20,
                  w1: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FaIcon(FontAwesomeIcons.expand),
                  )),
              container_grey(
                  width: Get.width / 6,
                  height: Get.height / 20,
                  w1: Center(
                      child: Text(
                    "Paste",
                    style: TextStyle(fontSize: 15),
                  ))),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Amount BUSD",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              container_grey(
                  height: Get.height / 20,
                  width: Get.width * 0.55,
                  w1: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  )),
              container_grey(
                  height: Get.height / 20,
                  w1: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Max",
                      style: TextStyle(fontSize: 17),
                    ),
                  )),
              container_grey(
                  width: Get.width / 6,
                  height: Get.height / 20,
                  w1: Center(
                      child: Text(
                    "Paste",
                    style: TextStyle(fontSize: 15),
                  ))),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Optional",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recipient Address",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              container_grey(
                  height: Get.height / 20,
                  width: Get.width * 0.6,
                  w1: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  )),
              container_grey(
                  height: Get.height / 20,
                  w1: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Max",
                      style: TextStyle(fontSize: 17),
                    ),
                  )),
              container_grey(
                  width: Get.width / 6,
                  height: Get.height / 20,
                  w1: Center(
                    child: FaIcon(FontAwesomeIcons.circleExclamation),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text("Estimated Transcation Fee - 0.000456BNB",
              style: TextStyle(fontSize: 16))
        ]),
      ),
      bottomSheet: Container(color: Colors.grey.shade100, width: Get.width,
      padding: const EdgeInsets.all(15.0),
        child: CustomButton(
            btnname: "SEND",
            pressed: () {
              Get.to(SelectCrypto());
            }),
      ),
    );
  }
}

class container_grey extends StatelessWidget {
  Widget w1;
  double? height;
  double? width;

  container_grey({
    Key? key,
    required this.w1,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      child: w1,
    );
  }
}
