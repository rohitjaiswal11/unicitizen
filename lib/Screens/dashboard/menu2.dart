// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu2 extends StatelessWidget {

 final String btname;
 final String image;
  const Menu2({
    Key? key,
    required this.btname, required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey.shade300.withOpacity(0.8),
              borderRadius: BorderRadius.circular(100)),
          child: Image.asset(
          image,
            height: 45,
          ),
        ),
        SizedBox(
          height: Get.height / 70,
        ),
        Text(
     btname,
          style:
              TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
