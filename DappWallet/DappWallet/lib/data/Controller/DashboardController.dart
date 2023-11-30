import 'dart:convert';

import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/data/DatabaseHelper/Wallet.dart';

import 'package:dappwallet/utils/export.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart' as http;

class DashboardController extends GetxController implements GetxService {
  Address _address = Address();
  List<multichain> _chainlist = [];

  List<multichain> get chainlist => _chainlist;
  int selectindex = 0;
  int selectcoinindex = 0;
  double totalBlanace = 0.0;
  List<String> Balancelist = [
    "0",
    "0",
    "0",
    "0",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  Future<void> getcoin() async {
    var id = await SharedPreferenceClass.GetSharedData(AppContant.walletid);
    var wallets =
        await MultiWalletDatabase.db.getWalletById(int.parse(id.toString()));

    await SharedPreferenceClass.SetSharedData(
        AppContant.WalletprivateKey, wallets!.privateKey.toString());
    Logger.logprint(
        "PVT" + wallets.privateKey.toString() + "   " + wallets.walletAddress);
    if (wallets != null) {
      _chainlist.clear();
      if (wallets.tronWalletaddress.isEmpty) {
        _chainlist.add(multichain(
            chain: walletchain.bsc,
            address: wallets.walletAddress,
            chainimage: Appimages.smartchain,
            Rpcurl: AppContant.RpcBsctestnet,
            coinlist: data
                .where(
                    (element) => element.coinNetwork == NetworkType.BSCTestnet)
                .toList()));
      } else {
        _chainlist.add(multichain(
            chain: walletchain.bsc,
            address: wallets.walletAddress,
            chainimage: Appimages.smartchain,
            Rpcurl: AppContant.RpcBsctestnet,
            coinlist: data
                .where(
                    (element) => element.coinNetwork == NetworkType.BSCTestnet)
                .toList()));
        _chainlist.add(multichain(
            chain: walletchain.tron,
            address: wallets.tronWalletaddress,
            chainimage: Appimages.tron,
            Rpcurl: AppContant.RptrontestNet,
            coinlist: data
                .where(
                    (element) => element.coinNetwork == NetworkType.TronTestnet)
                .toList()));
      }
    }
    Logger.logprint("lengtgh" + _chainlist.length.toString());
    selectindex = 0;
    update();
    await addcoin();
    getBalance();
  }

  ChnageChain(int value) async {
    selectindex = value;
    update();
    await addcoin();
    getBalance();
  }

  addcoin() async {
    var walletid =
        await SharedPreferenceClass.GetSharedData(AppContant.walletid);

    String name = _chainlist[selectindex].chain.name.toString() ==
            walletchain.tron.name.toString()
        ? NetworkType.TronTestnet.name.toString()
        : NetworkType.BSCTestnet.name.toString();
    var wallcoinlist = await SharedPreferenceClass.GetSharedData(
            walletid.toString() + "$name") ??
        [];
    for (var i = 0; i < wallcoinlist.length; i++) {
      var data = jsonDecode(wallcoinlist[i]);
      Logger.logprint("Add" + data.toString());
      final coin = CoinData(
          coinNetwork:
              data["coinNetwork"].toString() == "NetworkType.BSCTestnet"
                  ? NetworkType.BSCTestnet
                  : NetworkType.TronTestnet,
          coinID: data["coinID"],
          coinName: data["coinName"],
          coinImage: data["coinImage"],
          web3HttpUrl: AppContant.RpcBsctestnet,
          contractAddress: data["contractAddress"],
          coinSymbol: data["coinSymbol"],
          coinAbi: data["coinAbi"],
          coindecimal: int.parse(data["coinDecimal"]),
          isOnGecko: true,
          price: 0.0,
          coinPercentage: 0.02,
          isCustom: true,
          graphData: emptyGraphData);
      bool resul = _chainlist[selectindex]
          .coinlist
          .where((element) => element.contractAddress == coin.contractAddress)
          .isEmpty;
      Logger.logprint("resukle" + resul.toString());
      if (resul) {
        chainlist[selectindex].coinlist.add(coin);
      } else {}
      ;
      update();
    }
  }

  getBalance() async {
    String pvtkey =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletprivateKey);

//     Logger.logprint(pvtkey);

    for (int i = 0; i < _chainlist[selectindex].coinlist.length; i++) {
      //For tron
      Logger.logprint(
          "${_chainlist[selectindex].coinlist[i].coinNetwork} ${_chainlist[selectindex].coinlist[i].coinName}");

      if (_chainlist[selectindex].coinlist[i].coinNetwork ==
              NetworkType.TronTestnet ||
          chainlist[selectindex].coinlist[i].coinNetwork == NetworkType.Tron) {
        if (_chainlist[selectindex].coinlist[i].coinAbi != null) {
          int j = i;
          await AddressTron()
              .getTrc20Balance(_chainlist[selectindex].coinlist[i],
                  AppContant.tronbalance, _chainlist[selectindex].address)
              .then((value) {
            Logger.logprint("Value" + value.toString());
            if (value["status"] == "1") {
              Balancelist[j] = value["balance"].toString();
            } else {
              Balancelist[j] = "0.0";
            }
            update();
          });
        } else {
          int j = i;
          var bal = await AddressTron().getTrxBalance(
              _chainlist[selectindex].coinlist[i],
              "meno",
              _chainlist[selectindex].address);
          Balancelist[j] = bal.toString();
        }
      }

      ///For BSC Mainnate
      else {
        if (_chainlist[selectindex].coinlist[i].coinAbi != null) {
          int j = i;
          Balancelist[j] = await _address.getBalance_WithSmartContract(
              Contractfile: _chainlist[selectindex].coinlist[i].coinAbi!,
              funcationname: 'balanceOf',
              Contactaddress:
                  _chainlist[selectindex].coinlist[i].contractAddress!,
              privatekey: pvtkey,
              url: _chainlist[selectindex].Rpcurl);
        } else {
          int j = i;
          await _address
              .getCoinBalnace(pvtkey, _chainlist[selectindex].Rpcurl)
              .then((value) {
            Balancelist[j] = value.getValueInUnit(EtherUnit.ether).toString();
          });
        }
      }

      getAllCoinsGraph(i);
    }
    Logger.logprint("Blance list  ${Balancelist.toString()}");
    update();
    getCoinData();
  }

