import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';


import '../Screens/Register_1.dart';
import '../Widgets/Backup_Mnemonic.dart';
import '../widgets/BackUp_PrivateKey.dart';
import 'Colors.dart';
import 'CustomCard.dart';
import 'CustomImages.dart';
import 'Dimensions.dart';
import 'Fonts.dart';

import 'dart:developer' as dev;
// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, avoid_print, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_null_comparison


import 'package:flutter/services.dart';



import 'package:crypto/crypto.dart';
// import 'package:web3dart/crypto.dart';


import 'package:fixnum/fixnum.dart' as $fixnum;
// import 'package:tron/tron.dart' as $t;


// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, avoid_print, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_null_comparison
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// import 'package:web3dart/web3dart.dart';


import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';


// import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
// import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
// import 'dart:developer' as dev;
// import 'package:http/http.dart' as http;
// import 'package:fixnum/fixnum.dart' as $fixnum;
// import 'package:tron/tron.dart' as $t;
// import 'package:protobuf_google/protobuf_google.dart' as $0;

import 'ModelClass.dart';
class ConstantClass {


  static String? Name;
  static String? password;
  static var mnemonic;
  static var Imported_mnemonic;
  static var Scaned_wallet;
  static String? wallet;
  static String? FixedWallet = "TUPxRRwjzPtLpbHYY21CLCCoPZ4eaynKm5";
  static String? privateKey;
  static String? fakewallet;
  static String? USDPbalance="0.0";
  static String? Network;
  static String? energy;
  static String? width;
  static String? selectedToken;
  static bool? imported = false;
  static var totalAsset;
  static var totalTRX;
  static List<Asset_Collectibles> assets = [];
  static List<Collectibles> collectibles = [];
  static List<Asset_Collectibles> AssetList = [];
  static List<Transactions> transactions = [];
  static List<BackupHistory> backupHistory=[];
  static List<BackupHistory> AddressBook=[];
  bool sending = false;

  static bool? hide = false;
  static String fromToken = "TRX";
  static String? fromTokenImage;
  static var fromTokenBal;
  static String toToken = "USDT";
  static String? toTokenImage;
  static var toTokenBal;
  static bool DontShowprivate = false;
  static bool DontShowkeystore = false;
  static bool DontShowmnemonic = false;
  // static String? Shasta = "Shasta Testnet is mainly used for development and testing and is not recommended to general users. \nAre you sure to switch the network? You need to manually restart the App after switching to the shasta Testnet.";
  static String? Mainnet = "You need to manually restart the App after switching to the POX Mainnet";
  static String? Nile = "POX Testnet is mainly used for development and testing and is not recommended to general users.Are you sure to switch the network? You need to manually restart the App after switching to the POX Testnet.";
  static TextEditingController pass_Controller = TextEditingController();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }



  static Future<void> getWallet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ConstantClass.wallet = prefs.getString('wallet');
    ConstantClass.privateKey = prefs.getString('privatekey');
    ConstantClass.Name = prefs.getString('name');
    ConstantClass.mnemonic = prefs.getString('seedPhrase');
    ConstantClass.password = prefs.getString('password');
    ConstantClass.fakewallet = prefs.getString('fakewallet');
    ConstantClass.Network = prefs.getString('Network') ?? "Pox Testnet";

  }

  // static Future<void> transactionconfirm(String amount,String to) async {
  //  var uri = Uri.parse(Api.SHASTA + Api.Transactionconfirm);
  //
  //  var response = await http.post(uri,
  //      headers: {"Content-Type": "application/json"},
  //      body: jsonEncode({
  //       "owner_address": "TZ4UXDV5ZhNW7fb2AMSbgfAEZ7hWsnYS2g",
  //       "to_address": "TPswDDCAWhJAZGdHPidFg5nEf8TkNToDX1",
  //       "amount": 1000,
  //       "visible": true
  //      }));
  //  print("???????????   trraaannnsss"+uri.toString());
  //  print("???????????   trraaannnsss"+response.body.toString());
  //  if (response.statusCode == 200) {
  //
  //
  //  } else {
  //   print("???????????   trraaannnsss"+response.body.toString());
  //  }
  // }


  // static List<CoinData> allCoinList = [
  //   CoinData(
  //     coinNetwork: "tron",
  //     isOnGecko: true,
  //     web3HttpUrl: '',
  //     coinID: 'pollux',
  //     coinName: 'POX',
  //     coinImage: 'assets/images/trx.png',
  //     coinSymbol: 'TRX',
  //     coindecimal: 6,
  //     price: 0.0,
  //     coinPercentage: 0.0,
  //     graphData: [],
  //   ),
  // ];

