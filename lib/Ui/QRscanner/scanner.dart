import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class QRScneer extends StatelessWidget {
  const QRScneer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          "Receive BUSD(BEP20)",
        ),
        //      titleTextStyle: TextStyle(color: Colors.white),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: Get.height * 0.4,
              width: Get.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    "gfxdhfhfvbcvbxxcvbfhfbvcxfghfbbvbhfdghvzdgdgdfgdfg",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height / 60,
                  ),
                  Image(
                    image: AssetImage("assets/qr/qr.png"),
                    height: Get.height * 0.27,
                  )
                ],
              ),
            ),     SizedBox(

          height: Get.height/30,
        ),
            Text(
              "Send only Binance USD (BEP20) to this address.\nSending any other coins may result in \npermanent loss.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),     SizedBox(

          height: Get.height/20,
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                row_bottom_menu("assets/qr/copy.png", "Copy"),
                row_bottom_menu("assets/qr/amount.png", "Set Amount"),
                row_bottom_menu("assets/qr/share.png", "Share"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column row_bottom_menu(String img, String txt) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: Get.height / 15,
          width: Get.height / 15,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffb000000), Color(0xff262626)],
                  begin: Alignment.topLeft,
                  stops: [0.1, 0.9]),

//color: Colors.grey,
              shape: BoxShape.circle),
          child: Image.asset(img),
        ),
        SizedBox(

          height: Get.height/40,
        ),
        Text(
          txt,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        )
      ],
    );
  }
}
