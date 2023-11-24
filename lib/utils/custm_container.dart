import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath; // Path to your image asset
  final String? firstColumnText1;
  final String? firstColumnText2;
  final String? secondColumnText1;
  final String? secondColumnText2;
  final Color? txt2color;
  final Color? imgColrContainer;
  final Widget? actionWidget;

  CustomContainer({
    required this.imagePath,
    this.firstColumnText1,
    this.firstColumnText2,
    this.secondColumnText1,
    this.secondColumnText2,
    this.txt2color,
    this.imgColrContainer,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 11,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15.0),
      ),
      constraints: BoxConstraints(
        maxWidth: double.infinity,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: imgColrContainer ?? Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              imagePath,
              width: 25.0, // Adjust the width as needed
              height: 25.0, // Adjust the height as needed
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstColumnText1 ?? '',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  firstColumnText2 ?? '',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
      
          actionWidget??    Expanded(
                child:
                
                 Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                      secondColumnText1 ?? '',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      secondColumnText2 ?? '',
                      style: TextStyle(
                          color: txt2color ?? Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
