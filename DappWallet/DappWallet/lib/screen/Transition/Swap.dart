import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dappwallet/data/Repo/allRepo.dart';
import 'package:dappwallet/screen/Lock/LockScreen.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:marquee/marquee.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Swap extends StatefulWidget {
  const Swap({super.key});

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  bool isDark = false;
  late String privateKey;
  EthPrivateKey? credentials;
  EthereumAddress? userAddress;
  bool approving = false;
  // int chainID = 97;
  late String gasFee;
  String sendingBalance = '0';
  String recevingBalance = '0';
  bool swapped = false;
  bool swaping = false;
  bool isProgress = false;
  bool toLoading = false;
  TextEditingController amountOutController = TextEditingController();
  TextEditingController amountInController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  SwapCoinData sendingCoin = swapcoindata.swapCoins[0];
  SwapCoinData recevingCoin = swapcoindata.toSwapCoins[0];
  bool isAllowed = false;

  // final EthereumAddress pancakeRouterAddress =
  //     EthereumAddress.fromHex('0xF9f93cF501BFaDB6494589Cb4b4C15dE49E85D0e');
  String WBNB_Address = "0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd";

  void getcredentials() async {
    privateKey =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletprivateKey);
    credentials = EthPrivateKey.fromHex(privateKey);
    userAddress = credentials!.address;
    sendingCoin = swapcoindata.swapCoins[0];
    recevingCoin = swapcoindata.toSwapCoins[0];
    getSendingBalance(sendingCoin);
    getRecevingBalance(recevingCoin);
  }

  // final client = Web3Client(
  //   AppContant.RpcBsctestnet,
  //   http.Client(),
  // );

  // ///// Function to get receipt   /////
  // Future<TransactionReceipt?> getTransactionReceipt(String txHash) async {
  //   return await client.getTransactionReceipt(txHash);
  // }

  // Stream<TransactionReceipt> pollTransactionReceipt(String txHash,
  //     {int pollingTimeMs = 1500}) async* {
  //   final StreamController<TransactionReceipt> controller = StreamController();
  //   Timer? timer;

  //   Future<void> tick() async {
  //     final receipt = await getTransactionReceipt(txHash);
  //     if (receipt != null && !controller.isClosed) {
  //       timer?.cancel();
  //       controller.add(receipt);
  //       await controller.close();
  //     }
  //   }

  //   // start first tick before timer if the receipt is available immediately
  //   await tick();

  //   if (!controller.isClosed) {
  //     timer =
  //         Timer.periodic(Duration(milliseconds: pollingTimeMs), (timer) async {
  //       await tick();
  //     });
  //   }

  //   yield* controller.stream;
  // }

