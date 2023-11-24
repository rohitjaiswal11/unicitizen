import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAssetCard extends StatelessWidget {

  const MyAssetCard({
    super.key,

  });

  @override
  Widget build(BuildContext context) {

    return ListView.separated(separatorBuilder: (context, index) {return SizedBox(

      height: 15,
    );
      
    },
      primary: false,
      shrinkWrap: true,
        itemCount: assetitems.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            height: Get.height / 11,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: Get.height * 0.06,
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Colors.grey.shade100,
                  ),
                  child: Image.asset(assetitems[index].image),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    assetitems[index].  coinname,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                  assetitems[index].    coinrate,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Image.asset(
               assetitems[index].   coingraph,
                  height: Get.height / 20,
                ),
                Text(
            assetitems[index].      coinwallet,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        });
  }
}

class AssetModal {
  final String image;
  final String coinname;
  final String coinrate;
  final String coingraph;
  final String coinwallet;

  AssetModal(
      {required this.image,
      required this.coinname,
      required this.coinrate,
      required this.coingraph,
      required this.coinwallet});}

  List<AssetModal> assetitems = [
    AssetModal(
        image: "assets/dashboard/myassetcard/binance.png",
        coinname: "Binance",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    AssetModal(
        image: "assets/dashboard/myassetcard/binance.png",
        coinname: "Etherium",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    AssetModal(
        image: "assets/dashboard/myassetcard/binance.png",
        coinname: "0",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    AssetModal(
        image: "assets/dashboard/myassetcard/binance.png",
        coinname: "0",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
  ];