//   Future<void> sendTron(String toAddress, String sendAmount, CoinData coinData,BuildContext context) async {
//    sending = true;
//
//    try {
//     double amount = double.parse(sendAmount);
//     final HDWallet wallet =
//     HDWallet.createWithMnemonic("inflict summer build ability iron draw suffer deliver only obtain embark sport");
//     int coinType = TWCoinType.TWCoinTypeTron;
//     final key = wallet.getKeyForCoin(coinType);
//     final privateKey = hex.encode(key.data());
//     dev.log(privateKey);
//     final address = wallet.getAddressForCoin(coinType);
//     dev.log("---owner Addredd> "+address);
//
//     int coin = TWCoinType.TWCoinTypeTron;
//     // String nowBlock =
//     //     '{"blockID":"0000000001120ece986cc79d7663a35c54907ae85ade9da9183dee4d6ba8be19","block_header":{"raw_data":{"number":17960654,"txTrieRoot":"0000000000000000000000000000000000000000000000000000000000000000","witness_address":"410765bed97bbd836f6e489265fd0d9ca1c888e606","parentHash":"0000000001120ecd85c65f3bbff78fe881b986925007e072c657c6d510b679d1","version":22,"timestamp":1630467627000},"witness_signature":"b7d1aef62ac6f8b5069017514386d08d914f9c5f471e17125397799f454243383cc2e2d06b3c97d5b9430def52150847ddcab43a88607806951065db42cc587600"}}';
//     // Map blockHeader = json.decode(nowBlock)['block_header']['raw_data'];
//     // print(blockHeader);
//     final addressList =
//     Base58.base58DecodeNoCheck(wallet.getAddressForCoin(coin));
//     if (addressList == null) {
//      print("addressList null !!!");
//      return;
//     }
//     String hexaaddress = hex.encode(addressList);
//
//     dev.log('===< adress == $hexaaddress');
//
//     Uint8List originFromAddress =
//     Base58.base58Decode(address)!.sublist(0, 21);
//     late Uint8List originToAddress;
//     try {
//      originToAddress = Base58.base58Decode(toAddress)!.sublist(0, 21);
//     } catch (e) {
//      print("'Please enter valid address'");
//       sending = false;
//      return;
//     }
//
//     final tc = $t.TransferContract();
//     final channel = ClientChannelManager.getChannel(
// //https://pollux-fullnode.lbmdemo.com/
// //          'https://pollux-soliditynode.lbmdemo.com/'
//         '3.109.94.186'
//
//     );
//     print("-->21212 "+channel.toString());
//     //--> grpc.nile.trongrid.io
//     // I/flutter ( 4967):  --> 50051
//     final stub = $t.WalletClient(channel);
//
//     tc.amount = $fixnum.Int64(amount.toInt());
//     tc.ownerAddress = originFromAddress;
//     tc.toAddress = originToAddress;
//     $t.TransactionExtention trxResult = await stub.createTransaction2(tc);
//     $t.Transaction transaction = trxResult.transaction;
//     $t.Transaction_raw rawData = trxResult.transaction.rawData;
//
//     Uint8List hash =
//     sha256.convert(rawData.writeToBuffer()).bytes as Uint8List;
//
//     MsgSignature msgSignature = sign(hash, hexToBytes(privateKey));
//
//     TronMsgSignature msgSignature2 = TronMsgSignature(
//         intToBytes(msgSignature.r),
//         intToBytes(msgSignature.s),
//         msgSignature.v);
//     Uint8List ms2 = msgSignature2.getSignature();
//
//     transaction.signature.add(ms2);
//
//     $t.Return result = await stub.broadcastTransaction(transaction);
//     dev.log(result.writeToJson());
//     if (result.toProto3Json().toString().contains('true') == true) {
//      print("sucess++++++++++++++++++++  ");
//      ConstantClass.showToast('Success !', );
//      print('transTrx == > True');
//      Navigator.pop(context, true);
//     } else {
//      utf8
//          .decode(result.message)
//          .toLowerCase()
//          .contains('Invalid point compression'.toLowerCase())
//          ? ConstantClass.showToast(
//
//       'Failed \n Make sure you have fund & gas fee for transaction then try again.',
//      )
//          : ConstantClass.showToast(
//       'Failed \n ${utf8.decode(result.message)} !',);
//      print('transTrx result error msg: ${utf8.decode(result.message)}');
//       sending = false;
//     }
//    } catch (e,stack) {
//     print("===> "+e.toString());
//     print("===> "+stack.toString());
//     // ConstantClass.showToast( e.toString(), );
//      sending = false;
//     throw e;
//    }
//
//  }

  static Future<void> showInformationDialog(BuildContext context,int index) async {
    String name= index==0?"Private Key":index==1?"Key Store":"Mnemonic";
    String description= index==0?"Please correctly copy the private key in order":
    index==1?"Please store the Keystore in a safe place and keep your password in mind":
    "Please Write down the following words in the correct\n order.";
    ToastContext().init(context);
    return await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                scrollable: true,
                backgroundColor: ColorsCustom.white,
                shadowColor: ColorsCustom.white,
                insetPadding: EdgeInsets.zero,
                // insetPadding:  EdgeInsets.all(15),
                contentPadding: EdgeInsets.zero,
                content: Form(
                    key: _formKey,
                    child: Container(
                      height: CustomDimension.myheight(context),
                      width: CustomDimension.mywidth(context),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              height: CustomDimension.myheight(context) / 7,
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 70,
                                  left: CustomDimension.mywidth(context) / 30,
                                  right: CustomDimension.mywidth(context) / 30),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  gradient: LinearGradient(
                                      colors: [
                                        ColorsCustom.darkPurple,
                                        ColorsCustom.lightPurple
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.arrow_back,
                                          size: 32, color: Colors.white)),
                                  SizedBox(
                                      width:
                                      CustomDimension.mywidth(context) / 4.8),
                                  CustomFonts.heading20(
                                      'Back Up ${name}', Colors.white),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 30,
                                  left: CustomDimension.mywidth(context) / 20,
                                  right: CustomDimension.mywidth(context) / 20),
                              child: CustomFonts.text13(
                                  description.toString(),
                                  ColorsCustom.black),
                            ),
                            SizedBox(
                              height: CustomDimension.myheight(context) / 8,
                            ),
                            Center(
                                child: CustomImages.Customimg(
                                    context, CustomImages.backupPrivatekey,scale: 1.6)),
                            SizedBox(
                              height: CustomDimension.myheight(context) / 20,
                            ),
                            Center(
                                child: CustomFonts.text12(
                                    "Anyone with your $name can access all your\n assets. Please keep the information to yourself.",
                                    ColorsCustom.black.withOpacity(0.6))),
                            SizedBox(
                              height: CustomDimension.myheight(context) / 20,
                            ),
                            InkWell(
                              child: Center(
                                child: Container(
                                  width: CustomDimension.mywidth(context) / 2.2,
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, right: 20, left: 20),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
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
                                      )),
                                  child: Center(
                                      child: CustomFonts.text15(
                                          "View $name", ColorsCustom.white)),
                                ),
                              ),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if(index==0){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => BackupPrivate_Key('Back Up Private Key')));

                                  }else if (index==1){
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => BackupPrivate_Key('Back Up Keystore')));
                                  }else{
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => BackUp_Mnemonic(view: true,)));
                                  }


                                }
                              },
                            ),

                            SizedBox(
                              height: CustomDimension.myheight(context) / 12,
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 30,
                                  left: CustomDimension.mywidth(context) / 20,
                                  right: CustomDimension.mywidth(context) / 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImages.Customimg(
                                      context, CustomImages.warning,scale: 2.0,
                                      color: ColorsCustom.orangelight),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CustomFonts.Text12(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.",
                                      ColorsCustom.black54),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 30,
                                  left: CustomDimension.mywidth(context) / 20,
                                  right: CustomDimension.mywidth(context) / 20),
                              child: InkWell(
                                child: Container(
                                  width: CustomDimension.mywidth(context),
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, right: 20, left: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffC1C1C1),
                                  ),
                                  child: Center(
                                      child: CustomFonts.text15(
                                          "Already Backed Up",
                                          ColorsCustom.white)),
                                ),
                                onTap: () {},
                              ),
                            ),
                            SizedBox(
                              height: CustomDimension.myheight(context) / 20,
                            ),

                          ],
                        ),
                      ),
                    )),
              ),
            );
          });
        });
  }
  static Future<void> enterPassword(BuildContext context,bool delete,bool transaction,int index,{String? amount,String? to,String? from}) async {
    ToastContext().init(context);
    pass_Controller.clear();
    return await showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                scrollable: true,
                backgroundColor: ColorsCustom.white,
                shadowColor: ColorsCustom.white,
                // insetPadding: EdgeInsets.zero,
                insetPadding:  const EdgeInsets.all(15),
                contentPadding: EdgeInsets.zero,
                content:
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: CustomDimension.myheight(context) / 30,
                              left: CustomDimension.mywidth(context) / 20,
                              right: CustomDimension.mywidth(context) / 20),
                          child: CustomFonts.heading18(
                              "Enter Password",
                              ColorsCustom.black),
                        ),


                        Padding(
                          padding: EdgeInsets.only(
                              top: CustomDimension.myheight(context) / 80,
                              left: CustomDimension.mywidth(context) / 20,
                              right: CustomDimension.mywidth(context) / 20),
                          child: orangecard(context,
                              toppadding: CustomDimension.myheight(context)/150,
                              leftpadding: CustomDimension.myheight(context)/35,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: ColorsCustom.black12),
                              ),
                              mychild: TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter password';
                                  }
                                },
                                controller: pass_Controller,
                                decoration:InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter the Password",
                                  hintStyle:  TextStyle(
                                    color: ColorsCustom.black38,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,

                                  ),
                                  labelStyle: TextStyle(
                                    color: ColorsCustom.black,
                                    fontSize: 14, fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),),)),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 80,
                                  left: CustomDimension.mywidth(context) / 20,
                                  right: CustomDimension.mywidth(context) / 20),
                              child: InkWell(
                                child: Center(
                                  child: Container(
                                    width: CustomDimension.mywidth(context) / 2.8,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    decoration: BoxDecoration(
                                      color: ColorsCustom.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: ColorsCustom.grey.withOpacity(0.3)),
                                    ),
                                    child: Center(
                                        child: CustomFonts.text15(
                                            "Cancel", ColorsCustom.black)),
                                  ),
                                ),
                                onTap: () {
                                  pass_Controller.clear();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(
                                  top: CustomDimension.myheight(context) / 80,
                                  left: CustomDimension.mywidth(context) / 20,
                                  right: CustomDimension.mywidth(context) / 20),
                              child: InkWell(
                                child: Center(
                                  child: Container(
                                    width: CustomDimension.mywidth(context) / 2.8,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff6E68EF),
                                          Color(0xff150CD1),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: ColorsCustom.grey.withOpacity(0.3)),
                                    ),
                                    child: Center(
                                        child: CustomFonts.text15(
                                            "Confirm", ColorsCustom.white)),
                                  ),
                                ),
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Do something like updating SharedPreferences or User Settings etc.
                                    if(pass_Controller.text==ConstantClass.password){
                                      if(delete==true){
                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.clear();
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                            builder: (context) => const Register()),(Route<dynamic> route) => false);
                                      }else if(transaction==true){
                                        print("point checkkkkkkk");
                                        Navigator.of(context).pop();
                                        pass_Controller.clear();
                                        TrustWalletCoreLib.init();

                                        // sendTron("TDD4UqVjAiaok1C8ffEGowSUjyPYJA9XHw", "1", allCoinList[0],context: context);
                                        //// lets call api
                                        // transactionconfirm(amount.toString(),to.toString());
                                        // sendTron(to.toString(), amount.toString(), allCoinList[0],context);cv


                                      }
                                      else{
                                        ConstantClass.showInformationDialog(context,index);

                                      }


                                    }else{
                                      Navigator.of(context).pop();
                                      pass_Controller.clear();
                                      ConstantClass.showToast("You entered a wrong password.", duration: Toast.lengthLong);
                                      // Toast.show("You entered a wrong password.", duration: Toast.lengthShort, gravity:  Toast.bottom);
                                    }

                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CustomDimension.myheight(context) / 20,
                        ),
                      ],
                    ))
            );
          });
        });
  }


}


