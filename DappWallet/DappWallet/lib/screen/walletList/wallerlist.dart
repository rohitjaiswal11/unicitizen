import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/data/DatabaseHelper/Wallet.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletList extends StatefulWidget {
  const WalletList({super.key});

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  List<MultiWalletDatabaseModel> walllet = [];
  int walletid = 0;

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    List list = await MultiWalletDatabase.db.getAllWallets() as List;
    walllet.clear();
    for (int i = 0; i < list.length; i++) {
      walllet.add(MultiWalletDatabaseModel(
          id: list[i]["id"],
          walletName: list[i]["walletName"],
          walletAddress: list[i]["walletAddress"],
          tronWalletaddress: list[i]["tronWalletaddress"],
          phraseSeed: list[i]["phraseSeed"],
          privateKey: list[i]["privateKey"]));
    }
    walletid = await SharedPreferenceClass.GetSharedData(AppContant.walletid);
    setState(() {});
    print("id" + list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(
        title: Lanuage.wallet,
        context: context,
        back: true,
        icon: InkWell(
          onTap: () {
            Get.toNamed(AppRoute.intoduction);
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: height(context) * 0.045,
            width: height(context) * 0.045,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.fadecolors,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        height: height(context),
        width: width(context),
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Theme.of(context).cardColor),
        child: walllet.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: walllet.length,
                itemBuilder: (BuildContext context, int index) {
                  //  print(walllet[index].id);
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: height(context) * 0.015),
                    child: InkWell(
                      onTap: () async {
                        // print(walllet[index].phraseSeed.toString());
                        // AddressTron().genaretTronAddress(
                        //     walllet[index].phraseSeed.split(" "));
                        await SharedPreferenceClass.SetSharedData(
                            AppContant.WalletprivateKey,
                            walllet[index].privateKey);
                        await SharedPreferenceClass.SetSharedData(
                            AppContant.Walletaddres,
                            walllet[index].walletAddress);
                        await SharedPreferenceClass.SetSharedData(
                            AppContant.WalletaddresTron,
                            walllet[index].tronWalletaddress);
                        await SharedPreferenceClass.SetSharedData(
                            AppContant.walletid, walllet[index].id);
                        await SharedPreferenceClass.SetSharedData(
                            AppContant.Walletname, walllet[index].walletName);
                        Get.offAllNamed(AppRoute.bottomNavigationBar);
                      },
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.5),
                                child: Icon(
                                  Icons.shield_moon,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              walletid == walllet[index].id
                                  ? Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.check,
                                              size: 18,
                                              color: AppColor.bluecolors,
                                            ),
                                          )),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                walllet[index].walletName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "MutiChain Wolf Wallet",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoute.ShowSecrete,
                                      arguments: walllet[index])!
                                  .then((value) => getdata());
                            },
                            icon: Icon(
                              Icons.more_horiz,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
