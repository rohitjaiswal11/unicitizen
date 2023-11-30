import 'dart:convert';
import 'dart:math';

import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/utils/ErrorMessage.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:dappwallet/widget/CustomeListTile.dart';
import 'package:dappwallet/widget/error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:dappwallet/data/Controller/walletController.dart';

class TransitionHistory extends StatefulWidget {
  const TransitionHistory({super.key});

  @override
  State<TransitionHistory> createState() => _TransitionHistoryState();
}

class _TransitionHistoryState extends State<TransitionHistory> {
  CoinData? args;
  String walletaddress = "";
  bool load = true;
  List transactionsList = [];

  @override
  void initState() {
    args = Get.arguments as CoinData;
    walletaddress = Get.find<DashboardController>()
        .chainlist[Get.find<DashboardController>().selectindex]
        .address;
    print("data  ${args!.contractAddress}");
    setState(() {});
    getTransition();
    super.initState();
  }

  getTransition() async {
    String url;
    if (args!.coinNetwork == NetworkType.BSCTestnet ||
        args!.coinNetwork == NetworkType.BSC) {
      if (args!.coinAbi == null) {
        url =
            "https://${AppContant.bnbbase}/api?module=account&action=txlist&address=$walletaddress&page=1&offset=100&startblock=0&endblock=99999999999&sort=desc&apikey=${AppContant.bsc_API_KEY}";
      } else {
        url =
            "https://${AppContant.bnbbase}/api?module=account&action=tokentx&contractaddress=${args!.contractAddress}&address=$walletaddress&page=1&offset=100&startblock=0&endblock=99999999999&sort=desc&apikey=${AppContant.bsc_API_KEY}";
      }
    } else {
      url = args!.coinAbi != null
          ?
          // "https://nile.trongrid.io/v1/accounts/TLm6d54oZX2GRPaQfvy24ruwsmFTxUNjn4/transactions/trc20?contract_address=TXLAQ63Xg1NAzckPwKHvzw7CSEmLMEqcdj"
          "https://${AppContant.tronbalance}/v1/accounts/$walletaddress/transactions/trc20?contract_address=${args!.contractAddress}"
          : "https://shastapi.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=1000&start=0&address=$walletaddress&type=1";
    }
    Logger.logprint("url>>" + url);
    try {
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);
      Logger.logprint(data.toString());

      if (args!.coinNetwork == NetworkType.BSCTestnet ||
          args!.coinNetwork == NetworkType.BSC) {
        transactionsList = data["result"];
      } else {
        transactionsList = data["data"];
      }
      load = false;
    } catch (e) {
      load = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            CustomeAppbar(
                title: args!.coinName +
                    "${Get.find<DashboardController>().chainlist[Get.find<DashboardController>().selectindex].chain == walletchain.bsc ? "(BEP20)" : "(TRC20)"}",
                icon: Row(
                  children: [
                    CustomImageView(
                      imagePath: Appimages.dolleratg,
                      height: height(context) * 0.03,
                      width: height(context) * 0.03,
                      fit: BoxFit.contain,
                      onTap: () {
                        Get.toNamed(AppRoute.buy);
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CustomImageView(
                      imagePath: Appimages.Graph,
                      height: height(context) * 0.03,
                      width: height(context) * 0.03,
                      fit: BoxFit.contain,
                    ),
                  ],
                )),
            SizedBox(height: height(context) * 0.03),
            CustomeListTile(
              Title: args!.coinName,
              imagepath: args!.coinImage,
              subtitle:
                  "${AppContant.selectedCurrency.toUpperCase()} ${args!.price.toString()}",
              prfix: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Bal- ${Get.find<DashboardController>().Balancelist[AppContant.selectedCurrencyindes]}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Theme.of(context).hoverColor),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      args!.coinPercentage.toString() + "%",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: args!.coinPercentage.isNegative
                                  ? Colors.red
                                  : Colors.green),
                    ),
                  ]),
            ),
            SizedBox(height: height(context) * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: width(context) * 0.45,
                  prefixWidget: CustomImageView(
                    imagePath: Appimages.Sendbutton,
                    height: height(context) * 0.027,
                    width: height(context) * 0.027,
                    margin: EdgeInsets.only(right: width(context) * 0.02),
                  ),
                  height: height(context) * 0.05,
                  colors: Theme.of(context).primaryColor,
                  onTap: () {
                    Get.toNamed(AppRoute.send, arguments: args)!
                        .then((value) => getTransition());
                  },
                  text: Lanuage.send,
                  textcolor: Theme.of(context).hintColor,
                ),
                CustomButton(
                  width: width(context) * 0.45,
                  prefixWidget: CustomImageView(
                    imagePath: Appimages.receive,
                    height: height(context) * 0.027,
                    width: height(context) * 0.027,
                    color: Theme.of(context).canvasColor,
                    margin: EdgeInsets.only(right: width(context) * 0.02),
                  ),
                  height: height(context) * 0.05,
                  colors: Theme.of(context).cardColor,
                  onTap: () {
                    Get.toNamed(AppRoute.receiveCoin, arguments: args);
                  },
                  text: Lanuage.receive,
                  textcolor: Theme.of(context).canvasColor,
                ),
              ],
            ),
            load
                ? Center(
                    child: pageloder(),
                  )
                : transactionsList.length == 0
                    ? NOdata()
                    : ListView.builder(
                        itemCount: transactionsList.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int ind) {
                          return transactionsCard(ind);
                        }),
          ]),
        ),
      ),
    );
  }

  NOdata() {
    return Column(
      children: [
        SizedBox(height: height(context) * 0.07),
        ErrorScreen(title: "Transactions will appear here"),
        SizedBox(height: height(context) * 0.02),
        CustomButton(
          width: width(context) * 0.3,
          height: height(context) * 0.05,
          colors: Theme.of(context).primaryColor,
          onTap: () {
            Get.toNamed(AppRoute.buy);
          },
          text: Lanuage.buy,
          textcolor: Theme.of(context).hintColor,
        ),
      ],
    );
  }

  Widget transactionsCard(index) {
    var value;
    var date;
    var dateTime;
    bool istron = false;
    bool isabi = true;
    if (args!.coinNetwork == NetworkType.Tron ||
        args!.coinNetwork == NetworkType.TronTestnet) {
      if (args!.coinAbi != null) {
        value = double.parse(transactionsList[index]['value'] == null
                ? '0.0'
                : transactionsList[index]['value'].toString()) /
            AddressTron.getPrecision(6);
        date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(transactionsList[index]['value'].toString()));
        dateTime = DateFormat('M-d-yyyy h:mm a').format(date);
        isabi = true;
        print("Value $value  $walletaddress");
      } else {
        isabi = false;
        value = double.parse(
                transactionsList[index]['contractData']['amount'] == null
                    ? '0.0'
                    : transactionsList[index]['contractData']['amount']
                        .toString()) /
            AddressTron.getPrecision(6);
        date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(transactionsList[index]['timestamp'].toString()));
        dateTime = DateFormat('M-d-yyyy h:mm a').format(date);
      }
      istron = true;
    } else {
      istron = false;
      value = (double.parse(BigInt.from(
                          double.parse(transactionsList[index]['value']))
                      .toString()) /
                  pow(10, args!.coindecimal))
              .toString()
              .contains('e')
          ? (double.parse(BigInt.from(
                          double.parse(transactionsList[index]['value']))
                      .toString()) /
                  pow(10, args!.coindecimal))
              .toStringAsFixed(args!.coindecimal)
          : (double.parse(
                      BigInt.from(double.parse(transactionsList[index]['value']))
                          .toString()) /
                  pow(10, args!.coindecimal))
              .toString();

      date = DateTime.fromMillisecondsSinceEpoch(
          int.parse(transactionsList[index]['timeStamp']) * 1000);
      dateTime = DateFormat('M-d-yyyy h:mm a').format(date);
    }
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (args!.coinNetwork == NetworkType.BSC ||
            args!.coinNetwork == NetworkType.BSCTestnet) {
          Get.toNamed(AppRoute.webView_Screen,
              arguments:
                  "https://${AppContant.bnbScan}/tx/${transactionsList[index]['hash']}");
        } else if (args!.coinNetwork == NetworkType.Tron ||
            args!.coinNetwork == NetworkType.TronTestnet) {
          Get.toNamed(AppRoute.webView_Screen,
              arguments:
                  "https://shasta.tronscan.io/#/transaction/${transactionsList[index]['hash']}");
        }
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
                color: Theme.of(context).hoverColor.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(4)),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.016),
        margin: EdgeInsets.symmetric(vertical: height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${Lanuage.amount}: ',
                      style: TextStyle(
                          color: Colors.orange.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    args!.coinNetwork == NetworkType.Tron ||
                            args!.coinNetwork == NetworkType.TronTestnet
                        ? Text(
                            isabi
                                ? transactionsList[index]["from"].toString() ==
                                        walletaddress
                                    ? "-$value"
                                    : "$value"
                                : transactionsList[index]["contractData"]
                                            ['owner_address'] ==
                                        walletaddress
                                    ? "-$value"
                                    : "$value",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        : Text(
                            transactionsList[index]['from'] == walletaddress
                                ? "-${value.toString().length > 7 ? double.parse(value).toStringAsFixed(6) : value}"
                                : "${value.toString().length > 7 ? double.parse(value).toStringAsFixed(6) : value}",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                    SizedBox(
                      width: width * 0.015,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: istron
                            ? isabi
                                ? transactionsList[index]["from"].toString() ==
                                        walletaddress
                                    ? Colors.red
                                    : Colors.green
                                : transactionsList[index]["contractData"]
                                            ['owner_address'] ==
                                        walletaddress
                                    ? Colors.red
                                    : Colors.green
                            : transactionsList[index]['from'] == walletaddress
                                ? Colors.red
                                : Colors.green,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            istron
                                ? isabi
                                    ? transactionsList[index]["from"]
                                                .toString() ==
                                            walletaddress
                                        ? "out"
                                        : "IN"
                                    : transactionsList[index]["contractData"]
                                                ['owner_address'] ==
                                            walletaddress
                                        ? "out"
                                        : "IN"
                                : transactionsList[index]['from'] ==
                                        walletaddress
                                    ? "out"
                                    : "IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            )),
                      ),
                    ),
                  ],
                ),
                Text(
                  dateTime.toString(),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            _Textwidget(index),
            // SizedBox(
            //     width: width * 0.56,
            //     height: height * 0.03,
            //     child: Marquee(
            //       style: TextStyle(
            //           color: Theme.of(context).textTheme.bodyLarge!.color,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w500),
            //       text: (args!.coinNetwork == NetworkType.Tron ||
            //               args!.coinNetwork == NetworkType.TronTestnet)
            //           ? (args!.coinAbi != null
            //               ? (walletaddress.toString().toLowerCase() ==
            //                       transactionsList[index]['from_address']
            //                           .toString()
            //                           .toLowerCase()
            //                   ? 'To: ' +
            //                       transactionsList[index]['to_address']
            //                   : '${"from"}: ' +
            //                       transactionsList[index]['from_address'])
            //               : (walletaddress.toString().toLowerCase() ==
            //                       transactionsList[index]['contractData']
            //                               ['owner_address']
            //                           .toString()
            //                           .toLowerCase()
            //                   ? 'To: ' +
            //                       transactionsList[index]['contractData']
            //                           ['to_address']
            //                   : '${"From"}: ' +
            //                       transactionsList[index]['contractData']
            //                           ['owner_address']))
            //           : (walletaddress.toString().toLowerCase() ==
            //                   transactionsList[index]['from']
            //                       .toString()
            //                       .toLowerCase()
            //               ? 'To: ' + transactionsList[index]['to']
            //               : 'from: ' + transactionsList[index]['from']),
            //     )),
          ],
        ),
      ),
    );
  }

  _Textwidget(int ind) {
    if (args!.coinNetwork == NetworkType.Tron ||
        args!.coinNetwork == NetworkType.TronTestnet) {
      if (args!.coinAbi != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To: ' + transactionsList[ind]['to'],
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: height(context) * 0.005,
            ),
            Text('From: ' + transactionsList[ind]['from'],
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('To: ' + transactionsList[ind]["contractData"]['to_address'],
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: height(context) * 0.005,
            ),
            Text(
                'From: ' +
                    transactionsList[ind]["contractData"]['owner_address'],
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w500)),
          ],
        );
      }
    } else {
      return Column(
        children: [
          Text('To: ' + transactionsList[ind]['to'],
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: height(context) * 0.005,
          ),
          Text('From: ' + transactionsList[ind]['from'],
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ],
      );
    }
  }
}
