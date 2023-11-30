import 'dart:convert';

import 'package:dappwallet/data/DappSetup/Address.dart';
import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/data/Repo/allRepo.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/services.dart';

import '../../data/Controller/DashboardController.dart';
import '../../data/DatabaseHelper/coindata.dart';

class AddCoin extends StatefulWidget {
  const AddCoin({super.key});

  @override
  State<AddCoin> createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  String coinID = "";
  var abifile = "";
  var instance = Get.find<DashboardController>();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController symbolController = TextEditingController();
  TextEditingController decimalsController = TextEditingController();

  List<NetworkCoin> chainlist = [
    NetworkCoin(
        networkName: NetworkType.BSCTestnet, imagePath: Appimages.binance),
    NetworkCoin(
        networkName: NetworkType.TronTestnet, imagePath: Appimages.tron),
  ];
  NetworkCoin? slect;
  bool load = false;

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
  initState() {
    if (instance.chainlist.length < chainlist.length) {
      chainlist.removeLast();
    }
    setState(() {
      slect = chainlist[instance.selectindex];
    });
    //getdata();
    super.initState();
  }

  getdata() async {
    var walletid =
        await SharedPreferenceClass.GetSharedData(AppContant.walletid);
    await SharedPreferenceClass.RemoveSharedData(
        walletid.toString() + slect!.networkName.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppbarSecond(title: Lanuage.Addtoken, context: context, back: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: height(context) * 0.03,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: height(context) * 0.06,
                  // width: width * 0.34,
                  padding: EdgeInsets.symmetric(
                      horizontal: width(context) * 0.01,
                      vertical: height(context) * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).hoverColor.withOpacity(0.7),
                  ),
                  child: DropdownButton<NetworkCoin>(
                    underline: SizedBox(),
                    isExpanded: false,
                    dropdownColor: Colors.grey,
                    value: slect,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        addressController.clear();
                        nameController.clear();
                        symbolController.clear();
                        decimalsController.clear();
                        setState(() {
                          slect = value;
                        });
                        // if (slect!.networkName.name == "TronTestnet") {
                        //   addressController.text =
                        //       "TG3XXyExBkPp9nzdajDZsozEu4BkaSJozs";
                        //   setState(() {});
                        // }
                      }
                    },
                    items: chainlist.map((NetworkCoin item) {
                      return DropdownMenuItem<NetworkCoin>(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                              ),
                              child: Image.asset(
                                item.imagePath,
                                height: height(context) * 0.03,
                                width: height(context) * 0.03,
                                //fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: width(context) * 0.02),
                            SizedBox(
                              width: width(context) * 0.4,
                              child: Text(
                                item.networkName.name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        value: item,
                      );
                    }).toList(),
                  )),
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomeTextformfiled(
                    heading: "Token Address",
                    controller: addressController,
                    textInputAction: TextInputAction.next,
                    onchnage: (value) {
                      if (isValidTronAddress(value)) {
                        // getTokenDetails(value);
                        getabifile(addressController.text);
                      }
                      if (isValidEthereumAddress(value)) {
                        // getTokenDetails(value);
                        getabifile(addressController.text);
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the address";
                      } else if (slect!.networkName == NetworkType.BSCTestnet) {
                        if (isValidEthereumAddress(value)) {
                          return null;
                        } else {
                          showCustomSnackBar(message: "invalid address");
                          return " ";
                        }
                      } else if (slect!.networkName ==
                          NetworkType.TronTestnet) {
                        if (isValidTronAddress(value)) {
                          return null;
                        } else {
                          showCustomSnackBar(message: "invalid address");
                          return " ";
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.04,
                ),
                InkWell(
                  onTap: () async {
                    var data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data!.text.toString().isNotEmpty) {
                      addressController.text = data.text.toString();
                    }
                    setState(() {});
                    if (isValidTronAddress(addressController.text)) {
                      //getTokenDetails(addressController.text);
                      getabifile(addressController.text);
                    }
                    if (isValidEthereumAddress(addressController.text)) {
                      //getTokenDetails(addressController.text);
                      getabifile(addressController.text);
                    }
                  },
                  child: Container(
                    height: 45,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).cardColor),
                    ),
                    child: Center(
                      child: Text("Paste",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  )),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            CustomeTextformfiled(
                heading: Lanuage.name, controller: nameController),
            SizedBox(
              height: height(context) * 0.02,
            ),
            CustomeTextformfiled(
                heading: Lanuage.symbol, controller: symbolController),
            SizedBox(
              height: height(context) * 0.02,
            ),
            CustomeTextformfiled(
                heading: "${Lanuage.Decimal} value",
                controller: decimalsController,
                textInputType: TextInputType.number),
            SizedBox(
              height: height(context) * 0.07,
            ),
            load
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
                    margin: EdgeInsets.only(left: 15, right: 15),
                    text: Lanuage.Addtoken,
                    onTap: () {
                      if (abifile.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          symbolController.text.isNotEmpty) {
                        ImportToken();
                      } else {
                        showCustomSnackBar(message: "Invalid Details");
                      }
                    },
                    textcolor: Theme.of(context).hintColor,
                  )
          ]),
        ),
      ),
    );
  }

  getTokenDetails(String address) async {
    setState(() {
      load = true;
    });
    AllRepo()
        .getCoinDetails(address,
            slect!.networkName == NetworkType.BSCTestnet ? 'bsc' : 'tron')
        .then((value) {
      print(value);
      if (value!["status"] == "200") {
        final coinInfo = value['data']["attributes"];
        var name = coinInfo['name'] ?? '';
        var symbol = coinInfo['symbol'] ?? '';
        var decimals = coinInfo['decimals'] ?? '';
        coinID = coinInfo['coingecko_coin_id'];

        nameController.text = name.toString();
        symbolController.text = symbol.toString();
        decimalsController.text = decimals.toString();
      } else {
        showCustomSnackBar(message: value["data"].toString(), isError: true);
      }
      load = false;
      setState(() {});
      // getabifile(address);
    });
  }

  getabifile(String address) {
    AllRepo()
        .getCoinabi(
            address,
            slect!.networkName == NetworkType.BSCTestnet ||
                    slect!.networkName == NetworkType.BSC
                ? 'bsc'
                : 'tron')
        .then((value) async {
      Logger.logprint(value!["data"].toString());
      if (value!["status"] == "200") {
        abifile = value["data"];
        Logger.logprint(abifile.toString());
        if (slect!.networkName == NetworkType.BSCTestnet ||
            slect!.networkName == NetworkType.BSC) {
          symbolController.text = await Address().getInfo_Contract(
              Contractfile: jsonDecode(abifile),
              funcationname: 'symbol',
              Contactaddress: addressController.text,
              url: slect!.networkName == NetworkType.BSCTestnet
                  ? AppContant.RpcBsctestnet
                  : AppContant.RptrontestNet);

          nameController.text = await Address().getInfo_Contract(
              Contractfile: jsonDecode(abifile),
              funcationname: 'name',
              Contactaddress: addressController.text,
              url: slect!.networkName == NetworkType.BSCTestnet
                  ? AppContant.RpcBsctestnet
                  : AppContant.RptrontestNet);

          decimalsController.text = await Address().getInfo_Contract(
              Contractfile: jsonDecode(abifile),
              funcationname: 'decimals',
              Contactaddress: addressController.text,
              url: slect!.networkName == NetworkType.BSCTestnet
                  ? AppContant.RpcBsctestnet
                  : AppContant.RptrontestNet);
        } else {
          String ad = await SharedPreferenceClass.GetSharedData(
              AppContant.WalletaddresTron);
          print("TRON");
          await AddressTron().getcontract_trigger(
            address: ad,
            contractaddress: address,
            coinData: slect!.networkName.name,
            coinabi: abifile,
          );
          //  await getTokenDetails(address);
        }
        if (slect!.networkName == NetworkType.BSC ||
            slect!.networkName == NetworkType.Tron) {
          await getTokenDetails(address);
        }
      } else {
        showCustomSnackBar(message: value["data"].toString(), isError: true);
      }
      setState(() {});
    });
  }

  ImportToken() async {
    setState(() {
      load = true;
    });
    // await getabifile(addressController.text);
    var walletid =
        await SharedPreferenceClass.GetSharedData(AppContant.walletid);
    final wallcoinlist = await SharedPreferenceClass.GetSharedData(
            walletid.toString() + slect!.networkName.name) ??
        [];
    Logger.logprint("LENGTH" +
        "  " +
        walletid.toString() +
        "  " +
        slect!.networkName.toString());
    List<String> walletlist = [];
    for (var i = 0; i < wallcoinlist.length; i++) {
      walletlist.add(wallcoinlist[i].toString());
    }
    if (coinID.isNotEmpty) {
      final coinData = await AllRepo().getCoinInfo(coinID);
      if (coinData["status"] == "400") {
        walletlist.add(
            '{"coinNetwork": "${slect!.networkName}","coinID": "$coinID","contractAddress": "${addressController.text}","isCustom":"true","coinName": "${nameController.text}","coinSymbol": "${symbolController.text}","coinDecimal": "${decimalsController.text}","coinImage": "${Appimages.emptytoken}","coinAbi":$abifile}');
      } else {
        walletlist.add(
            '{"coinNetwork": "${slect!.networkName}","coinID": "$coinID","contractAddress": "${addressController.text}","isCustom":"true","coinName": "${nameController.text}","coinSymbol": "${symbolController.text}","coinDecimal": "${decimalsController.text}","coinImage": "${coinData['image']['large'].toString()}","coinAbi":$abifile }');
      }
    } else {
      walletlist.add(
          '{"coinNetwork": "${slect!.networkName}","coinID": "$coinID","contractAddress": "${addressController.text}","isCustom":"true","coinName": "${nameController.text}","coinSymbol": "${symbolController.text}","coinDecimal": "${decimalsController.text}","coinImage": "${Appimages.emptytoken}","coinAbi":$abifile}');
    }
    await SharedPreferenceClass.RemoveSharedData(
        walletid.toString() + slect!.networkName.name);
    Logger.logprint("LENGTH" + walletlist.length.toString());
    await SharedPreferenceClass.SetSharedData(
        walletid.toString() + slect!.networkName.name, walletlist);
    setState(() {
      load = false;
    });
    Get.offAllNamed(AppRoute.bottomNavigationBar);
    showCustomSnackBar(message: "Token added Sucessfully");
  }
}

class NetworkCoin {
  final NetworkType networkName;
  final String imagePath;
  NetworkCoin({
    required this.networkName,
    required this.imagePath,
  });
}
