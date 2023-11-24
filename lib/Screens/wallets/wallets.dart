import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicitizen/utils/custm_container.dart';

import '../PriceAlert/pricealert.dart';

class Wallets extends StatelessWidget {
  const Wallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Wallet"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.all(15),
            height: Get.height / 20,
            width: Get.height / 30,
            child: Icon(
              Icons.add,
              color: Colors.orange,
            ),
            decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle),
          )
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SizedBox(height: 20,),
            Text(
              "Multi-Coin Wallets",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),SizedBox(height: 20,),
            InkWell(

              onTap: () => Get.to(PriceAlert()),
              child: CustomContainer(
                imagePath: "assets/nav/icon_card.png",
                imgColrContainer: Colors.orange.shade100,
                firstColumnText1: "Wallet 1",
                firstColumnText2: "Multi Coin Wallet",
                actionWidget: Icon(Icons.more_horiz),
              ),
            )
          ],
        ),
      ),
    );
  }
}
