import 'package:dappwallet/screen/Addcoin/addToken.dart';
import 'package:dappwallet/screen/ImportWallet/ImportWallet.dart';
import 'package:dappwallet/screen/Introduction/Splash.dart';
import 'package:dappwallet/screen/Introduction/introducation.dart';
import 'package:dappwallet/screen/Lock/Confirmpassword.dart';
import 'package:dappwallet/screen/Lock/Cretepassowrd.dart';
import 'package:dappwallet/screen/Setting/Country.dart';
import 'package:dappwallet/screen/Setting/Lanuage.dart';
import 'package:dappwallet/screen/Transition/Buy.dart';
import 'package:dappwallet/screen/Transition/Deatils/WebView.dart';
import 'package:dappwallet/screen/Transition/SelectCoin.dart';
import 'package:dappwallet/screen/Transition/Send.dart';
import 'package:dappwallet/screen/Transition/Swap.dart';
import 'package:dappwallet/screen/createwallet/createwallet.dart';
import 'package:dappwallet/screen/createwallet/secrtphase.dart';
import 'package:dappwallet/screen/history/history.dart';
import 'package:dappwallet/screen/walletList/ShowseedPhares.dart';
import 'package:dappwallet/screen/walletList/wallerlist.dart';

import '../screen/BottomBar/bottombar.dart';
import '../screen/Lock/LockScreen.dart';
import '../screen/Setting/Currency.dart';
import '../screen/Setting/Security.dart';
import '../screen/Transition/Deatils/Receive.dart';
import '../screen/Transition/Deatils/TransitonHistory.dart';
import '../screen/Transition/QRScan.dart';
import '../screen/createwallet/secretphraseMatching.dart';
import '../screen/walletList/privatekeyShow.dart';
import '../utils/export.dart';

class AppRoute {
  static const String splashScreen = '/Splash';
  static const String intoduction = '/intoduction';
  static const String importWallet = '/ImportWallet';
  static const String createWallet = '/CreateWallet';
  static const String SecretePhase = '/secretePhase';
  static const String secretPhase_Match = '/SecretPhaseMatch';
  static const String bottomNavigationBar = '/BottomNavigationBar';
  static const String send = '/Send';
  static const String buy = '/buy';
  static const String selectCoin = '/SelectCoin';
  static const String transitionHistory = '/TransitionHistory';
  static const String receiveCoin = '/ReceiveCoin';
  static const String security = '/Security';
  static const String currency = '/Currency';
  static const String country = '/Country';
  static const String lanuageSelect = '/lanuageSelect';
  static const String splash = '/Splash';
  static const String addCoin = '/AddCoin';
  static const String walletHistory = '/Wallet_History';
  static const String walletList = '/WalletList';
  static const String ShowSecrete = '/showSecrete';
  static const String showseed_phrase = '/Showseed_phrase';
  static const String webView_Screen = '/WebView_Screen';
  static const String swap = '/Swap';
  static const String localauthVerifyScreen = '/LocalAuthVerifyScreen';
  static const String createPasswordScreen = '/CreatePasswordScreen';
  static const String confirmPasswordScreen = '/ConfirmPasswordScreen';
  static const String qrScan = '/QrScan';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => Splash(), transition: Transition.fadeIn),
    GetPage(
        name: intoduction,
        page: () => Intoduction(),
        transition: Transition.fadeIn),
    GetPage(
        name: importWallet,
        page: () => ImportWallet(),
        transition: Transition.fadeIn),
    GetPage(
        name: createWallet,
        page: () => CreateWallet(),
        transition: Transition.fadeIn),
    GetPage(name: swap, page: () => Swap(), transition: Transition.fadeIn),
    GetPage(
        name: SecretePhase,
        page: () => secretePhase(),
        transition: Transition.fadeIn),
    GetPage(
        name: secretPhase_Match,
        page: () => SecretPhase_Match(),
        transition: Transition.fadeIn),
    GetPage(
        name: bottomNavigationBar,
        page: () => BottomNavigation(),
        transition: Transition.fadeIn),
    GetPage(name: send, page: () => Send(), transition: Transition.fadeIn),
    GetPage(name: buy, page: () => Buy(), transition: Transition.fadeIn),
    GetPage(
        name: selectCoin,
        page: () => SelectCoin(),
        transition: Transition.fadeIn),
    GetPage(
        name: transitionHistory,
        page: () => TransitionHistory(),
        transition: Transition.fadeIn),
    GetPage(
        name: receiveCoin,
        page: () => ReceiveCoin(),
        transition: Transition.fadeIn),
    GetPage(
        name: security,
        page: () => Security(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: currency,
        page: () => Currency(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: country,
        page: () => Country(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: lanuageSelect,
        page: () => LanuageSelect(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: addCoin,
        page: () => AddCoin(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: walletHistory,
        page: () => Wallet_History(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: walletList,
        page: () => WalletList(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: ShowSecrete,
        page: () => showSecrete(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: showseed_phrase,
        page: () => Showseed_phrase(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: webView_Screen,
        page: () => WebView_Screen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: localauthVerifyScreen,
        page: () => LocalAuthVerifyScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: createPasswordScreen,
        page: () => CreatePasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: confirmPasswordScreen,
        page: () => ConfirmPasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: qrScan,
        page: () => QrScan(),
        transition: Transition.rightToLeftWithFade),
  ];
}
