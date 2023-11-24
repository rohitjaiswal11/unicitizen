import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicitizen/Screens/QRscanner/scanner.dart';

import '../../utils/custm_container.dart';
import '../Send/coin_modal.dart';

class PriceAlert extends StatefulWidget {
  const PriceAlert({super.key});

  @override
  State<PriceAlert> createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
    bool tap= true;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Price Alert"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                height: Get.height / 15,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListTile(
                    title: Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    trailing: Switch(
                        trackOutlineWidth: MaterialStatePropertyAll(100),
                        splashRadius: 0.1,
                        //    activeTrackColor: Colors.white,
                        thumbColor: MaterialStatePropertyAll(
                          Colors.white,
                        ),
                        activeColor: Colors.black,
                        value: tap,
                        
                        onChanged: (value) {


                          print("TAP $tap");
                          setState(() {
                            tap=value;
                          });
                        }),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Text(
                "Get Alerts for significant price changes of your favourite cryptocurrency",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              child:               ListView.separated(
              
                                  shrinkWrap: true,
              
                                  itemBuilder: (context, index) {
              
                                    return Padding(
              
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
              
                                      child: InkWell(
              
                                        onTap: () {


                                           Get.to(QRScneer());
                                        },
              
                                        child: CustomContainer(actionWidget: Text(
              
                                          "USD 1568.00", style: TextStyle(color: Colors.red, fontSize: 14),
              
                                        ),
              
                                          imagePath: coinItems[index].coinimage,
              
                                          firstColumnText1: coinItems[index].coinname,
              
                                          firstColumnText2: coinItems[index].coinwallet,
              
                                          //   secondColumnText1: "Bal "+"- USD 125",
              
                                          //   secondColumnText2: "asdefsdat",
              
                                        ),
              
                                      ),
              
                                    );
              
                                  },
              
                                  separatorBuilder: (context, index) {
              
                                    return SizedBox(
              
                                      height: 15,
              
                                    );
              
                                  },
              
                                  itemCount: coinItems.length),
            )
          ],
        ),
      ),
    );
  }
}
