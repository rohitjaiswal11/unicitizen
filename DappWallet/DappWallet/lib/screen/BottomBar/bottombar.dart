import 'package:dappwallet/screen/Dashboard/dashboard.dart';
import 'package:dappwallet/screen/history/browerdata.dart';
import 'package:dappwallet/utils/export.dart';

import '../../walletConnect/browser.dart';
import '../Setting/Settings.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _select = 1;
  List<Widget> _listwidget = [Dashboard(), Browser(), Setting()];

  @override
  void initState() {
    // TODO: implement initState
    Get.find<Lanuage>().changelanuage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 65,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            //color: Colors.red,
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _bottomIcon(title: "Wallet", ind: 1, image: Appimages.wallet),
          _bottomIcon(title: "Dex", ind: 2, image: Appimages.dex),
          _bottomIcon(title: "Setting", ind: 3, image: Appimages.setting),
        ]),
      ),
      body: _listwidget[_select - 1],
    );
  }

  _bottomIcon(
      {required String title, required int ind, required String image}) {
    return InkWell(
      onTap: () {
        setState(() {
          _select = ind;
        });
      },
      child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0.3,
            end: _select == ind ? 1.0 : 0.0,
          ),
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeOutQuint,
          builder: (context, t, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: width(context) * 0.17,
                  decoration: BoxDecoration(
                    color: _select == ind
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomImageView(
                    imagePath: image,
                    margin: EdgeInsets.all(6),
                    height: 10,
                    width: 10,
                    color: _select == ind
                        ? Theme.of(context).shadowColor
                        : Theme.of(context).dialogBackgroundColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "$title",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: _select == ind
                          ? Theme.of(context).shadowColor
                          : Theme.of(context).dialogBackgroundColor,
                      letterSpacing: 0.2),
                )
              ],
            );
          }),
    );
  }
}
