import 'package:dappwallet/utils/export.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  WebViewPlusController? _controller;

  bool isProgress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(title: Lanuage.buy, context: context, back: true),
      body: Container(
        child: Stack(
          children: [
            WebViewPlus(
              backgroundColor: Colors.white,
              serverPort: 5353,
              javascriptChannels: null,
              initialUrl: 'https://rampay.io/exchange/',
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
                print(value);
                if (value == 100) {
                  setState(() {
                    isProgress = false;
                  });
                }
              },
            ),
            isProgress
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