// class ScanPaySendCoin extends StatefulWidget {
//  String? coinAddress;
//  int?  RadioIndex;
//  CoinData coinData;
//
//  ScanPaySendCoin({Key? key, required this.coinData,this.coinAddress,this.RadioIndex}) : super(key: key);
//
//  @override
//  State<ScanPaySendCoin> createState() => _ScanPaySendCoinState();
// }

// class _ScanPaySendCoinState extends State<ScanPaySendCoin> {

int radioIndex = 0;
bool radiobutton  = false;

bool isDark = false;
TextEditingController addressController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController memoController = TextEditingController();
GlobalKey<FormState> key = GlobalKey();
bool sending = false;
String gasFee = '0.0';

// var chainID;
var result;
var tokenBalance;



// ContractFunction _balanceFunction(DeployedContract contract) =>
//     contract.function('balanceOf');


//
// Future<BigInt> getTokenBalancefromContract(
//     EthereumAddress from, DeployedContract contract) async {
//  // final client = Web3Client(
//   // allCoinList.ˀˀˀ
//   //
//   // all coinData!.web3HttpUrl,
//   // http.Client(),
//  // );
//
//  // final response = await client.call(
//  //  contract: contract,
//  //  function: _balanceFunction(contract),
//  //  params: [from],
//  // );
//  return 1/ BigInt;
// }
//
// getGasFee() async {
//  final client = Web3Client(
//   widget.coinData!.web3HttpUrl,
//   http.Client(),
//  );
//
//  final gasPrice = await client.getGasPrice();
//  final finalPrice =
//  gasPrice.getValueInUnit(EtherUnit.ether).toStringAsFixed(16);
//  final estimatedGas = await client.estimateGas();
//
//  setState(() {
//   gasFee = (double.parse(finalPrice) * estimatedGas.toDouble())
//       .toStringAsFixed(9);
//  });
// }

