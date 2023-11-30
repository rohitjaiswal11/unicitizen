import 'package:dappwallet/data/DappSetup/TronTest/NewTronApi.dart';
import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  TextEditingController address =
      TextEditingController(text: "TLm6d54oZX2GRPaQfvy24ruwsmFTxUNjn4");
  TextEditingController amount = TextEditingController();
  TextEditingController reciptaddress = TextEditingController();
  CoinData? _coindata;
  var _address = Address();
  var _dashboard = Get.find<DashboardController>();
  bool click = false;
  String transistionfee = "0.000";
  String pvtkey = "", coinbalance = "";
  NetworkType selectnetwork = NetworkType.BSCTestnet;

  bool isValidEthereumAddress(String address) {
    final pattern = r'^0x[a-fA-F0-9]{40}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(address);
  }

  bool isValidTronAddress(String address) {
    final pattern = r'^T[1-9A-HJ-NP-Za-km-z]{33}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(address);
  }

  @override
  void initState() {
    _coindata = Get.arguments as CoinData;
    if (_coindata!.coinNetwork == NetworkType.BSC ||
        _coindata!.coinNetwork == NetworkType.BSCTestnet) {
      selectnetwork = NetworkType.BSC;
      getFee();
    } else {
      selectnetwork = NetworkType.Tron;
    }
    setState(() {});
    super.initState();
  }

  getFee() async {
    _address.getGasFee(AppContant.RpcBsctestnet).then((value) {
      transistionfee = value;
      setState(() {});
    });
  }

  // getBalance() async {
  //   if (selectnetwork == NetworkType.BSC) {
  //     if (_coindata!.coinAbi != null) {
  //       coinbalance = await _address.getBalance_WithSmartContract(
  //           Contractfile: _coindata!.coinAbi!,
  //           funcationname: 'balanceOf',
  //           Contactaddress: _coindata!.contractAddress!,
  //           privatekey: pvtkey,
  //           url: AppContant.RpcBsctestnet);
  //     } else {}
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomeAppbar(
              title:
                  "Send ${_coindata!.coinSymbol} ${selectnetwork == NetworkType.BSC ? "(BEP20)" : "(TRC20)"}",
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            _field(
                title: Lanuage.receive + " " + Lanuage.address,
                widget: CustomImageView(
                  onTap: () {
                    Get.toNamed(AppRoute.qrScan)?.then((value) {
                      if (value != null && value.toString().isNotEmpty) {
                        address.text = value.toString();
                        setState(() {});
                      }
                    });
                  },
                  margin: EdgeInsets.all(9),
                  color: Theme.of(context).canvasColor,
                  imagePath: Appimages.Scan,
                ),
                widget2: InkWell(
                  onTap: () async {
                    var data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data!.text.toString().isNotEmpty) {
                      address.text = data.text.toString();
                    }
                    setState(() {});
                  },
                  child: Center(
                    child: Text(Lanuage.paste,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                  ),
                ),
                corl: address),
            SizedBox(
              height: height(context) * 0.03,
            ),
            _field(
                title: Lanuage.amount + " " + _coindata!.coinSymbol,
                widget: Center(
                  child: Text("MAX",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          )),
                ),
                widget2: null,
                // widget2: Center(
                //   child: Text("BUSD",
                //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //             fontWeight: FontWeight.w500,
                //           )),
                // ),
                corl: amount),
            SizedBox(
              height: height(context) * 0.04,
            ),
            Text(
              Lanuage.Optional,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            _field(
                title: Lanuage.receive + " " + Lanuage.address,
                widget: CustomImageView(
                  margin: EdgeInsets.all(9),
                  color: Theme.of(context).canvasColor,
                  imagePath: Appimages.Scan,
                ),
                widget2: Center(
                  child: Icon(Icons.info_outlined,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
                corl: reciptaddress),
            SizedBox(
              height: height(context) * 0.04,
            ),
            Text(
              Lanuage.EstimateFee +
                  ": " +
                  transistionfee.toString() +
                  " ${selectnetwork == NetworkType.BSC ? "BNB" : "TRX"}",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 13.5),
            ),
            SizedBox(
              height: height(context) * 0.06,
            ),
            click
                ? Align(
                    alignment: Alignment.center,
                    child: ButtonProcess(
                      height: 30,
                      width: 30,
                    ),
                  )
                : CustomButton(
                    width: width(context),
                    height: height(context) * 0.05,
                    colors: Theme.of(context).primaryColor,
                    onTap: () {
                      // sendcoin();
                      // return;
                      if (address.text.isEmpty || amount.text.isEmpty) {
                        showCustomSnackBar(
                            message:
                                "Please fill ${address.text.isEmpty ? "Address" : "Amount"} fields");
                        return;
                      }
                      if (selectnetwork == NetworkType.BSC) {
                        if (isValidEthereumAddress(address.text) == false) {
                          showCustomSnackBar(
                              message: "Invalid Receiver address",
                              isError: true);
                          return;
                        }
                        if (double.parse(transistionfee) >
                            double.parse(
                                _dashboard.Balancelist[0].toString())) {
                          showCustomSnackBar(
                              message: "Insufficent gas fee.", isError: true);
                          return;
                        }
                        print(_dashboard
                            .Balancelist[AppContant.selectedCurrencyindes]);
                        print(amount.text);
                        if (double.parse(amount.text) >
                            double.parse(_dashboard
                                .Balancelist[AppContant.selectedCurrencyindes]
                                .toString())) {
                          showCustomSnackBar(
                              message: "Insufficent Balance.", isError: true);
                          return;
                        }
                        click = true;
                        setState(() {});
                        sendcoin();
                      } else {
                        if (isValidTronAddress(address.text) == false) {
                          showCustomSnackBar(
                              message: "Invalid Receiver address",
                              isError: true);
                          return;
                        }
                        if (double.parse(amount.text) >
                            double.parse(_dashboard
                                .Balancelist[AppContant.selectedCurrencyindes]
                                .toString())) {
                          showCustomSnackBar(
                              message: "Insufficent Balance.", isError: true);
                          return;
                        }
                        click = true;
                        setState(() {});
                        sendcoin();
                      }
                    },
                    text: Lanuage.send,
                    textcolor: Theme.of(context).hintColor,
                  ),
          ]),
        ),
      ),
    );
  }

  _field(
      {required String title,
      required Widget widget,
      required Widget? widget2,
      required TextEditingController corl}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
            child: CustomeTextformfiled(
          controller: corl,
          heading: "$title",
        )),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: height(context) * 0.065,
            width: width(context) * 0.15,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Theme.of(context).cardColor),
            ),
            child: widget,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        if (widget2 != null)
          GestureDetector(
            onTap: () {},
            child: Container(
              height: height(context) * 0.065,
              width: width(context) * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).cardColor),
              ),
              child: widget2,
            ),
          ),
      ],
    );
  }

  Future<void> sendcoin() async {
    String pvtkey =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletprivateKey);
    String seedphared =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletSeed);

    if (_coindata!.coinNetwork == NetworkType.BSC ||
        _coindata!.coinNetwork == NetworkType.BSCTestnet) {
      if (_coindata!.coinAbi == null) {
        _address.Send_NavtiveCoin(
                privatekey: pvtkey,
                receiveraddress: address.text.toString(),
                amount: amount.text,
                url: AppContant.RpcBsctestnet)
            .then((value) {
          if (value["status"] == "Done") {
            click = false;
            Get.back();
            showCustomSnackBar(message: "Transitions Added");
          } else {
            click = false;
          }
          setState(() {});
        });
      } else {
        _address.SendCoin_WithContrcact(
                Contractfile: _coindata!.coinAbi!,
                funcationname: 'transfer',
                Contactaddress: _coindata!.contractAddress.toString(),
                privatekey: pvtkey,
                receiveraddress: address.text,
                amount: amount.text,
                url: AppContant.RpcBsctestnet)
            .then((value) {
          if (value["status"] == "Done") {
            click = false;
            Get.back();
            showCustomSnackBar(message: "Transitions Added");
          } else {
            click = false;
          }
          setState(() {});
        });
      }
    } else {
      String seedphared =
          await SharedPreferenceClass.GetSharedData(AppContant.WalletSeed) ??
              "";
      String pvtkey = await AddressTron().genartepvtkey(seedphared.split(" "));
      String walladdress = await SharedPreferenceClass.GetSharedData(
          AppContant.WalletaddresTron);

      if (_coindata!.coinAbi != null) {
        AddressTron()
            .trc20Transfer(
                address: walladdress,
                toAddress: address.text,
                sendAmount: amount.text,
                coinData: _coindata!,
                seed: seedphared)
            .then((value) {
          if (value) {
            click = false;
            Get.back();
            showCustomSnackBar(message: "Transitions Added");
          } else {
            click = false;
          }
          setState(() {});
        });
      } else {
        String seedphared =
            await SharedPreferenceClass.GetSharedData(AppContant.WalletSeed) ??
                "";
        String pvtkey =
            await AddressTron().genartepvtkey(seedphared.split(" "));
        String walladdress = await SharedPreferenceClass.GetSharedData(
            AppContant.WalletaddresTron);
        AddressTron()
            .sendtron(
                address: walladdress,
                toAddress: address.text,
                sendAmount: amount.text,
                coinData: _coindata!,
                seed: seedphared)
            .then((value) {
          if (value) {
            click = false;
            Get.back();
            showCustomSnackBar(message: "Transitions Added");
          } else {
            click = false;
          }
          setState(() {});
        });
        // AddressTron().sendTRX(
        //     walladdress, address.text, double.parse(amount.text), pvtkey);

        // NEWApi().sendTRX(
        //     walladdress, address.text, double.parse(amount.text), pvtkey);
      }
      Logger.logprint(pvtkey);
    }
  }
}
