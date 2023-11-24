import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import 'currency.dart';

class security extends StatefulWidget {
  const security({super.key});

  @override
  State<security> createState() => _securityState();
}

class _securityState extends State<security> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: CustomDimension.myheight(context) / 10,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 32, color: ColorsCustom.black)),
        centerTitle: true,
        title: CustomFonts.heading20('Security', ColorsCustom.black),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _tile(image: CustomImages.darkmodeprofile, name: 'Password'),
              _tile(image: CustomImages.security, name: 'Auto-Lock'),
              _tile(image: CustomImages.currency, name: 'lock-Method'),
              _tile(image: CustomImages.country, name: 'change Password'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomFonts.text15("Ask authentication for", ColorsCustom.grey),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => currency()));
                  print("Card tapped!");
                },
                child: _tile(
                    image: CustomImages.darkmodeprofile,
                    name: 'Transaction Signin'),
              )

              // _tile(
              //     image: CustomImages.darkmodeprofile,
              //     name: 'Transaction Signin'),
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