//
//
// trc20Transfer(String toAddress, String sendAmount, CoinData coinData) async {
//   final HDWallet wallet =
//   HDWallet.createWithMnemonic("inflict summer build ability iron draw suffer deliver only obtain embark sport");
//   int coinType = TWCoinType.TWCoinTypeTron;
//   final key = wallet.getKeyForCoin(coinType);
//   final privateKey = hex.encode(key.data());
//   dev.log(privateKey);
//   final address = wallet.getAddressForCoin(coinType);
//   dev.log(address);
//   final channel = ClientChannelManager.getChannel(
//     // coinData.coinNetwork == NetworkType.TronTestnet
//     //     ?
//       'http://3.109.94.186'
//     // : 'grpc.trongrid.io'
//   );
//   final stub = $t.WalletClient(channel);
//   // try {
//   $t.SmartContract response = await stub.getContract($t.BytesMessage()
//     ..value = Base58.base58Decode(allCoinList[0].contractAddress.toString() )!
//         .sublist(0, 21));
//   String abiCode = jsonEncode(response.abi.toProto3Json()).substring(10);
//   abiCode = abiCode.substring(0, abiCode.length - 1);
//   dev.log('Abi protoJson ${response.abi.toProto3Json()}');
//   dev.log('Abi Code $abiCode');
//   String functionName = 'transfer';
//   AbiEntity abiEntity = AbiEntity.fromJson(
//       response.abi.toProto3Json() as Map<String, dynamic>);
//   dev.log('Abi Entity $abiEntity');
//
//   List<String> inputList = [];
//   if (abiEntity != null && abiEntity.entrys != null) {
//     for (Entrys item in abiEntity.entrys!) {
//       if (functionName == item.name) {
//         if (item.inputs != null) {
//           for (Inputs input in item.inputs!) {
//             inputList.add(input.type!);
//           }
//         }
//       }
//     }
//   }
//   dev.log('input List $inputList');
//   Uint8List methodID = abi.methodID(functionName, inputList);
//
//   List<dynamic> params = [];
//   String abiToAddress = getAbiTronAddress(toAddress);
//   double amount = double.parse(sendAmount) * 6;
//   params.add(abiToAddress);
//   params.add(amount.toStringAsFixed(0));
//   dev.log('params $params');
//   Uint8List rawEncode = abi.rawEncode(inputList, params);
//   Uint8List dataList = hexToBytes('a9059cbb' + bytesToHex(rawEncode));
//   dev.log(
//       'dataList Data hex = > ${bytesToHex(methodID)} -- ${bytesToHex(rawEncode)}');
//   //print('encode dataList1 hex: ${bytesToHex(dataList)}');
//
//   String hexPrivateKey = privateKey;
//
//   bool flag = await execute(
//       stub, hexPrivateKey, address, coinData.contractAddress!, dataList, 0);
//   if (flag) {
//     ConstantClass.showToast( 'Success !',);
//   } else {
//     ConstantClass.showToast( 'Failed', );
//   }
//   // $t.SmartContract response = await stub.getContract($t.BytesMessage()
//   //   ..value = Base58.base58Decode('TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t')!
//   //       .sublist(0, 21));
//   // String abiCode = jsonEncode(response.abi.toProto3Json()).substring(10);
//   // abiCode = abiCode.substring(0, abiCode.length - 1);
//
//   // String functionName = 'transfer';
//   // AbiEntity abiEntity = AbiEntity.fromJson(
//   //     response.abi.toProto3Json() as Map<String, dynamic>);
//   // List<String> inputList = [];
//   // if (abiEntity != null && abiEntity.entrys != null) {
//   //   for (Entrys item in abiEntity.entrys!) {
//   //     if (functionName == item.name) {
//   //       if (item.inputs != null) {
//   //         for (Inputs input in item.inputs!) {
//   //           inputList.add(input.type!);
//   //         }
//   //       }
//   //     }
//   //   }
//   // }
//   // log('input List => $inputList');
//   // double amount = double.parse('1') * getPrecision(coinData!.coindecimal);
//   // print('1');
//   // Uint8List methodID = abi.methodID(functionName, inputList);
//   // print('2');
//   // print(amount.toStringAsFixed(0));
//   // List<dynamic> params = [];
//   // String abiToAddress =
//   //     getAbiTronAddress('THTbeYRrETr3rSoQDP14iyGcgrf9p9XuNr');
//   // params.add(abiToAddress);
//   // params.add(amount.toStringAsFixed(0));
//
//   // Uint8List rawEncode = abi.rawEncode(inputList, params);
//   // Uint8List dataList =
//   //     hexToBytes(bytesToHex(methodID) + bytesToHex(rawEncode));
//   // //print('encode dataList1 hex: ${bytesToHex(dataList)}');
//
//   // String hexPrivateKey = privateKey;
//   // log('private Key Hex ->  $hexPrivateKey ');
//   // bool flag = await execute(stub, hexPrivateKey, address,
//   //     'TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t', dataList, 0);
//   sending = false;
//   // Navigator.pop(context);
//   print(flag);
//   // dev.log(e.toString());
//
// }
// }

