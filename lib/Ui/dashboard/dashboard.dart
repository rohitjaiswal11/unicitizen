import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:unicitizen/UI/Send/send.dart';
import 'package:unicitizen/UI/dashboard/menu1.dart';
import 'package:unicitizen/UI/dashboard/menu2.dart';

import 'package:unicitizen/Utility/color_collection.dart';

import 'assetcarditem.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,

         statusBarBrightness: Brightness.light,
       
      )





    );




  //     systemOverlayStyle: SystemUiOverlayStyle(
  //   statusBarColor: Colors.green, // <-- SEE HERE
  //   statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
  //   statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
  // ),
    return Scaffold(
      
      backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height: 50,),
            Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Text(
                        "Hello Roe",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      
                         
                      Row(
                        children: [
                       Text(
                            "Welcome Back",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Image.asset(
                            "assets/dashboard/pngwing.png",
                            height: Get.height / 30,
                          ),
                     
                        ],
                      ),


                      
                    ],
                  ),
                       Container(
                              height: Get.height * 0.055,
                              width: Get.height * 0.055,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(alignment: Alignment.center,
                                  child: Icon(
                                Icons.person_2,
                                color: Colors.white,
                                size: 30
                                ,
                              ))),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: Get.height / 5,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/dashboard/cardui.png",
                        ),
                        fit: BoxFit.fill,
                        scale: 4),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      AppColor.fromHex("#312994"),
                      AppColor.fromHex("#967BF5")
                    ])),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "\$ 324,875.19",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: Get.width / 2.6,
                        height: Get.height / 35,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "dggdfhdfhdfhcfhzdfh",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.all(10),
              height: Get.height / 9,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 90, 86, 86).withOpacity(0.5),
                      Color.fromARGB(255, 112, 107, 107).withOpacity(0.5)
                    ],
                  )),
              child: const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Menu1(btname: "Funding",amount: 0
                    ),
                    Menu1(btname: "Presale",amount: 0),
                    Menu1(
                      btname: "Referal",amount: 0,
                      image: "assets/dashboard/person.png",
                      colr: Colors.white,
                    ),
                    Menu1(btname: "Stake",amount: 0),
              
              // Column(
              //       children: [
              //         Container(
              //           padding: EdgeInsets.all(15),
              //           decoration: BoxDecoration(
              //               color: Colors.grey.shade100,
              //               borderRadius: BorderRadius.circular(100)),
              //           child: Image.asset(
              //           "image",
              //             height: 45,
              //           ),
              //         ),
              //         SizedBox(
              //           height: Get.height / 70,
              //         ),
              //         Text(
              //      "btname",
              //           style:
              //               TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //         )
              //       ],
              //     )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 90,
            ),
            Container(
              height: Get.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(


                          onTap: (){



                            Get.to(Send());
                          },
                          child: Menu2(
                            btname: "SEND",
                            image: "assets/dashboard/send.png",
                          ),
                        ),
                        Menu2(
                            btname: "RECEIVE",
                            image: "assets/dashboard/receive.png"),
                        Menu2(
                          btname: "HISTORY",
                          image: "assets/dashboard/history.png",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height / 90,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    ListTile(contentPadding: EdgeInsets.all(0),
                      leading: Text(
                        "My Assets",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        "View All >",
                        style: TextStyle(color: Colors.amber,fontSize: 13),
                      ),
                    ),
                    MyAssetCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
