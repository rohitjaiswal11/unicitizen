import 'package:flutter/material.dart';
import 'package:unicitizen/Screens/security.dart';

import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import 'currency.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: CustomDimension.myheight(context) / 12,
        leading: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context) / 35),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context) / 35),
          child: CustomFonts.heading20('Profile', ColorsCustom.black),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => security()));
              print("Card tapped!");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Color(0xfff5c6a4),
                            radius: 10,

                            child:
                                Image.asset(CustomImages.waletpro)),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            CustomFonts.text15("Wallets", ColorsCustom.black),
                            Text("hello")
                          ],
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _tile(image: CustomImages.darkmodeprofile, name: 'Dark Mode'),
              _tile(image: CustomImages.security, name: 'Security'),
              _tile(image: CustomImages.currency, name: 'Currency'),
              _tile(image: CustomImages.country, name: 'Country'),
              _tile(image: CustomImages.pricealert, name: 'Price Alert'),
              _tile(image: CustomImages.support, name: 'Support'),
              _tile(image: CustomImages.abouts, name: 'About'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomFonts.text15("Join Community", ColorsCustom.grey),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _tile(image: CustomImages.darkmodeprofile, name: 'Dark Mode'),
              _tile(image: CustomImages.security, name: 'Security'),
              _tile(image: CustomImages.currency, name: 'Currency'),
            ],
          ),
        ),
      ]),
    );
  }

  _tile({required String image, required String name}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
              backgroundColor: Color(0xfff5c6a4),
              radius: 15,
              child: Image.asset(image, scale: 2.0)),

          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFonts.text14("$name", ColorsCustom.black),
            ],
          ),
          Spacer(), // Use Spacer to push the next element to the end
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 19,
          ),
        ],
      ),
    );
  }
}
