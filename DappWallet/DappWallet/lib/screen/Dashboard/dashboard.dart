import 'dart:ui';

import 'package:dappwallet/utils/ErrorMessage.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:dappwallet/widget/CustomeListTile.dart';
import 'package:dappwallet/widget/GrayContainer.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = "";
  @override
  void initState() {
    Get.find<DashboardController>().getcoin();
    getdata();
    super.initState();
  }

  getdata() async {
    name = await SharedPreferenceClass.GetSharedData(AppContant.Walletname);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<DashboardController>(builder: (child) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                children: [
                  Container(
                    height: height(context) * 0.3,
                    width: width(context),
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height(context) * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: Appimages.logo,
                                    height: height(context) * 0.07,
                                    width: height(context) * 0.07,
                                    radius: BorderRadius.circular(15),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Lanuage.welcome,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize: 13,
                                            ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Hello $name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              CustomImageView(
                                height: height(context) * 0.04,
                                width: height(context) * 0.04,
                                imagePath: Appimages.wallet,
                                onTap: () {
                                  Get.toNamed(AppRoute.walletList);
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: height(context) * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Lanuage.yourbalance,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 15,
                                        // letterSpacing: 0.2,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.007,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppContant.selectedCurrency
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${child.totalBlanace.toString().length > 7 ? child.totalBlanace.toStringAsFixed(3) : child.totalBlanace.toString()}",
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor,
                                            fontSize: 20,
                                            //  letterSpacing: 0.3,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      barrierColor: Theme.of(context)
                                          .hoverColor
                                          .withOpacity(0.2),
                                      elevation: 3,
                                      backgroundColor: Colors.transparent,
                                      builder: (BuildContext context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 3, sigmaY: 3),
                                          child: Container(
                                            height: height(context) * 0.25,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15)),
                                              color:
                                                  Theme.of(context).cardColor,
                                            ),
                                            child: Column(
                                                children: List.generate(
                                                    child.chainlist.length,
                                                    (index) {
                                              return CustomeListTile(
                                                  tap: false,
                                                  prfix: Radio(
                                                      value: index,
                                                      groupValue:
                                                          child.selectindex,
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      focusColor:
                                                          Theme.of(context)
                                                              .hoverColor,
                                                      onChanged: (value) {
                                                        child.ChnageChain(
                                                            value!);
                                                        Get.back();
                                                      }),
                                                  Title: child.chainlist[index]
                                                      .chain.name
                                                      .toUpperCase()
                                                      .toString(),
                                                  subtitle: "Testnet",
                                                  imagepath: child
                                                      .chainlist[index]
                                                      .chainimage);
                                            })),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.fadecolors,
                                    //shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    Icons.expand_more_sharp,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width(context),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: height(context) * 0.22),
                    height: height(context) * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 4,
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _button(Appimages.send, "${Lanuage.send}",
                            AppRoute.selectCoin, ""),
                        _button(Appimages.buy, Lanuage.receive,
                            AppRoute.selectCoin, "receive"),
                        _button(
                            Appimages.swap, Lanuage.swap, AppRoute.swap, ""),
                        _button(Appimages.history, Lanuage.History,
                            AppRoute.walletHistory, ""),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Lanuage.yourToken,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.addCoin);
                      },
                      child: Container(
                        height: height(context) * 0.04,
                        width: height(context) * 0.04,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.fadecolors,
                          //shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(
                          Icons.add,
                          //size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              child.chainlist.length == 0
                  ? Center(
                      child: pageloder(),
                    )
                  : Column(
                      children: List.generate(
                          child.chainlist[child.selectindex].coinlist.length,
                          (index) {
                        List<CoinData> list =
                            child.chainlist[child.selectindex].coinlist;
                        return _Currancylist(index, list);
                      }),
                    ),
              SizedBox(
                height: height(context) * 0.03,
              )
            ]),
          );
        }),
      ),
    );
  }

  _button(String image, String title, String route, var args) {
    return InkWell(
      onTap: () {
        Get.toNamed(route, arguments: args)!.then((value) {
          // Get.find<DashboardController>().getBalance();
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: image,
            height: height(context) * 0.045,
            width: height(context) * 0.045,
            radius: BorderRadius.circular(6),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }

  _Currancylist(int index, List<CoinData> list) {
    List balnacelist = Get.find<DashboardController>().Balancelist;
    return InkWell(
      onTap: () {
        AppContant.selectedCurrencyindes = index;
        setState(() {});
        Get.toNamed(AppRoute.transitionHistory, arguments: list[index])!
            .then((value) {
          //   Get.find<DashboardController>().getBalance();
        });
      },
      child: GrayContainer(
          radius: 8,
          margin: EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    height: height(context) * 0.05,
                    width: height(context) * 0.05,
                    imagePath: list[index].coinImage,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        list[index].coinName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${AppContant.selectedCurrency.toUpperCase()} ${list[index].price}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hoverColor),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Bal- ${balnacelist[index].toString()}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).hoverColor),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "${list[index].coinPercentage} %",
                    style: TextStyle(
                        color: list[index].coinPercentage.isNegative
                            ? Colors.red
                            : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: height(context) * 0.05,
                    width: width(context) * 0.23,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        lineTouchData: LineTouchData(
                          enabled: false,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.orange.shade50,
                            tooltipRoundedRadius: 8,
                            fitInsideHorizontally: true,
                            getTooltipItems: (spots) => spots
                                .map(
                                  (spot) => LineTooltipItem(
                                    "${AppContant.selectedCurrency}" +
                                        ' ' +
                                        spot.y.toStringAsFixed(2) +
                                        '\n' +
                                        DateTime.fromMicrosecondsSinceEpoch(
                                                spot.x.toInt() * 1000)
                                            .toString(),
                                    TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: list[index].graphData,
                            isCurved: true,
                            barWidth: 1.6,
                            color: index.isEven
                                ? Colors.amber
                                : Colors.orangeAccent,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  index.isEven
                                      ? Colors.amber.withOpacity(0.4)
                                      : Colors.orangeAccent.withOpacity(0.4),
                                  index.isEven
                                      ? Colors.amber.withOpacity(0.16)
                                      : Colors.orangeAccent.withOpacity(0.16),
                                  index.isEven
                                      ? Colors.amber.withOpacity(0.0)
                                      : Colors.orangeAccent.withOpacity(0.0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            aboveBarData: BarAreaData(
                              show: true,
                              color: Colors.transparent,
                              //cutOffY: cutOffYValue,
                              applyCutOffY: false,
                            ),
                            dotData: FlDotData(
                              show: false,
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(show: false),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class currancylist {
  String name;
  String image;
  String value;
  String Price;
  currancylist(
      {required this.name,
      required this.image,
      required this.value,
      required this.Price});
}
