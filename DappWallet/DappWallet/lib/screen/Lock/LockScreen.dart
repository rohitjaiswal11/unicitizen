// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:io';
import 'package:dappwallet/utils/export.dart';
import 'package:local_auth/local_auth.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthVerifyScreen extends StatefulWidget {
  const LocalAuthVerifyScreen({super.key});

  @override
  State<LocalAuthVerifyScreen> createState() => _LocalAuthVerifyScreenState();
}

class _LocalAuthVerifyScreenState extends State<LocalAuthVerifyScreen> {
  bool isDark = false;
  bool isOnlyPasscode = false;
  VerifyModel? mdl;
  String password = '';
  String displayPassword = '';

  void _checkBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {} catch (e) {}

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {}

    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {});
    } else {}

    bool authenticated = false;
    try {
      AppContant.appLockStatus = 'biometricOff';
      authenticated = await auth.authenticate(
          localizedReason: 'Touch your finger on the sensor to login',
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: true,
          ));

      if (authenticated) {
        AppContant.appLockStatus = 'unlock';
        if (mdl!.isForward) {
          Get.offNamed(mdl!.routeName);
        } else {
          Navigator.pop(context, true);
        }
      } else {
        AppContant.appLockStatus = 'biometricOff';
        setState(() {});
      }
    } catch (e) {}
    setState(() {});
  }

  checkVerificationMethod() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lockMethod') != null) {
      if (prefs.getString('lockMethod').toString() == 'Passcode/Biometric') {
        setState(() {
          isOnlyPasscode = true;
        });
        _checkBiometric();
      } else {
        setState(() {
          isOnlyPasscode = false;
        });
      }
    } else {
      setState(() {
        isOnlyPasscode = true;
      });
      _checkBiometric();
    }
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    mdl = Get.arguments as VerifyModel;
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    checkVerificationMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark
        ? isDark = true
        : isDark = false;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        toolbarHeight: height * 0.1,
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: isOnlyPasscode
                ? IconButton(
                    onPressed: () async {
                      _checkBiometric();
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.fingerprint,
                      color: Theme.of(context).canvasColor,
                      size: 48,
                    ),
                  )
                : null,
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Enter Passcode",
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
                      if (password.isEmpty) {
                        return;
                      }
                      setState(() {
                        password = password.substring(0, password.length - 1);
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
                  if (password.length == 6) {
                    String authPass = await SharedPreferenceClass.GetSharedData(
                        AppContant.LOGINPIN);
                    if (authPass == password) {
                      AppContant.appLockStatus = 'unlock';
                      if (mdl!.isForward) {
                        Navigator.pushReplacementNamed(context, mdl!.routeName);
                      } else {
                        Navigator.pop(context, true);
                      }
                    } else if (password.isEmpty) {
                      showCustomSnackBar(
                          message: "Wrong passcode", isError: true);
                    } else {
                      setState(() {
                        showCustomSnackBar(
                            message: "Wrong Passcode!", isError: true);
                        password = '';
                        displayPassword = '';
                      });
                    }
                  } else {
                    setState(() {
                      showCustomSnackBar(
                          message: "Wrong passcode", isError: true);
                      password = '';
                      displayPassword = '';
                    });
                  }
                },
                child: Container(
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
      ),
    );
  }

  _onKeyboardTap(String value) async {
    if (password.length == 6) {
      showCustomSnackBar(message: "Wrong passcode", isError: true);
    } else {
      setState(() {
        password = password + value;
        displayPassword = displayPassword + '*';
      });

      if (password.length == 6) {
        String authPass =
            await SharedPreferenceClass.GetSharedData(AppContant.LOGINPIN);
        if (authPass == password) {
          //Navigator.pushNamed(context, BottomNavigationBarScreen.id);
          AppContant.appLockStatus = 'unlock';
          if (mdl!.isForward) {
            Navigator.pushReplacementNamed(context, mdl!.routeName);
          } else {
            Navigator.pop(context, true);
          }
        } else {
          setState(() {
            showCustomSnackBar(message: "Wrong passcode", isError: true);
            password = '';
            displayPassword = '';
          });
        }
      }
    }
  }
}

class VerifyModel {
  bool isForward;
  String routeName;

  VerifyModel({required this.isForward, required this.routeName});
}
