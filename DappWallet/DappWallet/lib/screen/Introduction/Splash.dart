import 'dart:async';

import 'package:dappwallet/screen/Lock/LockScreen.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:video_player/video_player.dart';

import '../../data/base/perferance.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  VideoPlayerController _controller =
      VideoPlayerController.asset("asset/splash.mp4");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.initialize().then((_) {
        _controller.setLooping(false);

        setState(() {
          _controller.play();
        });
      });
    });
    Timer(Duration(seconds: 5), () {
      getdata();
    });

    super.initState();
  }

  getdata() async {
    var login =
        await SharedPreferenceClass.GetSharedData(AppContant.LOGINSTAUS);
    var loginpin =
        await SharedPreferenceClass.GetSharedData(AppContant.loginPin) ?? "";
    // await SharedPreferenceClass.SetSharedData(AppContant.WalletprivateKey,
    //     "08070cc574ec0b0f599eec2ad2cc53c81a52393d5f36869dcb37ff6aee4e4c02");

    if (login.toString() == "true") {
      //  Get.toNamed(AppRoute.createPasswordScreen);
      bool lockOn =
          await SharedPreferenceClass.GetSharedData(AppContant.passcodeON) ??
              true;
      if (lockOn) {
        Get.offAllNamed(AppRoute.localauthVerifyScreen,
            arguments: VerifyModel(
                isForward: true, routeName: AppRoute.bottomNavigationBar));
      } else {
        Get.offAllNamed(
          AppRoute.bottomNavigationBar,
        );
      }

      return;
    } else {
      Get.toNamed(AppRoute.createPasswordScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
            width: width(context),
            height: height(context) * 0.6,
            child: VideoPlayer(_controller)),
      ),
    );
  }
}
