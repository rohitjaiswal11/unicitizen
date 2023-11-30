import 'package:dappwallet/screen/Lock/LockScreen.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/cupertino.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool value1 = true;
  String autlolock = "Immediate";
  List _autolocklist = [
    "Immediate",
    "If away for 1 minute",
    "If away for 5 minute",
    "If away for 10 minute",
    "autolock"
  ];
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    var sttr = await SharedPreferenceClass.GetSharedData(AppContant.autolock);
    var passcodeOn =
        await SharedPreferenceClass.GetSharedData(AppContant.passcodeON) ??
            true;
    if (sttr.toString().contains("1")) {
      autlolock = "If away for 1 minute";
    } else if (sttr.toString().contains("5")) {
      autlolock = "If away for 5 minute";
    } else if (sttr.toString().contains("10")) {
      autlolock = "If away for 10 minute";
    } else if (sttr.toString().contains("autolock")) {
      autlolock = "autolock";
    }
    value1 = passcodeOn;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppbarSecond(title: Lanuage.Security, context: context, back: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Tiles(
                title: Lanuage.Passcode,
                image: Appimages.passcode,
                widget: Transform.scale(
                  //  scale: 0.8,
                  scaleX: 0.9,
                  scaleY: 0.8,
                  child: CupertinoSwitch(
                    activeColor: Theme.of(context).primaryColor,
                    trackColor: Theme.of(context).cardColor,
                    //thumbColor: Theme.of(context).scaffoldBackgroundColor,
                    onChanged: (value) async {
                      setState(() {
                        value1 = value;
                      });
                      await SharedPreferenceClass.SetSharedData(
                          AppContant.passcodeON, value);
                    },
                    value: value1,
                  ),
                )),
            _Tiles(
                title: Lanuage.AutoLock,
                image: Appimages.autolock,
                widget: Text(
                  "$autlolock",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shadowColor: Theme.of(context).cardColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            height: height(context) * 0.35,
                            color: Theme.of(context).cardColor,
                            padding: EdgeInsets.all(10),
                            child: ListView.builder(
                                itemCount: _autolocklist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return lockTypeContainer(height(context),
                                      _autolocklist[index].toString(),
                                      () async {
                                    if (index == 0) {
                                      await SharedPreferenceClass.SetSharedData(
                                          AppContant.autolock, "0");
                                    } else if (index == 1) {
                                      await SharedPreferenceClass.SetSharedData(
                                          AppContant.autolock, "1");
                                    } else if (index == 2) {
                                      await SharedPreferenceClass.SetSharedData(
                                          AppContant.autolock, "5");
                                    } else if (index == 3) {
                                      await SharedPreferenceClass.SetSharedData(
                                          AppContant.autolock, "10");
                                    } else if (index == 4) {
                                      await SharedPreferenceClass.SetSharedData(
                                          AppContant.autolock, "30");
                                    }
                                    autlolock = _autolocklist[index];

                                    Get.back();
                                  });
                                }),
                          ),
                        );
                      }).then((value) => setState(() {}));
                }),
            _Tiles(title: Lanuage.LockMethod, image: Appimages.loclamethod),
            _Tiles(
                title: Lanuage.ChangePassword,
                image: Appimages.changepasscode,
                onTap: () {
                  Get.toNamed(AppRoute.localauthVerifyScreen,
                      arguments: VerifyModel(
                          isForward: true,
                          routeName: AppRoute.createPasswordScreen));
                }),
            Divider(
              color: Theme.of(context).cardColor,
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16),
            //   child: Text(
            //     Lanuage.Askauthenticationfor,
            //     style: Theme.of(context)
            //         .textTheme
            //         .headlineMedium!
            //         .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            //   ),
            // ),
            // SizedBox(
            //   height: height(context) * 0.01,
            // ),
            // _Tiles(
            //     title: Lanuage.Facebook,
            //     image: Appimages.facebook,
            //     widget: Transform.scale(
            //       //  scale: 0.8,
            //       scaleX: 0.9,
            //       scaleY: 0.8,
            //       child: CupertinoSwitch(
            //         activeColor: Theme.of(context).primaryColor,
            //         trackColor: Theme.of(context).cardColor,
            //         //thumbColor: Theme.of(context).scaffoldBackgroundColor,
            //         onChanged: (value) {
            //           setState(() {
            //             value1 = value;
            //           });
            //         },
            //         value: value1,
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }

  _Tiles(
      {required String title,
      required String image,
      Widget? widget,
      GestureTapCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: CustomImageView(
        height: height(context) * 0.04,
        width: height(context) * 0.04,
        imagePath: image,
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: widget ??
          Icon(Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).hoverColor),
    );
  }

  Widget lockTypeContainer(double height, String title, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '$title',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Divider(
            color: Theme.of(context).hoverColor,
            thickness: 1,
          ),
          SizedBox(
            height: height * 0.02,
          ),
        ],
      ),
    );
  }
}
