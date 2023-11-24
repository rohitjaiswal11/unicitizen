import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicitizen/utils/ModelClass.dart';
import 'dart:ui';

import '../Screens/WalletDetailsPage.dart';
import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';


class BackupPrivate_Key extends StatefulWidget {
   String? title;

   BackupPrivate_Key(this.title);

  @override
  State<BackupPrivate_Key> createState() => _BackupPrivate_KeyState();
}

class _BackupPrivate_KeyState extends State<BackupPrivate_Key> {

  TextEditingController privatekey = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password_controller = TextEditingController();
  @override
  void initState() {
    privatekey.text = ConstantClass.privateKey.toString();
    saveHistory();
    // TODO: implement initState
    super.initState();
  }

  Future<void> saveHistory() async {
    var time = DateTime.now();
    String Time = DateFormat('yyyy-MM-dd HH:mm').format(time);
    ConstantClass.backupHistory.add(BackupHistory(
      accname: "Private Key",
      time: Time.toString(),
    ));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = ConstantClass.backupHistory.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList('Backuphistory',history);




  }


  Future<void> showQR(BuildContext context) async {
    return await showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: ColorsCustom.white,
              shadowColor: ColorsCustom.grey,
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomFonts.heading18("Private Key QR Code",ColorsCustom.black),
                    SizedBox(height: 25,),
                    Container(
                      height: 350,
                      width: CustomDimension.mywidth(context),
                      // child: Center(
                      //   child: QrImageView(
                      //     data: ConstantClass.mnemonic.toString(),
                      //     version: QrVersions.auto,
                      //   ),
                      // ),
                    ),
                  ]),
              //   title: CustomFonts.heading16("Filter",ColorsCustom.black),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    width: CustomDimension.mywidth(context),
                    padding: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                    decoration: BoxDecoration(
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff6E68EF),
                            Color(0xff150CD1),
                          ],
                        )
                    ),
                    child: Center(child: CustomFonts.text13("Close", ColorsCustom.white)),
                  ),
                  onTap: () {
                    // Do something like updating SharedPreferences or User Settings etc.
                    Navigator.of(context).pop();

                  },
                ),
              ],
            );
          });
        });
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
        title: CustomFonts.heading20(widget.title.toString(), Colors.white),
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
      body: SingleChildScrollView(
        child: Container(
          height: CustomDimension.myheight(context),
          child: Padding(
            padding:  EdgeInsets.only(left: CustomDimension.mywidth(context)/20,right: CustomDimension.mywidth(context)/20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: CustomDimension.myheight(context)/35,),
                CustomFonts.text12("Please correctly copy the ${widget.title.toString()} in order.", ColorsCustom.black),
              SizedBox(height: CustomDimension.myheight(context)/35,),
              TextFormField(
                controller: privatekey,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    contentPadding: EdgeInsets.only(left: 15,right: 25,top: 15,bottom: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.transparent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    // hintText:
                    // 'plaersershfkjkredklfmlkwjkfdnawkldlkcfwnjkfdnkwlmdznwjdkszdmskledfklew....',
                    hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis)),
                maxLines: 6,
              ),
                SizedBox(height: CustomDimension.myheight(context)/35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        width: CustomDimension.mywidth(context)/2.5,
                        padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                        decoration: BoxDecoration(
                          boxShadow:  const [
                            BoxShadow(
                              color: Colors.grey,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff171345),

                        ),
                        child: Center(child: CustomFonts.text15("Copy", ColorsCustom.white)),
                      ),
                      onTap: () {
                          Clipboard.setData(ClipboardData(
                              text:ConstantClass.privateKey.toString())).then((value) => ConstantClass.showToast("Copied",duration: Toast.lengthShort));
                        },
                    ),
                    InkWell(
                      child: Container(
                        width: CustomDimension.mywidth(context)/2.5,
                        padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                        decoration: BoxDecoration(
                            boxShadow:  const [
                              BoxShadow(
                                color: Colors.grey,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff171345),

                        ),
                        child: Center(child: CustomFonts.text15("QR Code", ColorsCustom.white)),
                      ),
                      onTap: () {
                        showQR(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: CustomDimension.myheight(context)/3.5,),
                orangecard(context,
                  width: CustomDimension.mywidth(context),
                  toppadding: CustomDimension.myheight(context)/150,
                  leftpadding: CustomDimension.myheight(context)/35,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: ColorsCustom.black12)
                  ),
                  mychild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFonts.text14("Keep Your ${widget.title.toString().split('Back Up')[1]} in a safe place", ColorsCustom.black),
                      SizedBox(height: 10,),
                      CustomFonts.text10ex("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.", ColorsCustom.black.withOpacity(0.4)),
                    ],
                  )
                ),
                SizedBox(height: CustomDimension.myheight(context)/35,),
                InkWell(
                  child: Container(
                    width: CustomDimension.mywidth(context),
                    padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                    decoration: BoxDecoration(
                      boxShadow:  const [
                        BoxShadow(
                          color: Colors.grey,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff6E68EF),
                            Color(0xff150CD1),
                          ],
                        )

                    ),
                    child: Center(child: CustomFonts.text15("I Have Saved It Securely", ColorsCustom.white)),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WalletDetailsPage()));
                  },
                ),
                SizedBox(height: CustomDimension.myheight(context)/35,),
            ],),
          ),
        ),
      ),

    );
  }


  Future<void> showInformationDialog(BuildContext context,) async {
    return await showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: ColorsCustom.white,
              shadowColor: ColorsCustom.grey,

              insetPadding: const EdgeInsets.symmetric(horizontal: 0),
              contentPadding: const EdgeInsets.all(20),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFonts.heading16("Enter Password",ColorsCustom.black),
                      SizedBox(height: 10,),
                      orangecard(context,
                        toppadding: CustomDimension.myheight(context)/150,
                        leftpadding: CustomDimension.myheight(context)/35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: ColorsCustom.black12)
                        ),
                        mychild: TextFormField(
                          controller: password_controller,decoration:InputDecoration(
                          border: InputBorder.none,
                          // hintText: "Enter the token's contract address",
                          // hintStyle:  TextStyle(
                          //   color: ColorsCustom.black38,
                          //   fontSize: 14,
                          //   fontFamily: 'Poppins',
                          //   fontWeight: FontWeight.w400,
                          //
                          // ),
                          labelStyle: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,

                          ),

                        ),



                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  )),
              //   title: CustomFonts.heading16("Filter",ColorsCustom.black),
              actions: <Widget>[

                InkWell(
                  child: Container(
                    width: CustomDimension.mywidth(context)/3.2,
                    padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsCustom.black12),
                      borderRadius: BorderRadius.circular(5),

                    ),
                    child: Center(child: CustomFonts.text15("Cancel", ColorsCustom.black)),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
                InkWell(
                  child: Container(
                    width: CustomDimension.mywidth(context)/3.2,
                    padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
                    decoration: BoxDecoration(
                        boxShadow:  const [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff6E68EF),
                            Color(0xff150CD1),
                          ],
                        )
                    ),
                    child: Center(child: CustomFonts.text15("Confirm", ColorsCustom.white)),
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();


                    }
                  },
                ),
              ],
            );

          });
        });
  }



}