// Future<bool> execute(
//     $t.WalletClient stub,
//     String hexPrivateKey,
//     String base58OwnerAddress,
//     String base58ContractAddress,
//     Uint8List dataList,
//     int callValue) async {
//   final $t.TriggerSmartContract req = $t.TriggerSmartContract();
//   req.ownerAddress = Base58.base58Decode(base58OwnerAddress)!.sublist(0, 21);
//   req.contractAddress =
//       Base58.base58Decode(base58ContractAddress)!.sublist(0, 21);
//   req.callValue = $fixnum.Int64(callValue);
//   req.data = dataList;

//   dev.log('dataList $dataList');
//   $t.Transaction trans = await buildTransaction(stub, req, hexPrivateKey,
//       $t.Transaction_Contract_ContractType.TriggerSmartContract, dataList);
//   $t.Return result = await stub.broadcastTransaction(
//     trans,
//   );

//   dev.log(result.toProto3Json().toString());
//   if (result.toProto3Json().toString().contains('true') == true) {
//     return true;
//   } else {
//     ConstantClass.showToast(
//       'Failed ! ${utf8.decode(result.message)}',);
//     print('execute error msg: ${utf8.decode(result.message)}');
//     return false;
//   }
// }

// Future<$t.Transaction> buildTransaction(
//     $t.WalletClient stub,
//     $t.TriggerSmartContract req,
//     String hexPrivateKey,
//     $t.Transaction_Contract_ContractType ctxType,
//     Uint8List data) async {
//   $t.Transaction trans = $t.Transaction();
//   trans.rawData = $t.Transaction_raw();
//   $t.Transaction_Contract transContract = $t.Transaction_Contract();
//   transContract.type = ctxType;
//   transContract.parameter = $0.Any.pack(req);
//   trans.rawData.contract.add(transContract);

