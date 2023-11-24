import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';

class AddWalletPage extends StatefulWidget {
  const AddWalletPage({super.key});

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsCustom.backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: CustomDimension.myheight(context)/45,
                vertical:CustomDimension.myheight(context)/20,),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(colors: [
                    Color(0xff0e093c),
                    Color.fromARGB(255, 51, 47, 112),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              size: 32, color: Colors.white)),
                      Spacer(),

                      CustomFonts.heading22('Add Wallet', Colors.white),
                       Spacer(),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    'Hi...,👋',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    'Welcome to LBM Network!',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white),
                  ),

                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            customCard(width, height,
                imageHeight: 70,
                imageWidth: 70,
                fit: BoxFit.contain,
                cardItemsList: [
                  CustomCardItem(
                      imagePath: CustomImages.moneySaving,
                      title: 'Generate Wallet',
                      subTitle:
                          'Generate Related Wallets based on your HD Wallet'),
                ]),
            SizedBox(height: height * 0.01),
            customCard(width, height,
                imageHeight: 70,
                imageWidth: 70,
                fit: BoxFit.contain,
                cardItemsList: [
                  CustomCardItem(
                      imagePath: CustomImages.import,
                      title: 'Import Wallet',
                      subTitle:
                          'Import your mnemonic, Private Key, or keystore with one tap'),
                ]),
            SizedBox(height: height * 0.01),
            customCard(width, height,
                imageHeight: 70,
                imageWidth: 70,
                fit: BoxFit.contain,
                cardItemsList: [
                  CustomCardItem(
                      imagePath: CustomImages.pairLedger,
                      title: 'Pair Ledger',
                      subTitle: 'Pair Ledger to use your hardware Wallet'),
                ]),
            SizedBox(height: height * 0.01),
            customCard(width, height,
                imageHeight: 70,
                imageWidth: 70,
                fit: BoxFit.contain,
                cardItemsList: [
                  CustomCardItem(
                      imagePath: CustomImages.pairCold,
                      title: 'Pair Cold Wallet',
                      subTitle:
                          'Pair with your iffline cold Wallet, Reccomended for large asset holders'),
                ]),
            SizedBox(height: height * 0.01),
            customCard(width, height,
                imageHeight: 70,
                imageWidth: 70,
                fit: BoxFit.contain,
                cardItemsList: [
                  CustomCardItem(
                      imagePath: CustomImages.watchOnly,
                      title: 'Watch - only Wallet',
                      subTitle:
                          'Check your real-time wallet balance and transaction data only'),
                ]),
          ],
        ),
      ),
    );
  }
}
