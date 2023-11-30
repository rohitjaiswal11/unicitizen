import 'package:dappwallet/utils/export.dart';

void showCustomSnackBar({required String message, bool isError = true}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.all(10.0),
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : AppColor.bluecolors,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: false,
      closeIconColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text(message,
          style: TextStyle(color: Colors.white, fontFamily: "Poppins")),
    ));
  }
}
