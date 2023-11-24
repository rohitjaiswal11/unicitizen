// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu1 extends StatelessWidget {
  final String btname;
 final int amount;
  final String? image;
  final Color? colr;
  const Menu1({
    
    Key? key,
    required this.btname,
    this.image, this.colr, required this.amount, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.zero,
          child: Image.asset(
            image ?? "assets/dashboard/lock.png",
            height: 25,
          ),
        ),
  
           Text(
            
 "\$${amount.toString()}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,color: colr??Colors.grey.shade700 ),
        ),
        Text(
          btname,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: colr??Colors.grey.shade700 ),
        )
      ],
    );
  }
}
