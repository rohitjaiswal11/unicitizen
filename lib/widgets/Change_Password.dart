import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../Screens/WalletDetailsPage.dart';
import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';




class Change_Password extends StatefulWidget {
  const Change_Password({super.key});

  @override
  State<Change_Password> createState() => _Change_PasswordState();
}

class _Change_PasswordState extends State<Change_Password> {


  TextEditingController old_controller = TextEditingController();
  TextEditingController new_controller = TextEditingController();
  TextEditingController reenter_controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? upper=false;
  bool? lower=false;
  bool? number=false;
  bool? complete=false;

  bool check=true;
  bool check1=true;
  bool check2=true;

  Map<String,bool> done={};

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
        title: CustomFonts.heading20("Change Password", Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors:[ColorsCustom.darkPurple, ColorsCustom.lightPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),),
      body: Form(
          key: _formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(
                vertical: CustomDimension.myheight(context)/35,
                horizontal: CustomDimension.mywidth(context)/20,),
            child:   SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  orangecard(context,
                    toppadding: CustomDimension.myheight(context)/55,
                    leftpadding: CustomDimension.myheight(context)/55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: ColorsCustom.black12),
                    ),
                    mychild:  orangecard(context,
                        // height: CustomDimension.myheight(context)/2.3,
                        width: CustomDimension.mywidth(context),
                        toppadding: CustomDimension.myheight(context)/55,
                        leftpadding: CustomDimension.myheight(context)/55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ColorsCustom.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 5, //New
                            ),
                          ],
                        ),
                        mychild: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: CustomDimension.myheight(context)/50,),
                              child: CustomImages.Customimg(context, CustomImages.passwordStep,scale: 1.5),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top: CustomDimension.myheight(context)/70,
                                  left: CustomDimension.mywidth(context)/50,right: CustomDimension.mywidth(context)/20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: CustomDimension.myheight(context)/7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomFonts.text14("Old Password", ColorsCustom.black),
                                        SizedBox(height: 3,),
                                        Container(
                                          height: CustomDimension.myheight(context)/15,
                                          width: CustomDimension.mywidth(context)/1.61,
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,

                                          child: TextFormField(
                                            controller: old_controller,
                                            textAlignVertical: TextAlignVertical.center,
                                            // validator: (value) {
                                            //   if (value!.isEmpty || value != ConstantClass.password)
                                            //     return 'Incorrect password';
                                            // },
                                            onChanged: (value){
                                              setState(() {
                                                check1=false;
                                              });
                                            if( value!=null && old_controller.text == ConstantClass.password){
                                                setState(() {
                                                  check1=true;
                                                  done['1st']=true;
                                                });
                                              }else{
                                              setState(() {
                                                check1=false;
                                                done['1st']=false;
                                              });
                                            }
                                               },
                                            decoration:InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1, color: ColorsCustom.black12),

                                                  borderRadius: BorderRadius.circular(10)),
                                              hintText: "Enter the Old Password",
                                              enabled: true,
                                              alignLabelWithHint: true,
                                              hintStyle:  TextStyle(
                                                color: ColorsCustom.black38,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,

                                              ),

                                              labelStyle: TextStyle(
                                                color: ColorsCustom.black,
                                                fontSize: 14,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,

                                              ),

                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: check1==true?false:true,
                                            child: CustomFonts.text10( 'Incorrect password', ColorsCustom.red)),

                                      ],
                                    ),
                                  ),

                                  // SizedBox(height: CustomDimension.myheight(context)/9,),
                                  Container(
                                    height: CustomDimension.myheight(context)/7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomFonts.text14("New Password", ColorsCustom.black),
                                        const SizedBox(height: 3,),
                                        Container(
                                            height: CustomDimension.myheight(context)/15,
                                            width: CustomDimension.mywidth(context)/1.61,
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.zero,
                                            child: TextFormField(
                                              controller: new_controller,
                                              textAlignVertical: TextAlignVertical.center,
                                              // validator: (value) {
                                              //   if (value!.isEmpty ) {
                                              //     return 'The new password cannot be same as the\n previous password';
                                              //   }
                                              // },

                                              onChanged: (value){
                                                setState(() {
                                                  check=false;
                                                  RegExp regEx = new RegExp(r"(?=.*[A-Z])");
                                                  RegExp regExL = new RegExp(r"(?=.*[a-z])");
                                                  RegExp regExN = new RegExp(r"(?=.*?[0-9])");
                                                  RegExp regExC = new RegExp(r".{8,}");

                                                  upper= regEx.hasMatch(value);
                                                  lower= regExL.hasMatch(value);
                                                  number= regExN.hasMatch(value);
                                                  complete= regExC.hasMatch(value);
                                                });
                                                if(lower ==true && upper ==true && complete ==true && number == true){
                                                  if(old_controller.text==new_controller.text){

                                                  }else {
                                                    setState(() {
                                                      check = true;
                                                      done['2nd']=true;
                                                    });
                                                  }
                                                }else{
                                                  setState(() {
                                                    check=false;
                                                    done['2nd']=false;
                                                  });
                                                }
                                              },
                                              decoration:InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1, color: ColorsCustom.black12),

                                                    borderRadius: BorderRadius.circular(10)),
                                                hintText: "8-16 charachters",enabled: true,
                                                hintStyle:  TextStyle(
                                                  color: ColorsCustom.black38,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,

                                                ),

                                                labelStyle: TextStyle(
                                                  color: ColorsCustom.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,

                                                ),

                                              ),
                                            )
                                        ),
                                        Visibility(
                                            visible: new_controller.text!=ConstantClass.password && check == true?false:true,
                                            child: CustomFonts.text10( new_controller.text==ConstantClass.password?'The new password cannot be the same as the \nprevious one':'Password must consist of 8-16 characters,\n including both upper and lowercase letters\n and numbers', ColorsCustom.red)),
                                      ],
                                    ),
                                  ),


                                  // SizedBox(height: CustomDimension.myheight(context)/35,),
                                  Container(
                                    height: CustomDimension.myheight(context)/5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomFonts.text14("Re-Enter the Password", ColorsCustom.black),
                                        SizedBox(height: 3,),
                                        Container(
                                            height: CustomDimension.myheight(context)/15,
                                            width: CustomDimension.mywidth(context)/1.61,
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.zero,
                                            child: TextFormField(
                                              textAlignVertical: TextAlignVertical.center,
                                              controller: reenter_controller,
                                              onChanged: (value){
                                                if(value == new_controller.text){
                                                      setState(() {
                                                      check2=true;
                                                      done['3rd']=true;
                                                      });
                                                      }else{
                                                      setState(() {
                                                        done['3rd']=false;
                                                      check2=false;
                                                      });
                                                      }

                                              },
                                              decoration:InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1, color: ColorsCustom.black12),

                                                    borderRadius: BorderRadius.circular(10)),
                                                hintText: "Enter the password again",enabled: true,
                                                hintStyle:  TextStyle(
                                                  color: ColorsCustom.black38,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,

                                                ),
                                                labelStyle: TextStyle(
                                                  color: ColorsCustom.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,

                                                ),

                                              ),
                                            )
                                        ),
                                        Visibility(
                                            visible: check2 == true?false:true,
                                            child: CustomFonts.text10( 'The password enter do not match', ColorsCustom.red)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      bottomSheet:   Container(color: ColorsCustom.white.withOpacity(0.8),
        padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child:  InkWell(
        onTap: (){
          done.forEach((key, value) {
            print(done.toString());
            if (value == false) {
              print("Wrong Data");
            }else{
              setState(() {
                ConstantClass.password = new_controller.text;
                changepass(ConstantClass.password.toString());
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WalletDetailsPage()));
                ConstantClass.showToast("Password\n Modified",duration: Toast.lengthLong);
              });
            };
          });
        },
        child: orangecard(context,
          height: CustomDimension.myheight(context)/15,
          width: CustomDimension.myheight(context),
          toppadding: 10,
          leftpadding: 10,
          decoration:   const BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: [
                Color(0xff6E68EF),
                Color(0xff150CD1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          mychild: Center(child: CustomFonts.text15("Done", ColorsCustom.white)),
        ),
      ),
      ),


    );
  }

  Future<void> changepass (String pass) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', pass.toString());
  }
}