/////  GET BALANCE    /////
  getSendingBalance(SwapCoinData selected) async {
    // setState(() {
    //   isProgress = true;
    // });
    if (selected.coinAbi == null) {
      Address().getCoinBalnace(privateKey, selected.web3HttpUrl).then((value) {
        sendingBalance = value.getValueInUnit(EtherUnit.ether).toString();
        setState(() {
          isProgress = false;
        });
      });
    } else {
      Address()
          .getBalance_WithSmartContract(
              Contactaddress: selected.contractAddress!,
              Contractfile: selected.coinAbi!,
              funcationname: "balanceOf",
              privatekey: privateKey,
              url: selected.web3HttpUrl)
          .then((e) {
        sendingBalance = e.toString();
        setState(() {
          isProgress = false;
        });
      });
    }
    //  / getRecevingBalance(recevingCoin);
    setState(() {
      // sendingBalance =
      //     (double.parse(tb.toString()) / pow(10, selected.coindecimal))
      //         .toString();
      isProgress = false;
    });
    // } else {
    //   var balance = await getTokenBalance(userAddress);
    //   setState(() {
    //     tokenBalance = balance;
    //     isProgress = false;
    //   });
    // }
  }

  getRecevingBalance(SwapCoinData recevingCoin) async {
    //  // print("Balnace");
    //   setState(() {
    //     toLoading = true;
    //   });
    try {
      if (recevingCoin.coinAbi == null) {
        Address()
            .getCoinBalnace(privateKey, recevingCoin.web3HttpUrl)
            .then((value) {
          recevingBalance = value.getValueInUnit(EtherUnit.ether).toString();
        });
        setState(() {
          toLoading = false;
        });
      } else {
        Address()
            .getBalance_WithSmartContract(
                Contactaddress: recevingCoin.contractAddress!,
                Contractfile: recevingCoin.coinAbi!,
                funcationname: "balanceOf",
                privatekey: privateKey,
                url: recevingCoin.web3HttpUrl)
            .then((e) {
          recevingBalance = e.toString();
        });
        setState(() {
          toLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        toLoading = false;
      });
    }
  }

  @override
  void initState() {
    getcredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarSecond(title: Lanuage.swap, context: context, back: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Container(
                width: width,
                padding: EdgeInsets.only(
                    left: width * 0.08,
                    right: width * 0.04,
                    top: height * 0.035,
                    bottom: height * 0.035),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "pay",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width * 0.25,
                              child: TextFormField(
                                controller: amountInController,
                                onChanged: (val) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter amount';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            isProgress
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(
                                    width: width * 0.35,
                                    height: height * 0.05,
                                    child: Marquee(
                                      text:
                                          "${Lanuage.yourbalance} : ${double.parse(sendingBalance).toStringAsFixed(8)} ${sendingCoin.coinSymbol} ",
                                    ),
                                  )
                          ],
                        ),
                        Container(
                          height: height * 0.056,
                          width: width * 0.34,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.01,
                              vertical: height * 0.01),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).hoverColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? Colors.grey : Colors.white12,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    sendingCoin.coinImage,
                                    height: height * 0.03,
                                    width: height * 0.03,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              SizedBox(
                                width: width * 0.12,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    sendingCoin.coinSymbol,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                        InkWell(
                          onTap: () async {
                            final sending = sendingCoin;
                            sendingCoin = recevingCoin;
                            recevingCoin = sending;
                            setState(() {});
                            getSendingBalance(sendingCoin);
                            getRecevingBalance(recevingCoin);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: width * 0.1),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Image.asset(
                                Appimages.swap,
                                height: height * 0.04,
                                width: height * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "You get",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 15),
                                ),
                                Text(
                                  ' (estimated)',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 10),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width * 0.25,
                              child: TextFormField(
                                controller: amountOutController,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            toLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(
                                    width: width * 0.3,
                                    height: height * 0.2,
                                    child: Marquee(
                                      text:
                                          'Balance : ${double.parse(recevingBalance).toString().length > 8 ? double.parse(recevingBalance).toStringAsFixed(7) : double.parse(recevingBalance).toString()} ${recevingCoin.coinSymbol} ',
                                    ),
                                  )
                          ],
                        ),
                        Container(
                          height: height * 0.056,
                          width: width * 0.34,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.01,
                              vertical: height * 0.01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: isDark
                                ? Color(0xFF39404B)
                                : Colors.grey.shade500,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark ? Colors.grey : Colors.white12,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    recevingCoin.coinImage,
                                    height: height * 0.03,
                                    width: height * 0.03,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              SizedBox(
                                width: width * 0.12,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    recevingCoin.coinSymbol,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Slippage-Tolerance - 1% ',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              swaping
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: height * 0.05,
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7))),
                        onPressed: () async {
                          // WBNB_toUSDt(
                          //     "0x4408ada570f28ebf261294e895a94cc1cb0e46ce0cb162a7277f3d5fe21d2c65");
                          // return;
                          if (double.tryParse(amountInController.text) ==
                                  null ||
                              double.parse(amountInController.text) <= 0) {
                            showCustomSnackBar(
                                message: 'Enter a valid amount', isError: true);
                            return;
                          }
                          if ((double.parse(amountInController.text) >
                              (double.tryParse(sendingBalance) ?? 0))) {
                            showCustomSnackBar(
                                message: 'Insufficient Balance', isError: true);

                            return;
                          }

                          Get.toNamed(AppRoute.localauthVerifyScreen,
                                  arguments: VerifyModel(
                                      isForward: false, routeName: ""))!
                              .then((value) {
                            if (value != null && value == true) {
                              if (sendingCoin.coinSymbol.toUpperCase() ==
                                  "BNB") {
                                setState(() {
                                  swaping = true;
                                });
                                Convert_WBNB();
                              } else {}
                              setState(() {
                                swaping = true;
                              });
                              // WBNB_toUSDt();
                              ApproveTranstion();
                            }
                          });
                        },
                        child: Text(
                          Lanuage.swap,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   KeyValues.pleaseDont,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16,
              //       color: Colors.red),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  static BigInt getWei(String amount, int decimal) {
    final int max = decimal;
    if (amount == "") {
      amount = "0.0";
    }
    final int dotIndex = amount.indexOf(".");
    String ans;

    if (dotIndex == -1) {
      ans = EtherAmount.fromUnitAndValue(EtherUnit.ether, amount)
          .getInWei
          .toString();
    } else {
      final int zerosNo = 18 - (amount.length - dotIndex - 1);
      amount = amount.replaceAll(".", "");
      if (zerosNo < 0) {
        amount = amount.substring(0, amount.length + zerosNo - 1);
      } else {
        for (var i = 0; i < zerosNo; i++) {
          amount += "0";
        }
      }
      ans = amount;
    }
    ans = ans.substring(0, ans.length - (18 - max));
    return BigInt.parse(ans.toString());
  }

  Future<void> getM1VerseCoinDetail() async {
    try {
      final m1VerseUrl = Uri.parse(
          'https://api.pancakeswap.info/api/v2/tokens/0xf3eDD4f14a018df4b6f02Bf1b2cF17A8120519A2');

      final m1verseResponse = await http.get(m1VerseUrl);

      var m1verseData = jsonDecode(m1verseResponse.body);

      if (mounted) {
        setState(() {
          recevingCoin.price =
              double.parse(m1verseData['data']['price'].toString());
        });
      }
    } catch (e) {}
  }

  //     final transaction = Transaction.callContract(
  //         contract: contract,
  //         function: contract.function('approve'),
  //         parameters: [
  //           pancakeRouterAddress,
  //           getWei(approveAmount, sendingCoin.coinDecimal)
  //         ]);
  //     final res = await client.sendTransaction(credentials!, transaction,
  //         chainId: chainID.toInt());
  //     final Stream<TransactionReceipt> result = pollTransactionReceipt(res);
  //     result.listen((event) async {
  //       isAllowed = event.status!;
  //       if (event.status!) {
  //         isAllowed = true;
  //       } else {
  //         isAllowed = false;
  //       }
  //     });
  //     if (isAllowed) {
  //       setState(() {
  //         isAllowed = true;
  //         showCustomSnackBar(message: "Approve", isError: false);
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       showCustomSnackBar(message: "Something Went Wrong", isError: false);
  //     });
  //   }
  // }

  List<EthereumAddress> _pathListToAddresses(List<String> paths) {
    return paths.map((path) => EthereumAddress.fromHex(path)).toList();
  }

  //         ? showCustomSnackBar(
  //             message: e.toString().split('"')[1], isError: true)
  //         : showCustomSnackBar(message: e.toString(), isError: true);
  //     setState(() {
  //       swaping = false;
  //     });
  //   }
  // }

  Convert_WBNB() {
    //convert amount into stand
    // final amt = getWei(amountInController.text, sendingCoin.coinDecimal);

    try {
      Address()
          .Send_InfoContract(
              Contractfile: WBNn_Abi,
              funcationname: 'deposit',
              Contactaddress: sendingCoin.swapPath[1],
              privatekey: privateKey,
              value: true,
              amount: amountInController.text,
              url: AppContant.RpcBsctestnet)
          .then((value) {
        if (value["status"] == "Done") {
          ApproveTranstion();
        } else {
          print("erroe 1");
          setState(() {
            swaping = false;
          });
        }
      });
    } catch (e) {
      showCustomSnackBar(message: e.toString());
      setState(() {
        swaping = false;
      });
    }
  }

  ApproveTranstion() {
    final amt = getWei(amountInController.text, sendingCoin.coinDecimal);
    final EthereumAddress pancakeRouter =
        EthereumAddress.fromHex(sendingCoin.swapPath[0]);
    Logger.logprint(sendingCoin.coinAbi.toString());
    try {
      Address()
          .Send_InfoContract(
              Contractfile:
                  sendingCoin.coinAbi != null ? sendingCoin.coinAbi! : WBNn_Abi,
              privatekey: privateKey,
              funcationname: 'approve',
              Contactaddress: sendingCoin.swapPath[1],
              parameter: [pancakeRouter, amt],
              url: AppContant.RpcBsctestnet)
          .then((value) {
        if (value["status"] == "Done") {
          SwapCoin_withpancake();
        } else {
          setState(() {
            swaping = false;
          });
          print("erroe 1");
        }
      });
    } catch (e) {
      showCustomSnackBar(message: e.toString());
      setState(() {
        swaping = false;
      });
    }
  }

  SwapCoin_withpancake() async {
    final EthereumAddress pancakeRouter =
        EthereumAddress.fromHex(sendingCoin.swapPath[0]);

    final amt = ConvertToUnit256(num.parse(amountInController.text));
    //final amt = ConvertToUnit256(num.parse('0.001'));
    final amt2 = ConvertToUnit256(num.parse("0"));
    final deadLine = (DateTime.now()
        .toUtc()
        .add(Duration(minutes: 20))
        .millisecondsSinceEpoch);
    final time = ConvertToUnit256(num.parse("$deadLine"));

    final List<EthereumAddress> addressPath;
    if (sendingCoin.coinSymbol.toUpperCase() == "BNB") {
      addressPath = _pathListToAddresses(
          [sendingCoin.swapPath[1], recevingCoin.contractAddress!]);
    } else {
      addressPath = _pathListToAddresses([
        sendingCoin.swapPath[1], //USDT
        WBNB_Address //WBNB
      ]);
    }

    var credentials = EthPrivateKey.fromHex(privateKey);
    var walletaddress = await credentials.extractAddress();

    Address()
        .Send_InfoContract(
            Contractfile: PnacakeAbi,
            funcationname: 'swapExactTokensForTokens',
            Contactaddress: sendingCoin.swapPath[0],
            privatekey: privateKey,
            parameter: [amt, amt2, addressPath, walletaddress, time],
            url: AppContant.RpcBsctestnet)
        .then((value) {
      if (value["status"] == "Done") {
        if (sendingCoin.coinSymbol.toUpperCase() == "BNB") {
          setState(() {
            swaping = false;
          });
          Get.back();
          showCustomSnackBar(
            message: "Swapping Done. wait for Confimation",
          );
          return;
        }
        WBNB_toUSDt(value["message"].toString());
      } else {
        setState(() {
          swaping = false;
        });
        print("erroe 2");
      }
    });
  }

  BigInt ConvertToUnit256(num amount) {
    // var amt=BigInt.from(10).pow(18)*BigInt.from(double.parse(amount.toString()));
    var amt = BigInt.from(double.parse(amount.toString()) * pow(10, 18));
    return amt;
  }

  WBNB_toUSDt(String hash) async {
    String wallet =
        await SharedPreferenceClass.GetSharedData(AppContant.Walletaddres);
    var value = await Address().getRecipt(wallet, hash);
    if (value.toString().isEmpty) {
      WBNB_toUSDt(hash);
      return;
    }
    final amt = ConvertToUnit256(num.parse(value));
    Address()
        .Send_InfoContract(
            Contractfile: WBNn_Abi,
            funcationname: 'withdraw',
            Contactaddress: WBNB_Address,
            privatekey: privateKey,
            parameter: [amt],
            //value: true,
            //amount: amountInController.text,
            url: AppContant.RpcBsctestnet)
        .then((value) {
      if (value["status"] == "Done") {
        setState(() {
          swaping = false;
        });
        Get.back();
        showCustomSnackBar(
          message: "Swapping Done. wait for Confimation",
        );
      } else {
        setState(() {
          swaping = false;
        });
        print("erroe 3");
      }
    });
  }
}

