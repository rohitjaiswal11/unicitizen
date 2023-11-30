import 'dart:math';

import 'package:dappwallet/data/base/Contant.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/export.dart';

class themedata extends GetxController implements GetxService {
  ThemeMode _theme = ThemeMode.light;

  ThemeMode get gettheme => _theme;

  Future<void> setTheme(ThemeMode md) async {
    _theme = md;
    if (md == ThemeMode.dark) {
      await SharedPreferenceClass.SetSharedData(AppContant.THEME, "dark");
    } else {
      await SharedPreferenceClass.SetSharedData(AppContant.THEME, "light");
    }
    print("DPONE MoDE");
    update();
  }

  getshared() async {
    var data = await SharedPreferenceClass.GetSharedData(AppContant.THEME);
    if (data.toString() == "dark") {
      _theme = ThemeMode.dark;
    }
    update();
    return;
  }
}
