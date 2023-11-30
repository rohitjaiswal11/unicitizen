import 'package:dappwallet/utils/export.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebView_Screen extends StatefulWidget {
  const WebView_Screen({super.key});

  @override
  State<WebView_Screen> createState() => _WebView_ScreenState();
}

class _WebView_ScreenState extends State<WebView_Screen> {
  WebViewPlusController? _controller;
  bool isProgress = true;
  @override
  Widget build(BuildContext context) {
    print(Get.arguments.toString());
    return Scaffold(
      appBar: AppbarSecond(title: "", context: context, back: true),
      body: Container(
        child: Stack(
          children: [
            WebViewPlus(
              backgroundColor: Colors.white,
              serverPort: 5353,
              javascriptChannels: null,
              initialUrl: Get.arguments.toString(),
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