class SwapCoinData {
  NetworkType coinNetwork;
  String coinName;
  String coinImage;
  String web3HttpUrl;
  String? contractAddress;
  String coinSymbol;
  int coinDecimal;
  Object? coinAbi;
  List<String> swapPath;
  double price;

  SwapCoinData({
    required this.coinNetwork,
    required this.web3HttpUrl,
    this.contractAddress,
    this.coinAbi,
    required this.swapPath,
    required this.coinName,
    required this.coinDecimal,
    required this.coinImage,
    required this.coinSymbol,
    required this.price,
  });
}

class swapcoindata {
  static List<SwapCoinData> swapCoins = [
    SwapCoinData(
      coinNetwork: NetworkType.BSC,
      web3HttpUrl: AppContant.Rpcurl,
      contractAddress: '0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56',
      coinName: 'BNB',
      coinImage: Appimages.binance,
      coinSymbol: 'BNB',
      price: 0.000,
      coinDecimal: 18,
      swapPath: [
        "0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", //Route
        "0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd" //WBNB
      ],
      // swapPath: [
      //   '0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56',
      //   '0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c',
      //   '0xf3eDD4f14a018df4b6f02Bf1b2cF17A8120519A2',
      // ],
      //       coinAbi: [
      //         {
      //           "inputs": [],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "constructor"
      //         },
      //         {
      //           "anonymous": false,
      //           "inputs": [
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "owner",
      //               "type": "address"
      //             },
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "spender",
      //               "type": "address"
      //             },
      //             {
      //               "indexed": false,
      //               "internalType": "uint256",
      //               "name": "value",
      //               "type": "uint256"
      //             }
      //           ],
      //           "name": "Approval",
      //           "type": "event"
      //         },
      //         {
      //           "anonymous": false,
      //           "inputs": [
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "previousOwner",
      //               "type": "address"
      //             },
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "newOwner",
      //               "type": "address"
      //             }
      //           ],
      //           "name": "OwnershipTransferred",
      //           "type": "event"
      //         },
      //         {
      //           "anonymous": false,
      //           "inputs": [
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "from",
      //               "type": "address"
      //             },
      //             {
      //               "indexed": true,
      //               "internalType": "address",
      //               "name": "to",
      //               "type": "address"
      //             },
      //             {
      //               "indexed": false,
      //               "internalType": "uint256",
      //               "name": "value",
      //               "type": "uint256"
      //             }
      //           ],
      //           "name": "Transfer",
      //           "type": "event"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "_decimals",
      //           "outputs": [
      //             {"internalType": "uint8", "name": "", "type": "uint8"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "_name",
      //           "outputs": [
      //             {"internalType": "string", "name": "", "type": "string"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "_symbol",
      //           "outputs": [
      //             {"internalType": "string", "name": "", "type": "string"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [
      //             {"internalType": "address", "name": "owner", "type": "address"},
      //             {"internalType": "address", "name": "spender", "type": "address"}
      //           ],
      //           "name": "allowance",
      //           "outputs": [
      //             {"internalType": "uint256", "name": "", "type": "uint256"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "address", "name": "spender", "type": "address"},
      //             {"internalType": "uint256", "name": "amount", "type": "uint256"}
      //           ],
      //           "name": "approve",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [
      //             {"internalType": "address", "name": "account", "type": "address"}
      //           ],
      //           "name": "balanceOf",
      //           "outputs": [
      //             {"internalType": "uint256", "name": "", "type": "uint256"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "uint256", "name": "amount", "type": "uint256"}
      //           ],
      //           "name": "burn",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "decimals",
      //           "outputs": [
      //             {"internalType": "uint8", "name": "", "type": "uint8"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "address", "name": "spender", "type": "address"},
      //             {
      //               "internalType": "uint256",
      //               "name": "subtractedValue",
      //               "type": "uint256"
      //             }
      //           ],
      //           "name": "decreaseAllowance",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "getOwner",
      //           "outputs": [
      //             {"internalType": "address", "name": "", "type": "address"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "address", "name": "spender", "type": "address"},
      //             {
      //               "internalType": "uint256",
      //               "name": "addedValue",
      //               "type": "uint256"
      //             }
      //           ],
      //           "name": "increaseAllowance",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "uint256", "name": "amount", "type": "uint256"}
      //           ],
      //           "name": "mint",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "name",
      //           "outputs": [
      //             {"internalType": "string", "name": "", "type": "string"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "owner",
      //           "outputs": [
      //             {"internalType": "address", "name": "", "type": "address"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [],
      //           "name": "renounceOwnership",
      //           "outputs": [],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "symbol",
      //           "outputs": [
      //             {"internalType": "string", "name": "", "type": "string"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": true,
      //           "inputs": [],
      //           "name": "totalSupply",
      //           "outputs": [
      //             {"internalType": "uint256", "name": "", "type": "uint256"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "view",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {
      //               "internalType": "address",
      //               "name": "recipient",
      //               "type": "address"
      //             },
      //             {"internalType": "uint256", "name": "amount", "type": "uint256"}
      //           ],
      //           "name": "transfer",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "address", "name": "sender", "type": "address"},
      //             {
      //               "internalType": "address",
      //               "name": "recipient",
      //               "type": "address"
      //             },
      //             {"internalType": "uint256", "name": "amount", "type": "uint256"}
      //           ],
      //           "name": "transferFrom",
      //           "outputs": [
      //             {"internalType": "bool", "name": "", "type": "bool"}
      //           ],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         },
      //         {
      //           "constant": false,
      //           "inputs": [
      //             {"internalType": "address", "name": "newOwner", "type": "address"}
      //           ],
      //           "name": "transferOwnership",
      //           "outputs": [],
      //           "payable": false,
      //           "stateMutability": "nonpayable",
      //           "type": "function"
      //         }
      //       ]),
    )
  ];

