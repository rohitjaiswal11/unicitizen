import 'package:dappwallet/data/Controller/DashboardController.dart';
import 'package:dappwallet/data/DatabaseHelper/coindata.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboard.dart';

class SelectCoin extends StatefulWidget {
  const SelectCoin({super.key});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  List<CoinData> coinlist = [];
  @override
  void initState() {
    coinlist.addAll(Get.find<DashboardController>()
        .chainlist[Get.find<DashboardController>().selectindex]
        .coinlist);
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(
          title: Lanuage.select + " " + Lanuage.coiin,
          context: context,
          back: true),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: height(context) * 0.01,
            ),
            Container(
              height: height(context) * 0.05,
              width: width(context),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                      color: Theme.of(context).hoverColor.withOpacity(0.2)),
                  color: Theme.of(context).cardColor),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Search",
                    style: TextStyle(color: Theme.of(context).hoverColor)),
              ),
            ),
            SizedBox(
              height: height(context) * 0.015,
            ),
            ListView.builder(
                itemCount: coinlist.length,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () {
                        if (Get.arguments.toString() == "receive") {
                          Get.toNamed(AppRoute.receiveCoin,
                              arguments: coinlist[index]);
                          return;
                        }
                        AppContant.selectedCurrencyindes = index;
                        setState(() {});
                        Get.toNamed(AppRoute.send, arguments: coinlist[index]);
                      },
                      tileColor: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      leading: CustomImageView(
                        height: height(context) * 0.04,
                        width: height(context) * 0.04,
                        imagePath: coinlist[index].coinImage,
                      ),
                      title: Text(
                        coinlist[index].coinName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      subtitle: Text(
                        "${AppContant.selectedCurrency.toUpperCase()} " +
                            coinlist[index].price.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w400, fontSize: 13),
                      ),
                      trailing: Text(
                        "Bal- ${Get.find<DashboardController>().Balancelist[index].toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Theme.of(context).hoverColor),
                      ),
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