//   $t.BlockExtention resp = await stub.getNowBlock2($t.EmptyMessage());
//   trans.rawData.refBlockBytes = resp.blockHeader.rawData.number
//       .toBytes()
//       .reversed
//       .toList()
//       .sublist(6, 8);
//   trans.rawData.refBlockHash = sha256
//       .convert(resp.blockHeader.rawData.writeToBuffer())
//       .bytes
//       .sublist(8, 16);
//   trans.rawData.timestamp =
//       $fixnum.Int64(DateTime.now().toUtc().millisecondsSinceEpoch);
//   trans.rawData.feeLimit = $fixnum.Int64(30 * 1000000);
//   trans.rawData.expiration = $fixnum.Int64(DateTime.now()
//       .toUtc()
//       .add(Duration(seconds: 300))
//       .millisecondsSinceEpoch);

//   Uint8List hash =
//   sha256.convert(trans.rawData.writeToBuffer()).bytes as Uint8List;

//   MsgSignature msgSignature = sign(hash, hexToBytes(hexPrivateKey));

//   // TronMsgSignature msgSignature2 = TronMsgSignature(
//   //     intToBytes(msgSignature.r), intToBytes(msgSignature.s), msgSignature.v);
//   // Uint8List ms2 = msgSignature2.getSignature();
//   //
//   // trans.signature.add(ms2);
//   dev.log('Transction --> ${trans.writeToJson()}');
//   return trans;
// }

