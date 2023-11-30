import 'package:dappwallet/data/Controller/DashboardController.dart';
import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/ErrorMessage.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Wallet_History extends StatefulWidget {
  const Wallet_History({super.key});

  @override
  State<Wallet_History> createState() => _Wallet_HistoryState();
}

class _Wallet_HistoryState extends State<Wallet_History> {
  WebViewPlusController? _controller;

  bool isProgress = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            
            WebViewPlus(
              serverPort: 5353,
              javascriptChannels: null,
              initialUrl: Get.find<DashboardController>()
                          .chainlist[
                              Get.find<DashboardController>().selectindex]
                          .chain ==
                      walletchain.tron
                  ? "https://shasta.tronscan.org/#/address/${Get.find<DashboardController>().chainlist[Get.find<DashboardController>().selectindex].address}"
                  : "https://testnet.bscscan.com/address/${Get.find<DashboardController>().chainlist[Get.find<DashboardController>().selectindex].address}",
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (url) {
                _controller?.getHeight().then((double height) {
                  setState(() {
                    isProgress = false;
                  });
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (value) {
                if (value == 100) {
                  setState(() {
                    isProgress = false;
                  });
                }
              },
            ),
            isProgress
                ? Center(
                    child: pageloder(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
