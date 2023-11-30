import 'export.dart';

class AppColor {
  //Dapp App Colors
  // static Color bluecolors = Color(0xff7545F5);
  // static Color graycolors = Color(0xffEDF0F4);
  // static Color grayTextcolors = Color(0xff807F7F);
  // static Color lightbluecolors = Color(0xffAD94F1);
  // static Color fadecolors = Color(0xffA88DF0);

//Wolf app Colors Light MOde
  static Color bluecolors = Color(0xff2B11A6);
  static Color graycolors = Color(0xffEDF0F4);
  static Color grayTextcolors = Color(0xff807F7F);
  static Color lightbluecolors = Color(0xffAD94F1);
  static Color fadecolors = Color.fromARGB(255, 125, 111, 202);

  //Wolf app For Dark Theme Colors
  static Color graycolorsdark = Color(0xff262626);
  static Color grayTextcolorsdark = Color(0xffCACACA);
  static Color lightbluecolorsdark = Color(0xff2B11A6);
  static Color fadecolorsdark = Color(0xff6F57E1);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
