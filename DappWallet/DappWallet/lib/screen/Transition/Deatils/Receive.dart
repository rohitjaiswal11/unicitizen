import 'dart:io';

import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:dappwallet/widget/GrayContainer.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../Dashboard/dashboard.dart';

class ReceiveCoin extends StatefulWidget {
  const ReceiveCoin({super.key});

  @override
  State<ReceiveCoin> createState() => _ReceiveCoinState();
}

class _ReceiveCoinState extends State<ReceiveCoin> {
  CoinData? args;
  var _instance = Get.find<DashboardController>();
  ScreenshotController _controller = ScreenshotController();

  @override
  void initState() {
    args = Get.arguments as CoinData;
    print(
        "data  ${args!} https://chart.googleapis.com/chart?cht=${_instance.chainlist[_instance.selectindex].address.toString()}qr&chl=&chs=512x512&chld=L|0");
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(
          title: args!.coinName +
              "${_instance.chainlist[_instance.selectindex].chain == walletchain.bsc ? "(BEP20)" : "(TRC20)"}",
          context: context,
          back: true),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: height(context) * 0.02,
            ),
            GrayContainer(
                radius: 15,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Text(
                      _instance.chainlist[_instance.selectindex].address
                          .toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    Screenshot(
                      controller: _controller,
                      child: CustomImageView(
                        height: height(context) * 0.3,
                        width: width(context),
                        url:
                            "https://chart.googleapis.com/chart?cht=qr&chl=${_instance.chainlist[_instance.selectindex].address.toString()}&chs=512x512&chld=L|1",
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                  ],
                )),
            SizedBox(
              height: height(context) * 0.015,
            ),
            Text(
              "Send only ${_instance.chainlist[_instance.selectindex].chain == walletchain.bsc ? "(BEP20)" : "(TRC20)"} coins to this address.\nSending any other coin may result parameter loss.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13.5, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: height(context) * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _button(Lanuage.copy, Icons.copy, () async {
                  await Clipboard.setData(ClipboardData(
                      text: _instance.chainlist[_instance.selectindex].address
                          .toString()
                          .toString()));
                  showCustomSnackBar(
                      message: "Wallet address copy successfully",
                      isError: false);
                }),
                // _button(Lanuage.set + " " + Lanuage.amount, Icons.copy, () {}),
                _button(Lanuage.share, Icons.share, () {
                  _controller
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((value) async {
                    if (value != null) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final imagePath =
                          await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(value);

                      await Share.shareXFiles([XFile(imagePath.path)],
                          text:
                              "My Public Address is to Receive ${_instance.chainlist[_instance.selectindex].address}");
                    }
                  });
                }),
              ],
            )
          ],
        ),
      )),
    );
  }

  _button(
    String name,
    IconData icon,
    Function()? tap,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: tap,
          child: Container(
            height: width(context) * 0.15,
            width: width(context) * 0.15,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            child: Center(
                child: Icon(
              icon,
              color: Colors.white,
            )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$name",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
