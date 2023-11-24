import 'package:flutter/material.dart';

import 'Colors.dart';
import 'CustomImages.dart';
import 'Fonts.dart';

Widget orangecard(
  context, {
  Widget? mychild,
  String? val,
  double? height,
  double? width,
  BoxDecoration? decoration,
  double? toppadding,
  double? leftpadding,
  Color? shadow,
  Alignment? alignment,
}) {
  return Container(
    alignment: alignment,
    padding: EdgeInsets.symmetric(
      horizontal: leftpadding!,
      vertical: toppadding!,
    ),
    height: height,
    width: width,
    decoration: decoration,
    child: mychild, //declare your widget here
  );
}

Widget customCard(double width, double height,
    {required List<CustomCardItem> cardItemsList,
    double? imageHeight,
    double? imageWidth,
    BoxFit? fit,
    EdgeInsetsGeometry? padding}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
    child: Card(
        elevation: 0.5,
        color: Colors.white,
        shadowColor: Colors.grey,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final currentItem = cardItemsList[index];
              return InkWell(
                // onTap: () {
                //   if (currentItem.title == 'Transaction History') {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Transaction_History()));
                //   }else if(currentItem.title == 'Backup History'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Backup_History()));
                //   }else if(currentItem.title == 'Address Book'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Address_Book()));
                //   }else if(currentItem.title == 'Advanced Features'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Advance_Feature()));
                //   }else if(currentItem.title == 'About'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => About_Us()));
                //   }else if(currentItem.title == 'Settings'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Settings()));
                //   }else if(currentItem.title == 'Wallet Management'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => WalletDetailsPage()));
                //   }else if(currentItem.title == 'Permission'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Permission_Widget()));
                //   }else if(currentItem.title == 'Import Wallet'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => ImportWalletPage(false)));
                //   }else if(currentItem.title == 'Pair Ledger'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => AddNewDevicePage()));
                //   }else if(currentItem.title == 'Pair Cold Wallet'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => PairColdWalletPage()));
                //   }else if(currentItem.title == 'Watch - only Wallet'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => WatchOnlyPage()));
                //   }else if(currentItem.title == 'DApp Connections'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => DApp_Connections()));
                //   }else if(currentItem.title == 'Multising Transaction'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Multisig_Transaction()));
                //   }else if(currentItem.title == 'Connections'){
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => Connections()));
                //   }
                // },
                child: Padding(
                    padding: padding ??
                        EdgeInsets.symmetric(
                            horizontal: width * 0.035, vertical: height * 0.02),
                    child: Row(children: [
                      CustomImages.setAssetImage(currentItem.imagePath,
                          height: imageHeight ?? 35,
                          width: imageWidth ?? 35,
                          fit: fit ?? BoxFit.fill),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFonts.text15(
                              currentItem.title, ColorsCustom.black),
                          if (currentItem.subTitle != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * 0.005),
                                SizedBox(
                                  width: width * 0.5,
                                  child: CustomFonts.text12(
                                      currentItem.subTitle!,
                                      ColorsCustom.black38),
                                )
                              ],
                            )
                        ],
                      ),
                    ])),
              );
            },
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Divider(color: Colors.grey.shade400, height: 5),
                ),
            itemCount: cardItemsList.length)),
  );
}

class CustomCardItem {
  final String imagePath;
  final String title;
  final String? subTitle;

  CustomCardItem({required this.imagePath, required this.title, this.subTitle});
}
