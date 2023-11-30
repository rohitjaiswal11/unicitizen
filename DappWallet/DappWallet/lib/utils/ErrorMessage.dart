import 'package:dappwallet/utils/export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showCustomSnackBar({required String message, bool isError = true}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.all(10.0),
      duration: Duration(seconds: 3),
      backgroundColor:
          isError ? Colors.red : Theme.of(Get.context!).primaryColor,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: false,
      closeIconColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Text(
        message,
      ),
    ));
  }
}

Widget pageloder() {
  return Center(
    child: SpinKitCubeGrid(
      color: AppColor.bluecolors,
    ),
  );
}

