import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/export.dart';

import '../data/Controller/DashboardController.dart';
import '../data/Controller/theme.dart';

Future<Map<String, Map<String, String>>?> initalize() async {
  Get.lazyPut(() => themedata());
  Get.lazyPut(() => Lanuage());
  Get.lazyPut(() => walletController());
  Get.lazyPut(() => DashboardController());
  // Get.lazyPut(() => WebViewModel());
  // Get.lazyPut(() => BrowserModel());
}
