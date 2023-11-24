import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicitizen/Screens/security.dart';

import '../Ui/wallets/wallets.dart';
import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';

class currency extends StatefulWidget {
  const currency({Key? key});

  @override
  State<currency> createState() => _currencyState();
}

class _currencyState extends State<currency> {
  String selectedOption = '';

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
        title: CustomFonts.heading20('Currency', ColorsCustom.black),
      ),
      body: SingleChildScrollView
        (
        child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomFonts.text15(
                  "Popular",
                  ColorsCustom.grey,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _method(value: " Option 3", text: 'USD-United states Dollar'),
                _method(value: " Option 3", text: 'INR-Indian Rupees'),
                _method(value: " Option 3", text: 'BTC-Bitcoin'),
                _method(value: " Option 3", text: 'EUR-Euro'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomFonts.text15(
                  "All",
                  ColorsCustom.grey,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _method(value: " Option 3", text: 'USD-United states Dollar'),
                _method(value: " Option 3", text: 'INR-Indian Rupees'),
                _method(value: " Option 3", text: 'BTC-Bitcoin'),
                _method(value: " Option 3", text: 'EUR-Euro'),
                _method(value: " Option 3", text: 'USD-United states Dollar'),
                _method(value: " Option 3", text: 'INR-Indian Rupees'),
                _method(value: " Option 3", text: 'BTC-Bitcoin'),
              ],
            ),
          ),
       ElevatedButton(onPressed: (){Get.to(Wallets());}, child: Text("next"))
       
       
       ]
        ,
      ),

      )
    );
  }

  Widget _method({required String text, required String value}) {
    return ListTile(
      title: Text(text),
      leading: Radio(
        value: value,
        groupValue: selectedOption,
        onChanged: (String? value) {
          setState(() {
            selectedOption = value!;
          });
        },
      ),
    );
  }
}
