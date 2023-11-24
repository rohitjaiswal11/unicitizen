import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart' as hex;
import 'package:hex/hex.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:bip39/bip39.dart' as bip39;


import 'package:wallet/wallet.dart' as wallet;
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' as crypto;
import 'package:pointycastle/impl.dart' as impl;

import '../utils/Colors.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';


class ImportWalletPage extends StatefulWidget {
  bool? Scanned;


  ImportWalletPage(this.Scanned);

  @override
  State<ImportWalletPage> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
   String? hint= "Scan or enter Import your mnemonic, \nPrivate Key, or keystor....";
   String? Valid;
  bool isValid=false;
  bool nextbool=false;
  bool next=false;
  _onDelete(index) {
    setState(() {
      _values.removeAt(index);

    });
    if(_values.isEmpty){
     setState(() {
       hint= "Scan or enter Import your mnemonic, \nPrivate Key, or keystor....";
     });
    }else{}
  }

  @override
  void initState() {
    super.initState();
    TrustWalletCoreLib.init();
    print("inflict summer build ability iron draw suffer deliver only obtain embark sport");
    //
    // reload();

    // TODO: implement initState

  }







  /// This is just an example for using `TextEditingController` to manipulate
  /// the the `TextField` just like a normal `TextField`.


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      body: SingleChildScrollView(
        child: Container(
          height: CustomDimension.myheight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff130c06),
                                Color(0xff130c06),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height / 15,
                                left: width * 0.05,
                                right: width * 0.05),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back,
                                            size: 32, color: Colors.white)),
                                    CustomFonts.heading20(
                                        'Import Wallet', Colors.white),
                                    Text(
                                      'Tutorial',
                                      style: TextStyle(color: ColorsCustom.orangelight),
                                    )
                                  ],
                                ),
                                SizedBox(height: height * 0.03),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Column(
                            children: [
                              SizedBox(height: height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Input',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),
                                  ),
                                  // InkWell(
                                  //   onTap: (){
                                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scranner(false)));
                                  //   },
                                  //   child: CustomImages.setAssetImage(CustomImages.scannericon,
                                  //       color: Colors.black, height: 22, width: 22),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: CustomDimension.myheight(context)/2.5,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 5.0,
                                      spreadRadius: 5, //New
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TagEditor(
                                      length: _values.length,
                                      controller: _textEditingController,
                                      focusNode: _focusNode,
                                      delimiters: [',', ''],
                                      hasAddButton: false,
                                      resetTextOnSubmitted: true,
                                      // This is set to grey just to illustrate the `textStyle` prop
                                      textStyle: const TextStyle(color: Colors.grey),
                                      onSubmitted: (outstandingValue) {
                                        setState(() {
                                          hint="";
                                          _values.add(outstandingValue);
                                        });
                                      },
                                      inputDecoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(overflow: TextOverflow.ellipsis,),
                                        hintText: hint.toString(),
                                      ),

                                      onTagChanged: (newValue) {
                                        setState(() {
                                          _values.add(newValue);
                                        });
                                      },
                                      tagBuilder: (context, index) => _Chip(
                                        index: index,
                                        label: _values[index],
                                        onDeleted: _onDelete,
                                      ),
                                      // InputFormatters example, this disallow \ and /
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Visibility(
                                        //   visible: ConstantClass.Imported_mnemonic==""?false:true,
                                        //   child: InkWell(
                                        //     onTap: (){
                                        //       setState(() {
                                        //         hint= "Scan or enter Import your mnemonic, \nPrivate Key, or keystor....";
                                        //         _textEditingController.text="";
                                        //         ConstantClass.Imported_mnemonic="";
                                        //       });
                                        //
                                        //     },
                                        //     child: CustomFonts.text14600("clear",Color(0xFFDE5151),),
                                        //   ),
                                        // ),
                                        SizedBox(width: CustomDimension.mywidth(context)/12),
                                        InkWell(
                                          // onTap: (){
                                          //   Clipboard.getData(Clipboard.kTextPlain).then((value){
                                          //     print("my data ????????? "+value!.text.toString());
                                          //     setState(() {
                                          //       ConstantClass.Imported_mnemonic=value.text.toString().split(' ').where((word) => word.isNotEmpty).toList();
                                          //       print("my data ????????? "+ ConstantClass.Imported_mnemonic.toString());
                                          //     });
                                          //   }).then((value) {
                                          //     setState(() {
                                          //       widget.Scanned=true;
                                          //       reload();
                                          //     });
                                          //   });
                                          //
                                          // },
                                          child: CustomFonts.text14600("Paste",  Color(0xFF261DD7),),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Visibility(
                  visible: next==true?isValid==true?false:true:false,
                  child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: width * 0.05,),
                    child: Row(
                      children: [
                        CustomImages.Customimg(context,CustomImages.warning, height: 12,color: ColorsCustom.red),
                        SizedBox(width: 8,),
                        CustomFonts.text12(Valid.toString(), ColorsCustom.red),
                      ],
                    ),
                  )),
                ],

              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.05),
                child: InkWell(
                  onTap: () {
//                     String privateKeyHex = HEX.decode("540c0dc73de95e31344d65c09903948276a85671c57b552eb4904a3630a511da").toString();
//                     final publicKey = wallet.tron.createPublicKey(wallet.PrivateKey(BigInt.parse(privateKeyHex)));
//                     final address = wallet.tron.createAddress(publicKey);
//
//                     print('Tron Address: $address');
//
//
// // Assuming `PrivateKey` is a class or method to create a private key
//                     var privateKey = wallet.PrivateKey(BigInt.parse(privateKeyHex));
//
// // Assuming there is a method createPublicKey in the tron property
//                     var publicKeyd = wallet.tron.createPublicKey(privateKey);
//                     print('Tron Address: $publicKeyd');


                    setState(() {
                      nextbool=true;
                      next=true;
                    });
                    // nextStep();
                  },
                  child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color(0xff130c06),
                        Color(0xff130c06),
                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    ),
                    child:nextbool==true?LoadingAnimationWidget.threeRotatingDots(
                           color: ColorsCustom.white,
                           size: 30,
                           ): Text('Next Step',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // nextStep() async {
  //
  //
  //
  //
  //
  //
  //   ConstantClass.mnemonic = _values.join(' ');
  //   print(" ????????       "+ConstantClass.mnemonic.toString());
  //
  //   isValid = await bip39.validateMnemonic(ConstantClass.mnemonic.toString());
  //   print(" ????????       "+isValid.toString());
  //   if(isValid==true){
  //     int coinType = TWCoinType.TWCoinTypeTron;
  //     final HDWallet wallet = HDWallet.createWithMnemonic(ConstantClass.mnemonic);
  //    setState(() {
  //      ConstantClass.wallet = wallet.getAddressForCoin(coinType).toString();
  //    });
  //     print(ConstantClass.wallet.toString());
  //
  //     setState(() {
  //       next=false;
  //      ConstantClass.imported=true;
  //       // nextbool=false;
  //     });
  //     Timer(
  //       Duration(seconds: 3),
  //           () => Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //           Create_Wallet(),
  //         ),
  //       ),
  //     );
  //
  //
  //   }else{
  //     print(isValid.toString());
  //     setState(() {
  //       nextbool=false;
  //       Valid="Please Enter a Valid private Key, Mnemonic, or Keystore";
  //     });
  //
  //   }
  //
  // }

}
class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}