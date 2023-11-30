// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:dappwallet/utils/export.dart';

import 'package:numeric_keyboard/numeric_keyboard.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  bool isDark = false;

  String confirmPassword = '';
  String displayPassword = '';

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark
        ? isDark = true
        : isDark = false;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Image.asset(
              Appimages.logo,
              height: height * 0.1,
              width: height * 0.1,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              "Confirm Passcode",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              height: height * 0.06,
              width: width * 0.7,
              decoration: BoxDecoration(
                  color: isDark ? Colors.black45 : Color(0xfff1f1f1),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                displayPassword,
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5),
              )),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              child: NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: isDark ? Colors.white : Colors.black,
                  rightButtonFn: () {
                    if (confirmPassword.isEmpty) {
                      return;
                    }
                    setState(() {
                      confirmPassword = confirmPassword.substring(
                          0, confirmPassword.length - 1);
                      displayPassword = displayPassword.substring(
                          0, displayPassword.length - 1);
                    });
                  },
                  rightIcon: Icon(
                    Icons.backspace,
                    color: Theme.of(context).hoverColor,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferenceClass.GetSharedData(
                    AppContant.walletid);

                if (confirmPassword == Get.arguments.toString()) {
                  SharedPreferenceClass.SetSharedData(
                      'loginPin', confirmPassword.toString());

                  if (prefs != null) {
                    Get.offAllNamed(AppRoute.bottomNavigationBar);
                  } else {
                    Get.offAllNamed(AppRoute.intoduction);
                  }
                } else {
                  showCustomSnackBar(
                      message: "Passcode not match", isError: true);
                }
              },
              child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: confirmPassword.length == 6
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ))),
            ),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }

  _onKeyboardTap(String value) async {
    final prefs =
        await SharedPreferenceClass.GetSharedData(AppContant.walletid);

    if (confirmPassword.length == 6) {
      showCustomSnackBar(
          message: "Passcode not be more than 6 digits!", isError: true);
    } else {
      setState(() {
        confirmPassword = confirmPassword + value;
        displayPassword = displayPassword + '*';
      });

      if (confirmPassword.length == 6) {
        if (confirmPassword == Get.arguments.toString()) {
          SharedPreferenceClass.SetSharedData(
              'loginPin', confirmPassword.toString());

          if (prefs != null) {
            Get.offAllNamed(AppRoute.bottomNavigationBar);
          } else {
            Get.offAllNamed(AppRoute.intoduction);
          }
        } else {
          showCustomSnackBar(message: "Passcode not match", isError: true);
        }
      }
    }
  }
}
