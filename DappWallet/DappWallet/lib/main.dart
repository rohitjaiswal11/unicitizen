import 'dart:io';

import 'package:dappwallet/data/Controller/theme.dart';
import 'package:dappwallet/data/base/lanuagetranslater.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:dappwallet/utils/loger.dart';
import 'package:dappwallet/walletConnect/models/browser_model.dart';
import 'package:dappwallet/walletConnect/models/webview_model.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

import 'utils/getbindind.dart';

Future<void> main() async {
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  TrustWalletCoreLib.init();
  await GetStorage.init();
  initalize();
  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(false);

  //   var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
  //       AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
  //   var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
  //       AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

  //   if (swAvailable && swInterceptAvailable) {
  //     AndroidServiceWorkerController serviceWorkerController =
  //         AndroidServiceWorkerController.instance();

  //     await serviceWorkerController
  //         .setServiceWorkerClient(AndroidServiceWorkerClient(
  //       shouldInterceptRequest: (request) async {
  //         return null;
  //       },
  //     ));
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebViewModel(),
        ),
        ChangeNotifierProxyProvider<WebViewModel, BrowserModel>(
          update: (context, webViewModel, browserModel) {
            browserModel!.setCurrentWebViewModel(webViewModel);
            return browserModel;
          },
          create: (BuildContext context) => BrowserModel(),
        ),
      ],
      child: GetBuilder<themedata>(builder: (child) {
        child.getshared();
        return GetMaterialApp(
          title: 'Wolf Wallet',
          debugShowCheckedModeBanner: false,
          themeMode: child.gettheme,
          theme: AppThemedata.light,
          // locale: Get.deviceLocale,
          darkTheme: AppThemedata.dark,
          // fallbackLocale: Locale('en', 'US'),
          // fallbackLocale: Locale('pu', 'pu'),
          translations: TranslationService(),
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          defaultTransition: Transition.topLevel,
          getPages: AppRoute.pages,
          initialRoute: AppRoute.splash,
        );
      }),
    );
  }
}
