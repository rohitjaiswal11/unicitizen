import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:hex/hex.dart';
import 'package:dart_bs58check/dart_bs58check.dart';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import '../widgets/Wallet_Created.dart';
import 'BottomNavigation.dart';



class Create_Wallet extends StatefulWidget {
  const Create_Wallet({super.key});

  @override
  State<Create_Wallet> createState() => _Create_WalletState();
}

class _Create_WalletState extends State<Create_Wallet> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController wallet_Controller = TextEditingController();
  TextEditingController pass_Controller = TextEditingController();
  TextEditingController repass_Controller = TextEditingController();
  bool? upper=false;
  bool? lower=false;
  bool? number=false;
  bool? complete=false;
  bool? load=false;



  createwallet() async {
    ConstantClass.mnemonic = bip39.generateMnemonic(strength: 128,);
    int coinType = TWCoinType.TWCoinTypeTron;
    final HDWallet wallet = HDWallet.createWithMnemonic(ConstantClass.mnemonic!);
    ConstantClass.wallet = wallet.getAddressForCoin(coinType).toString();
    var private = wallet.getKeyForCoin(coinType);
    ConstantClass.privateKey = hex.encode(private.data());
    ChangeToPoxx();

    print("12-word mnemonic phrase: ${ConstantClass.mnemonic}");
    print("wallet add =-==-=-=-==-=-= "+ConstantClass.wallet.toString());
    print("Private add =-==-=-=-==-=-= "+ ConstantClass.privateKey.toString());
  }

  String hexToTronAddress(String hexAddress) {
    List<int> decodedHex = hex.decode(hexAddress);
    String base58Address = bs58check.encode(Uint8List.fromList(decodedHex));
    return base58Address;
  }
  void ChangeToPoxx(){
    String base58Address =  ConstantClass.wallet.toString();
    final Uint8List decodedBase58 = bs58check.decode(base58Address);
    final String encodedHex = HEX.encode(decodedBase58);
    print("===> $encodedHex");
    String hexAddress = encodedHex.replaceFirst(RegExp('4'), '3', 0);
    String hexAddress1 = hexAddress.replaceFirst(RegExp('1'), '7', 0);
    print(">>>>>>>>>>>>>   "+hexAddress1.toString());
    String address = hexToTronAddress(hexAddress1);
    setState(() {
      ConstantClass.fakewallet=address.toString();
    });

    savedata();
  }




  @override
  void dispose() {

    wallet_Controller.clear();
    pass_Controller.clear();
    repass_Controller.clear();
    upper=false;
    lower=false;
    number=false;
    complete=false;
    load=false;
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      toolbarHeight: CustomDimension.myheight(context)/10,
      leading:  InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              size: 32, color: ColorsCustom.black)),
      centerTitle: true,
      title: CustomFonts.heading20('Create Wallet', ColorsCustom.black),
    );

    return  Scaffold(
      appBar: appbar,
      body: Padding(
        padding:  EdgeInsets.only(left: CustomDimension.mywidth(context)/20,
            right: CustomDimension.mywidth(context)/20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: CustomDimension.myheight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: CustomDimension.myheight(context)/25,),
                  CustomFonts.text14("Name", ColorsCustom.black),
                  SizedBox(height: 15,),
                  orangecard(context,
                      toppadding: CustomDimension.myheight(context)/150,
                      leftpadding: CustomDimension.myheight(context)/35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: ColorsCustom.black12),
                      ),
                      mychild: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty)
                            return 'Enter valid Name';
                        },
                        controller: wallet_Controller,decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "Wallet",
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
                        ),),)),
                  SizedBox(height: CustomDimension.myheight(context)/35,),

                  CustomFonts.text14("Set a password", ColorsCustom.black),
                  SizedBox(height: 15,),
                  orangecard(context,
                      toppadding: CustomDimension.myheight(context)/120,
                      leftpadding: CustomDimension.myheight(context)/35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: ColorsCustom.black12),
                      ),
                      mychild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFonts.text12("Please be noted that POX does not store the\n password and cannot retrieve it for you.", ColorsCustom.black38,),
                          TextFormField(
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Enter Password';
                              },
                              controller: pass_Controller,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText: "Wallet",
                                hintStyle:  TextStyle(
                                  color: ColorsCustom.black38,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,

                                ),
                                labelStyle: TextStyle(
                                  color: ColorsCustom.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),),onChanged: (String value){
                            setState(() {

                              RegExp regEx = new RegExp(r"(?=.*[A-Z])");
                              RegExp regExL = new RegExp(r"(?=.*[a-z])");
                              RegExp regExN = new RegExp(r"(?=.*?[0-9])");
                              RegExp regExC = new RegExp(r".{8,}");

                              upper= regEx.hasMatch(value);
                              lower= regExL.hasMatch(value);
                              number= regExN.hasMatch(value);
                              complete= regExC.hasMatch(value);
                            });


                          }),
                        ],
                      )),
                  SizedBox(height: CustomDimension.myheight(context)/35,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle,color: upper==true?ColorsCustom.green:ColorsCustom.grey.withOpacity(0.7),),
                          SizedBox(width: 15,),
                          CustomFonts.text12("Uppercase",upper==true?ColorsCustom.green: ColorsCustom.black.withOpacity(0.4)),
                        ],
                      ),
                      SizedBox(width: CustomDimension.mywidth(context)/4.6,),

                      Row(
                        children: [
                          Icon(Icons.check_circle,color: lower==true?ColorsCustom.green:ColorsCustom.grey.withOpacity(0.7)),
                          SizedBox(width: 15,),
                          CustomFonts.text12("Lowecase", lower==true?ColorsCustom.green:ColorsCustom.black.withOpacity(0.4)),

                        ],
                      ),
                    ],
                  ), SizedBox(height: CustomDimension.myheight(context)/35,),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle,color: number==true?ColorsCustom.green:ColorsCustom.grey.withOpacity(0.7),),
                          SizedBox(width: 15,),
                          CustomFonts.text12("Number", number==true?ColorsCustom.green:ColorsCustom.black.withOpacity(0.4)),
                        ],
                      ),

                      SizedBox(width: CustomDimension.mywidth(context)/4,),
                      Row(
                        children: [
                          Icon(Icons.check_circle,color: complete==true?ColorsCustom.green:ColorsCustom.grey.withOpacity(0.7)),
                          SizedBox(width: 15,),
                          CustomFonts.text12("At least 8 character", complete==true?ColorsCustom.green:ColorsCustom.black.withOpacity(0.4)),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: CustomDimension.myheight(context)/35,),

                  CustomFonts.text14("Reenter Password", ColorsCustom.black),
                  SizedBox(height: 15,),
                  orangecard(context,
                      toppadding: CustomDimension.myheight(context)/150,
                      leftpadding: CustomDimension.myheight(context)/35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: ColorsCustom.black12),
                      ),
                      mychild: TextFormField(
                        validator: (val) {
                          if (val!=pass_Controller.text.toString())
                            return 'Enter correct password';
                        },
                        controller: repass_Controller,decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter the Password Again",
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
                        ),),)),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet:    Container(
        color: ColorsCustom.white.withOpacity(0.8),
        padding:  const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: InkWell(
          onTap: ()  {

            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Wallet_Created()),(Route route) => false);
            setState(() {
              ConstantClass.Name = wallet_Controller.text.toString();
              ConstantClass.password = pass_Controller.text.toString();
              load=true;


            });
            if(ConstantClass.imported==true){
              ChangeToPoxx();

            }else{
              setState(() {
                createwallet();
              });
            }

            if (_formKey.currentState!.validate() && lower ==true && upper ==true && complete ==true && number == true) {
              Future.delayed(Duration(seconds: 2), () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>ConstantClass.
                imported==true?BottomNavigation(index: 0): Wallet_Created()),(Route route) => false);
              });
            }
            else
            {
              setState(() {
                load=false;
              });
            }
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
                  Color(0xff181309),
                  Color(0xff181309),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            mychild:load==true?LoadingAnimationWidget.threeRotatingDots(
              color: ColorsCustom.white,
              size: 30,):
            Center(child: CustomFonts.text15("Create Wallet", ColorsCustom.white)),
          ),
        ),
      ),
    );
  }

  savedata() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wallet', ConstantClass.wallet.toString());
    await prefs.setString('privatekey', ConstantClass.privateKey.toString());
    await prefs.setString('seedPhrase', ConstantClass.mnemonic.toString());
    await prefs.setString('name', ConstantClass.Name.toString());
    await prefs.setString('password', ConstantClass.password.toString());
    await prefs.setString('fakewallet', ConstantClass.fakewallet.toString());
    await prefs.setBool('DontShowkeystore', false);
    await prefs.setBool('DontShowprivate', false);
    await prefs.setBool('DontShowmnemonic', false);

  }



}
