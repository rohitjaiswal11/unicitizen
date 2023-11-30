import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/data/DappSetup/Address.dart';
import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/data/DatabaseHelper/Wallet.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/appbar.dart';
import 'package:dappwallet/widget/textformfiled.dart';
import 'package:flutter/services.dart';

import '../../utils/export.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  State<ImportWallet> createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  int selcte = 1;
  TextEditingController name = TextEditingController();
  TextEditingController key = TextEditingController();
  bool _load = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    int walletsCount = await MultiWalletDatabase.db.countWallets();
    List list = await MultiWalletDatabase.db.getAllWallets();
    print(list.toString());
    for (int i = 0; i < list.length; i++) {
      if (list[i]["walletName"] == "Wallet${walletsCount + 1}") {
        name.text = "Wallet${walletsCount + 1 + i}";
        break;
      } else {
        name.text = "Wallet${walletsCount + 1}";
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            CustomeAppbar(
                title: "Import Wallet",
                icon: Image.asset(
                  Appimages.Scan,
                  color: Theme.of(context).canvasColor,
                  width: 25,
                  height: 25,
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: width(context),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).cardColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      key.text = "";
                      setState(() {
                        selcte = 1;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: width(context) * 0.47,
                      decoration: BoxDecoration(
                          color: selcte == 1
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Center(
                          child: Text("Phrase",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: selcte == 1
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // key.text =
                      //     "08070cc574ec0b0f599eec2ad2cc53c81a52393d5f36869dcb37ff6aee4e4c02";
                      key.text = "";
                      setState(() {
                        selcte = 2;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: width(context) * 0.47,
                      decoration: BoxDecoration(
                          color: selcte == 2
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Center(
                          child: Text("Private Key",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: selcte == 2
                                          ? Theme.of(context).hintColor
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color))),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomeTextformfiled(heading: "Name", controller: name),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomeTextformfiled(
                  controller: key,
                  heading: selcte == 1 ? "Phrase" : "Private Key",
                )),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () async {
                    var data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data!.text.toString().isNotEmpty) {
                      key.text = data.text.toString();
                    }
                    setState(() {});
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
                ),
              ],
            ),
            SizedBox(
              height: height(context) * 0.04,
            ),
            Container(
              width: width(context),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Theme.of(context).cardColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  selcte == 2
                      ? "Typically 64 alphanumeric characters."
                      : "Typically 12(sometimes 24) words separate by single spaces.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.04,
            ),
            _load
                ? ButtonProcess(
                    height: 30,
                    width: 30,
                  )
                : CustomButton(
                    width: width(context),
                    height: height(context) * 0.05,
                    colors: Theme.of(context).primaryColor,
                    onTap: () async {
                      //  importWithKey();
                      if (name.text.isEmpty || key.text.isEmpty) {
                        showCustomSnackBar(message: "please fill all fields");
                        return;
                      }
                      setState(() {
                        _load = true;
                      });
                      if (selcte == 2) {
                        importWithKey();
                        return;
                      }
                      if (selcte == 1) {
                        bool ischeck =
                            await Address().isvalidateMnemonic(key.text);
                        print("key " +
                            key.text.trim() +
                            "  " +
                            ischeck.toString());
                        if (ischeck == true) {
                          importwithSeed();
                        } else {
                          showCustomSnackBar(
                              message: "Invalid Phrase..", isError: true);
                          setState(() {
                            _load = false;
                          });
                        }
                      }
                    },
                    text: "Import",
                    textcolor: Theme.of(context).hintColor,
                  ),
          ]),
        ),
      ),
    );
  }

//way angle immense amused trouble coast reduce choose crater able sausage space
  importWithKey() async {
    String phs = key.text;
    Get.find<walletController>()
        .importWallet_WithPvtkey(phs, name.text)
        .then((value) async {
      if (value) {
        showCustomSnackBar(message: "Wallet create Successfully.");
        // Get.offAllNamed(AppRoute.bottomNavigationBar);
      } else {
        showCustomSnackBar(message: "Error in Key", isError: false);
      }
      setState(() {
        _load = false;
      });
    });
  }

  importwithSeed() {
    String phs = key.text;
    Get.find<walletController>()
        .genrateaddress(phs, name.text)
        .then((value) async {
      if (value) {
        showCustomSnackBar(message: "Wallet create Successfully.");
        Get.offAllNamed(AppRoute.bottomNavigationBar);
      } else {
        showCustomSnackBar(message: "Error in address", isError: false);
      }
      setState(() {
        _load = false;
      });
    });
  }
}
