import 'package:get/get.dart';

import '../UI/dashboard/dashboard.dart';

class AppRoute{
static const String splashScreen = '/Splash';
  // static const String intoduction = '/intoduction';
  // static const String importWallet = '/ImportWallet';
  // static const String createWallet = '/CreateWallet';
  // static const String SecretePhase = '/secretePhase';
  // static const String secretPhase_Match = '/SecretPhaseMatch';
  // static const String bottomNavigationBar = '/BottomNavigationBar';
  // static const String send = '/Send';
  // static const String buy = '/buy';
  // static const String selectCoin = '/SelectCoin';
  // static const String transitionHistory = '/TransitionHistory';
  // static const String receiveCoin = '/ReceiveCoin';
  // static const String security = '/Security';
  // static const String currency = '/Currency';
  // static const String country = '/Country';
  // static const String lanuageSelect = '/lanuageSelect';
 static const String dashboard = '/dashboard';

  
  static List<GetPage> pages = [
    // GetPage(name: splash, page: () => Splash(), transition: Transition.fadeIn),
    // GetPage(
    //     name: intoduction,
    //     page: () => Intoduction(),
    //     transition: Transition.fadeIn),
    // GetPage(
    //     name: importWallet,
    //     page: () => ImportWallet(),
    //     transition: Transition.fadeIn),
    GetPage(
        name: dashboard,
        page: () => const DashBoard(),
        transition: Transition.fadeIn),


    // GetPage(name: swap, page: () => Swap(), transition: Transition.fadeIn),
    // GetPage(
    //     name: SecretePhase,
    //     page: () => secretePhase(),
    //     transition: Transition.fadeIn),



  
];

}