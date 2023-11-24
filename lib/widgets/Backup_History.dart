import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicitizen/utils/ConstantClass.dart';

import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import '../utils/ModelClass.dart';




class Backup_History extends StatefulWidget {
  const Backup_History({super.key});

  @override
  State<Backup_History> createState() => _Backup_HistoryState();
}

class _Backup_HistoryState extends State<Backup_History> {




  Future<void> getDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {


     List<String>? listString = prefs.getStringList('Backuphistory');
     print("  >>>>>>>>>>>>>>>>>>>>           "+listString.toString());

     ConstantClass.backupHistory = listString!.map((item) => BackupHistory.fromMap(json.decode(item))).toList();

   });

    print("  >>>>>>>>>>>>>>>>>>>>           "+ConstantClass.backupHistory[0].accname.toString());

  }

  @override
  void initState() {
    getDetail();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
        toolbarHeight: CustomDimension.myheight(context)/10,

        leading:   InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                size: 32, color: Colors.white)),
        centerTitle: true,
        title: CustomFonts.heading20('Backup History', Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors:[ColorsCustom.darkPurple, ColorsCustom.lightPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),

      ),
      body: Column(
        children: [
          SizedBox(height: CustomDimension.myheight(context)/35,),
          Padding(
            padding: EdgeInsets.only(
                left: CustomDimension.mywidth(context)/20
                ,right: CustomDimension.mywidth(context)/20 ),
            child: orangecard(context,
            width: CustomDimension.mywidth(context),
              toppadding: CustomDimension.myheight(context)/55,
              leftpadding: CustomDimension.mywidth(context)/35,
            decoration:    BoxDecoration(color: ColorsCustom.grey.withOpacity(0.15),
            borderRadius:BorderRadius.all(Radius.circular(10)),
            ),
              mychild: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImages.Customimg(context, CustomImages.warning, scale:2.5,color: ColorsCustom.orangelight),
                  SizedBox(width: 3,),
                  Expanded(
                    child: CustomFonts.text10ex("If there is any action you don't recognize, it is highly likely that your mnemonic and mobile phone password have been leaked. Please transfer your assets to somewhere safe ASAP. You can also check the security camera of the location you were in to find out the suspect who accessed your phone during that time period.",
                     ColorsCustom.orangelight),
                  ),
                ],
              ),
            ),
          ),
          Center(child: Listofhome(context)),
        ],
      ),
    );
  }
  Widget Listofhome(BuildContext context) {
    return ConstantClass.backupHistory.isEmpty== true? Container(
      // color: Colors.red,
      width: CustomDimension.mywidth(context),
      height: CustomDimension.myheight(context)/1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImages.Customimg(context, CustomImages.nodata,scale: 1.2,),
            CustomFonts.text15("No data", ColorsCustom.black26),
          ],
        ),
    ):Container(
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: ConstantClass.backupHistory.length,padding: EdgeInsets.symmetric(vertical: CustomDimension.myheight(context)*0.005),
        itemBuilder: (context, index) {
          print("checkt  ${ConstantClass.backupHistory}");
          if (ConstantClass.backupHistory.isEmpty== true) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0),

              child: Row(
                children: [
                  CustomImages.Customimg(context, CustomImages.nodata, scale:1.2,color: ColorsCustom.black),
                  Center(
                    child: CustomFonts.text15("No data", ColorsCustom.black),
                  ),
                ],
              ),
            );
          } else {
            return InkWell(
              onTap: () {},
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: CustomDimension.mywidth(context)/45,vertical: CustomDimension.myheight(context)*0.005),
                child: orangecard(context,
                  toppadding: CustomDimension.myheight(context)/150,
                  leftpadding: CustomDimension.myheight(context)/50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: ColorsCustom.black12),
                  ),
                  mychild: ListTile(contentPadding: EdgeInsets.zero,
                    title: CustomFonts.heading16500("Back Up "+
                        ConstantClass.backupHistory[index].accname.toString(), ColorsCustom.black),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFonts.text12("Account Name : "+
                            ConstantClass.Name.toString(),
                            ColorsCustom.black38),
                        CustomFonts.text12("Account Address : "+
                            ConstantClass.fakewallet.toString(),
                            ColorsCustom.black38),
                        CustomFonts.text12("Backup Time : "+
                            ConstantClass.backupHistory[index].time.toString(),
                            ColorsCustom.black38),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );

  }

}
