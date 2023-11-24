import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicitizen/Screens/Graph_screen.dart';
import 'package:unicitizen/Utility/button.dart';

import '../../Utility/custm_container.dart';
import '../wallets/wallets.dart';

class BinanceTrx extends StatelessWidget {
  const BinanceTrx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Binance USD(BUSD)"),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 30,
            ),
            CustomContainer(
              imagePath: "assets/coins/btc.png",
              firstColumnText1: "Binance USD",
              firstColumnText2: "USD 1.002",
              secondColumnText1: "Bal- 0.0 BUSD",
              secondColumnText2: "0.027",
              txt2color: Colors.green,
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    btnname: "send",
                    pressed: () {},
                    width: Get.width / 2.3,
                    height: Get.height / 18,
                    iconwidget: Image.asset("assets/dashboard/send.png", height: 25,)),
                CustomButton(
                    btnname: "Receive",
                    pressed: () {},
                    width: Get.width / 2.3,
                    height: Get.height / 18,
                    iconwidget: Image.asset("assets/dashboard/receive.png",height: 25)),
              ],
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Container(
      
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Image.asset("assets/dashboard/image.png"),
            ),
      
      
            Text("Transcation will appear Here", style: TextStyle(
              fontSize: 16
            ),)
      
      
      
          ],
      
      
          
        ),
      ),

      bottomSheet: Container(color: Colors.grey.shade100, width: Get.width,
      padding: const EdgeInsets.all(15.0),
        child: CustomButton(
            btnname: "BUY",
            pressed: () {
         Get.to(
          
          
        Garph_Screen()
          );
            }),
      ),
      
    );
  }
}
