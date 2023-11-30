import 'package:dappwallet/data/Controller/theme.dart';
import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/cupertino.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool value1 = false;
  var _instance = Get.find<themedata>();
  String walletname = "";
  @override
  void initState() {
    value1 = _instance.gettheme == ThemeMode.dark ? true : false;
    getdata();
    setState(() {});
    super.initState();
  }

  getdata() async {
    walletname =
        await SharedPreferenceClass.GetSharedData(AppContant.Walletname);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(title: Lanuage.settings, context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(AppRoute.walletList);
                },
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomImageView(
                        imagePath: Appimages.wallet,
                        color: AppColor.bluecolors),
                  ),
                ),
                title: Text(Lanuage.wallet,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                subtitle: Text(walletname,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              Divider(
                color: Theme.of(context).cardColor,
              ),
              // SizedBox(
              //   height: height(context) * 0.02,
              // ),
              _Tiles(
                  title: Lanuage.darkmode,
                  image: Appimages.Darkmode,
                  widget: Transform.scale(
                    //  scale: 0.8,
                    scaleX: 0.9,
                    scaleY: 0.8,
                    child: CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      trackColor: Theme.of(context).cardColor,
                      //thumbColor: Theme.of(context).scaffoldBackgroundColor,
                      onChanged: (value) {
                        setState(() {
                          value1 = value;
                        });
                        ThemeMode thm;
                        if (_instance.gettheme == ThemeMode.dark) {
                          thm = ThemeMode.light;
                        } else {
                          thm = ThemeMode.dark;
                        }
                        _instance.setTheme(thm);
                      },
                      value: value1,
                    ),
                  )),
              _Tiles(
                  title: Lanuage.Security,
                  image: Appimages.security,
                  onTap: () => Get.toNamed(AppRoute.security)),
              _Tiles(
                title: Lanuage.Currency,
                image: Appimages.currency,
                onTap: () => Get.toNamed(AppRoute.currency),
              ),
              _Tiles(
                title: Lanuage.Country,
                image: Appimages.country,
                onTap: () => Get.toNamed(AppRoute.country),
              ),
              _Tiles(title: Lanuage.Pricealerts, image: Appimages.pricealert),
              _Tiles(
                  title: Lanuage.Support,
                  image: Appimages.support,
                  onTap: () async {
                    // String seedphared =
                    //     await SharedPreferenceClass.GetSharedData(
                    //             AppContant.WalletSeed) ??
                    //         "";
                    // String pvtkey = await AddressTron()
                    //     .genartepvtkey(seedphared.split(" "));
                    // AddressTron().importPvtkey(
                    //      "4ad373b540a2149ba2b31b72176fd6152b1e168eefe81e571dea0a003be0aac8",
                    //   // "E40437FF211051B802F77F9037C809DE728D33723FC5879853C15C449CC72A07"
                    // );
                    //Get.to(Tron_setup());
                  }),
              _Tiles(
                  title: Lanuage.Lanuageselect,
                  image: Appimages.passcode,
                  onTap: () {
                    Get.toNamed(AppRoute.lanuageSelect);
                  }),
              _Tiles(
                  title: Lanuage.About, image: Appimages.about, onTap: () {}),
              Divider(
                color: Theme.of(context).cardColor,
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  Lanuage.JoinCommunity,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              _Tiles(title: Lanuage.Facebook, image: Appimages.facebook),
              _Tiles(title: Lanuage.Instagram, image: Appimages.instagram),
              _Tiles(title: Lanuage.YouTube, image: Appimages.youtube),
              SizedBox(
                height: height(context) * 0.03,
              ),
            ],
          ),
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
}
