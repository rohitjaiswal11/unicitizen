import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/screen/Lock/LockScreen.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/services.dart';

import '../../data/DatabaseHelper/Wallet.dart';

class showSecrete extends StatefulWidget {
  const showSecrete({super.key});

  @override
  State<showSecrete> createState() => _showSecreteState();
}

class _showSecreteState extends State<showSecrete> {
  MultiWalletDatabaseModel? _coindata;
  @override
  void initState() {
    _coindata = Get.arguments;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(
        title: _coindata!.walletName.toString(),
        context: context,
        back: true,
        icon: InkWell(
          onTap: () async {
            var id =
                await SharedPreferenceClass.GetSharedData(AppContant.walletid);
            if (_coindata!.id.toString() == id.toString()) {
              showCustomSnackBar(
                  message: "Please firstly.Change the cureent wallet select.");
              return;
            }
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete"),
                    content:
                        Text("Are you sure.you want to delete you wallet."),
                    backgroundColor: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    clipBehavior: Clip.antiAlias,
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            await MultiWalletDatabase.db.delete(_coindata!.id);
                            Get.back(result: true);
                          },
                          child: Text("Delete"),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Theme.of(context).primaryColor)),
                      ElevatedButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          child: Text("Cancel"),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Theme.of(context).shadowColor))
                    ],
                  );
                }).then((value) {
              if (value) {
                Get.back(result: true);
                showCustomSnackBar(
                    message: "You wallet deleted Sucessfully", isError: false);
              }
            });
            //  Get.toNamed(AppRoute.intoduction);
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: height(context) * 0.04,
            width: height(context) * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.bluecolors,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: height(context) * 0.02,
            ),
            Container(
              height: height(context) * 0.13,
              width: width(context),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_coindata!.walletName.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                      Text("MutiChain Wolf Wallet",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_coindata!.walletAddress.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: _coindata!.privateKey));

                          showCustomSnackBar(
                              message: "Address copy successfully",
                              isError: false);
                        },
                        child: Icon(
                          Icons.copy_all,
                          // size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  if (_coindata!.tronWalletaddress.toString().isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_coindata!.tronWalletaddress.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400)),
                        InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text: _coindata!.tronWalletaddress));

                            showCustomSnackBar(
                                message: "Tron Address copy successfully",
                                isError: false);
                          },
                          child: Icon(
                            Icons.copy_all,
                            // size: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.04,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor:
                      Theme.of(context).dividerColor.withOpacity(0.5),
                  child: Icon(
                    Icons.shield_moon,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: width(context) * 0.04,
                ),
                Text(
                  Lanuage.Showprivate,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    String seedphared =
                        await SharedPreferenceClass.GetSharedData(
                                AppContant.WalletSeed) ??
                            "";
                    String pvtkey = await AddressTron()
                        .genartepvtkey(seedphared.split(" "));
                    Logger.logprint("PVT TRon  " + pvtkey.toString());
                    Get.toNamed(AppRoute.localauthVerifyScreen,
                            arguments:
                                VerifyModel(isForward: false, routeName: ""))!
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: height(context) * 0.3,
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Private Key",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      SizedBox(
                                        height: height(context) * 0.015,
                                      ),
                                      Container(
                                        width: width(context),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .hoverColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 10, 8, 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    _coindata!.privateKey,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: _coindata!
                                                              .privateKey));
                                                  Get.back();
                                                  showCustomSnackBar(
                                                      message:
                                                          "Private Key copy successfully",
                                                      isError: false);
                                                },
                                                child: Icon(
                                                  Icons.file_copy,
                                                  // size: 20,
                                                  color: Theme.of(context)
                                                      .hoverColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(context) * 0.015,
                                      ),
                                      Container(
                                        width: width(context),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color:
                                                  Theme.of(context).cardColor),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Reminder!!",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: height(context) * 0.01,
                                              ),
                                              Text(
                                                "Do not share your Private key",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: height(context) * 0.01,
                                              ),
                                              Text(
                                                "Your Private Key provides full access to your wallet and funds.Do not share this with anyone.",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .hoverColor,
                                                        //fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            if (_coindata!.phraseSeed.toString().isNotEmpty)
              Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundColor:
                        Theme.of(context).dividerColor.withOpacity(0.5),
                    child: Icon(
                      Icons.wallet_rounded,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: width(context) * 0.04,
                  ),
                  Text(
                    Lanuage.ShowSeed,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.localauthVerifyScreen,
                              arguments:
                                  VerifyModel(isForward: false, routeName: ""))!
                          .then((value) {
                        Get.toNamed(AppRoute.showseed_phrase,
                            arguments: _coindata!.phraseSeed);
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