  static List<SwapCoinData> toSwapCoins = [
    SwapCoinData(
      coinNetwork: NetworkType.BSCTestnet,
      web3HttpUrl: AppContant.Rpcurl,
      coinDecimal: 18,
      coinName: 'Tether',
      coinImage: Appimages.USDT,
      coinSymbol: 'USDT ',
      price: 0.00,
      swapPath: [
        "0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3", //Route
        "0x337610d27c682E347C9cD60BD4b3b107C9d34dDd" //USDT
      ],
      //    graphData: emptyGraphData,
      contractAddress: '0x337610d27c682E347C9cD60BD4b3b107C9d34dDd',

      coinAbi: [
        {
          "inputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "constructor"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "internalType": "address",
              "name": "owner",
              "type": "address"
            },
            {
              "indexed": true,
              "internalType": "address",
              "name": "spender",
              "type": "address"
            },
            {
              "indexed": false,
              "internalType": "uint256",
              "name": "value",
              "type": "uint256"
            }
          ],
          "name": "Approval",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "internalType": "address",
              "name": "previousOwner",
              "type": "address"
            },
            {
              "indexed": true,
              "internalType": "address",
              "name": "newOwner",
              "type": "address"
            }
          ],
          "name": "OwnershipTransferred",
          "type": "event"
        },
        {
          "anonymous": false,
          "inputs": [
            {
              "indexed": true,
              "internalType": "address",
              "name": "from",
              "type": "address"
            },
            {
              "indexed": true,
              "internalType": "address",
              "name": "to",
              "type": "address"
            },
            {
              "indexed": false,
              "internalType": "uint256",
              "name": "value",
              "type": "uint256"
            }
          ],
          "name": "Transfer",
          "type": "event"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "_decimals",
          "outputs": [
            {"internalType": "uint8", "name": "", "type": "uint8"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "_name",
          "outputs": [
            {"internalType": "string", "name": "", "type": "string"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "_symbol",
          "outputs": [
            {"internalType": "string", "name": "", "type": "string"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {"internalType": "address", "name": "owner", "type": "address"},
            {"internalType": "address", "name": "spender", "type": "address"}
          ],
          "name": "allowance",
          "outputs": [
            {"internalType": "uint256", "name": "", "type": "uint256"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "spender", "type": "address"},
            {"internalType": "uint256", "name": "amount", "type": "uint256"}
          ],
          "name": "approve",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [
            {"internalType": "address", "name": "account", "type": "address"}
          ],
          "name": "balanceOf",
          "outputs": [
            {"internalType": "uint256", "name": "", "type": "uint256"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "decimals",
          "outputs": [
            {"internalType": "uint256", "name": "", "type": "uint256"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "spender", "type": "address"},
            {
              "internalType": "uint256",
              "name": "subtractedValue",
              "type": "uint256"
            }
          ],
          "name": "decreaseAllowance",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getOwner",
          "outputs": [
            {"internalType": "address", "name": "", "type": "address"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "spender", "type": "address"},
            {"internalType": "uint256", "name": "addedValue", "type": "uint256"}
          ],
          "name": "increaseAllowance",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "uint256", "name": "amount", "type": "uint256"}
          ],
          "name": "mint",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "name",
          "outputs": [
            {"internalType": "string", "name": "", "type": "string"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "owner",
          "outputs": [
            {"internalType": "address", "name": "", "type": "address"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [],
          "name": "renounceOwnership",
          "outputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "symbol",
          "outputs": [
            {"internalType": "string", "name": "", "type": "string"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "totalSupply",
          "outputs": [
            {"internalType": "uint256", "name": "", "type": "uint256"}
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "recipient", "type": "address"},
            {"internalType": "uint256", "name": "amount", "type": "uint256"}
          ],
          "name": "transfer",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "sender", "type": "address"},
            {"internalType": "address", "name": "recipient", "type": "address"},
            {"internalType": "uint256", "name": "amount", "type": "uint256"}
          ],
          "name": "transferFrom",
          "outputs": [
            {"internalType": "bool", "name": "", "type": "bool"}
          ],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {"internalType": "address", "name": "newOwner", "type": "address"}
          ],
          "name": "transferOwnership",
          "outputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        }
      ],
    ),
  ];
}