// String getAbiTronAddress(String base58Address) {
//   Uint8List address = Base58.base58Decode(base58Address)!.sublist(1, 21);
//   return '0x' + bytesToHex(address);
// }
//
// Future<void> sendTron(String toAddress, String sendAmount, CoinData coinData ,{context}) async {
//   // setState(() {
//   sending = true;
//   // });
//   if (allCoinList[0].coinAbi != null) {
//     trc20Transfer(toAddress, sendAmount, coinData);
//   } else {
//     try {
//       double amount = double.parse(sendAmount);
//       final HDWallet wallet =
//       HDWallet.createWithMnemonic("inflict summer build ability iron draw suffer deliver only obtain embark sport");
//       int coinType = TWCoinType.TWCoinTypeTron;
//       final key = wallet.getKeyForCoin(coinType);
//       final privateKey = hex.encode(key.data());
//       dev.log(privateKey);
//       final address = wallet.getAddressForCoin(coinType);
//       dev.log("---owner Addredd> "+address);
//
//       int coin = TWCoinType.TWCoinTypeTron;
//       // String nowBlock =
//       //     '{"blockID":"0000000001120ece986cc79d7663a35c54907ae85ade9da9183dee4d6ba8be19","block_header":{"raw_data":{"number":17960654,"txTrieRoot":"0000000000000000000000000000000000000000000000000000000000000000","witness_address":"410765bed97bbd836f6e489265fd0d9ca1c888e606","parentHash":"0000000001120ecd85c65f3bbff78fe881b986925007e072c657c6d510b679d1","version":22,"timestamp":1630467627000},"witness_signature":"b7d1aef62ac6f8b5069017514386d08d914f9c5f471e17125397799f454243383cc2e2d06b3c97d5b9430def52150847ddcab43a88607806951065db42cc587600"}}';
//       // Map blockHeader = json.decode(nowBlock)['block_header']['raw_data'];
//       // print(blockHeader);
//       final addressList =
//       Base58.base58DecodeNoCheck(wallet.getAddressForCoin(coin));
//       if (addressList == null) {
//         print("addressList null !!!");
//         return;
//       }
//       String hexaaddress = hex.encode(addressList);
//
//       dev.log('===< adress == $hexaaddress');
//
//       Uint8List originFromAddress =
//       Base58.base58Decode(address)!.sublist(0, 21);
//       late Uint8List originToAddress;
//       try {
//         originToAddress = Base58.base58Decode(toAddress)!.sublist(0, 21);
//       } catch (e) {
//         print("'Please enter valid address'");
//         //setState(() {
//         sending = false;
//         //  });
//         return;
//       }
//
//       final tc = $t.TransferContract();
//       final channel = ClientChannelManager.getChannel(
// //https://pollux-fullnode.lbmdemo.com/
// //          'https://pollux-soliditynode.lbmdemo.com/'
//           '3.109.94.186'
//
//       );
//       print("-->21212 "+channel.toString());
//       //--> grpc.nile.trongrid.io
//       // I/flutter ( 4967):  --> 50051
//       final stub = $t.WalletClient(channel);
//
//       tc.amount = $fixnum.Int64(amount.toInt());
//       tc.ownerAddress = originFromAddress;
//       tc.toAddress = originToAddress;
//       $t.TransactionExtention trxResult = await stub.createTransaction2(tc);
//       $t.Transaction transaction = trxResult.transaction;
//       $t.Transaction_raw rawData = trxResult.transaction.rawData;
//
//       Uint8List hash =
//       sha256.convert(rawData.writeToBuffer()).bytes as Uint8List;
//
//       MsgSignature msgSignature = sign(hash, hexToBytes(privateKey));
//
//       TronMsgSignature msgSignature2 = TronMsgSignature(
//           intToBytes(msgSignature.r),
//           intToBytes(msgSignature.s),
//           msgSignature.v);
//       Uint8List ms2 = msgSignature2.getSignature();
//
//       transaction.signature.add(ms2);
//
//       $t.Return result = await stub.broadcastTransaction(transaction);
//       dev.log(result.writeToJson());
//       if (result.toProto3Json().toString().contains('true') == true) {
//         print("sucess++++++++++++++++++++  ");
//         ConstantClass.showToast('Success !', );
//
//         print('transTrx == > True');
//
//         Navigator.pop(context);
//       } else {
//         utf8
//             .decode(result.message)
//             .toLowerCase()
//             .contains('Invalid point compression'.toLowerCase())
//             ? ConstantClass.showToast(
//
//           'Failed \n Make sure you have fund & gas fee for transaction then try again.',
//         )
//             : ConstantClass.showToast(
//           'Failed \n ${utf8.decode(result.message)} !',);
//         print('transTrx result error msg: ${utf8.decode(result.message)}');
//         //setState(() {
//         sending = false;
//         // });
//       }
//     } catch (e,stack) {
//       print("===> "+e.toString());
//       print("===> "+stack.toString());
//       // ConstantClass.showToast( e.toString(), );
//       //   setState(() {
//       sending = false;
//       //  });
//       throw e;
//     }
//   }
// }



@override
Widget build(BuildContext context) {
  Theme.of(context).brightness == Brightness.dark
      ? isDark = true
      : isDark = false;

  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Scaffold(
    body: SingleChildScrollView(
        child: InkWell(child: Text("Send Tron"),onTap: (){

        },)
    ),
  );
}
// }