  Future<double> GetPriceToken_Tron(String address, CoinData coindata) async {
    try {
      final params = {'address': address, 'limit': '1000'};
      final url =
          Uri.https(AppContant.tronbalance, 'api/account/tokens', params);
      Logger.logprint(url.toString());
      final response = await http.get(
        url,
      );
      final data = jsonDecode(response.body);
      final List coinsList = data['data'];
      final coin = coinsList.firstWhere(
        (element) =>
            element['tokenAbbr'].toString().toLowerCase() ==
            coindata.coinName.toLowerCase(),
        orElse: () => -1,
      );
      if (coin == -1) {
        return 0.0;
      }
      ;
      final balance = double.parse(coin['tokenPriceInUsd'].toString());
      Logger.logprint('price : $balance');

      return balance.roundToDouble();
    } catch (e) {
      Logger.logprint(e);
      return 0.0;
    }
  }

  getCoinData() async {
    String ids = '%2c';
    for (var i = 0; i < _chainlist[selectindex].coinlist.length; i++) {
      final coin = _chainlist[selectindex].coinlist[i];
      if (coin.isCustom == true && coin.isOnGecko) {
        ids = ids + '%2c' + coin.coinID.toLowerCase();
      } else {
        Logger.logprint('here');
      }
    }
    Logger.logprint('ids -- -$ids');
    if (ids == '%2c') {
      ids = '';
    }
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=${AppContant.selectedCurrency.toLowerCase()}&ids=binance-usd%2Cbinancecoin%2Ctether%2Cethereum%2Ctron$ids&order=market_cap_desc&per_page=1000&page=1&sparkline=false',
    );
    Logger.logprint('url-- > $url');
    final res = await http.get(url);

    var data = jsonDecode(res.body);
    Logger.logprint(data.toString());

    try {
      for (var i = 0; i < data.length; i++) {
        var index = _chainlist[selectindex].coinlist.indexWhere((element) =>
            element.coinID.toLowerCase() ==
            data[i]['id'].toString().toLowerCase());

        if (index >= 0) {
          _chainlist[selectindex].coinlist.elementAt(index).price =
              double.parse(data[i]['current_price'].toString());
          _chainlist[selectindex].coinlist.elementAt(index).coinPercentage =
              double.parse(data[i]['price_change_percentage_24h'].toString());
        } else {
          Logger.logprint('here --${index}   $i');
        }
      }
    } catch (e) {}
    update();
    getTotalBalance();
  }

  getTotalBalance() {
    totalBlanace = 0.0;

    for (int i = 0; i < _chainlist[selectindex].coinlist.length; i++) {
      totalBlanace = totalBlanace +
          (_chainlist[selectindex].coinlist.elementAt(i).price *
              double.parse(Balancelist[i]));
      print("$totalBlanace");
    }

    update();
  }

  getAllCoinsGraph(index) async {
    final List<Datum> data = await loadStockData(index, '1');

    final List<FlSpot> values = data
        .map((datum) => FlSpot(
              double.parse(datum.date),
              datum.close,
            ))
        .toList();

    _chainlist[selectindex].coinlist[index].graphData =
        values.isEmpty ? emptyGraphData : values;
    update();
  }

  Future<List<Datum>> loadStockData(int index, String interval) async {
    final uri = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${_chainlist[selectindex].coinlist.elementAt(index).coinID}/market_chart?vs_currency=${AppContant.selectedCurrency.isNotEmpty ? AppContant.selectedCurrency.toLowerCase() : 'usd'}&days=$interval");
    Logger.logprint(uri);
    final res = await http.get(uri);

    var data = jsonDecode(res.body);
    List<dynamic> list = data['prices'] ?? [];
    return (list).map((e) => Datum.fromJson(e)).toList();
  }
}

class Datum {
  Datum({required this.date, required this.close});

  final String date;
  final double close;

  Datum.fromJson(var json)
      : date = json.elementAt(0).toString(),
        close = json.elementAt(1).toDouble();
}
