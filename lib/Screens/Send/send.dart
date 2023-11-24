import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unicitizen/Screens/Send-Busd/sen-busd.dart';
import 'package:unicitizen/Screens/Send/coin_modal.dart';
import 'package:unicitizen/utils/custm_container.dart';

class Send extends StatelessWidget {
  const Send({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
       // automaticallyImplyLeading: false,
       title: Text("Send"),
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
            // Container( width: double.infinity,
            //   child: Center(child: Text("Send", style: TextStyle(fontSize: 20),)),
            //   color: Colors.white,
            // ),
            SizedBox(
              height: 20,
            ),
            Container( margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(

                        onTap: (){
Get.to(SendBUSD());


                        },
                        child: CustomContainer(
                          imagePath: coinItems[index].coinimage,
                          firstColumnText1: coinItems[index].coinname,
                          firstColumnText2: coinItems[index].coinwallet,
                          secondColumnText1: "Bal "+"- USD 125",
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
