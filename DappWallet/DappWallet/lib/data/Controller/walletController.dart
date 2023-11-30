import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:dappwallet/data/DatabaseHelper/Wallet.dart';
import 'package:dappwallet/data/base/Contant.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/export.dart';

class walletController extends GetxController implements GetxService {
  Address _address = Address();
  AddressTron _tron = AddressTron();
  List seedphases = [];
  String pvtKey = "", walletaddress = "";

  Future<void> getphase() async {
    var pahse = _address.generateMnemonic();
    Logger.logprint(pahse.toString());
    seedphases.clear();
    seedphases = pahse.split(" ");
    Logger.logprint(seedphases.length);
    update();
  }

  Future<bool> genrateaddress(String phase, String name) async {
    try {
      String key = await Address().getPrivateKey(phase);
      pvtKey = key.toString();
      var add = await _address.getPublicAddress(key);
      walletaddress = add.toString();

      update();
      var tron = await _tron.genaretTronAddress(phase.split(" "));
      // var tronpvtkey = await _tron.genartepvtkey(phase.split(" "));

      // add  in database
      int walletsCount = await MultiWalletDatabase.db.countWallets();
      int walletId = DateTime.now().millisecondsSinceEpoch;
      String nameselect = await getdata();
      await MultiWalletDatabase.db.insert(
        walletId,
        name.isEmpty ? nameselect.toString() : name.toString(),
        walletaddress.toString(),
        tron.toString(),
        seedphases.join(" ").toString(),
        pvtKey.toString(),
      );

      await SharedPreferenceClass.SetSharedData(
          AppContant.WalletprivateKey, pvtKey);
      await SharedPreferenceClass.SetSharedData(
          AppContant.Walletaddres, walletaddress);
      await SharedPreferenceClass.SetSharedData(
          AppContant.WalletaddresTron, tron);
      await SharedPreferenceClass.SetSharedData(AppContant.WalletSeed, phase);
      await SharedPreferenceClass.SetSharedData(AppContant.walletid, walletId);
      await SharedPreferenceClass.SetSharedData(
          AppContant.Walletname,
          name.isEmpty
              ? 'Wallet ' + (walletsCount + 1).toString()
              : name.toString());
      await SharedPreferenceClass.SetSharedData(AppContant.LOGINSTAUS, "true");
      return true;
    } catch (e) {
      showCustomSnackBar(message: "$e", isError: true);
      return false;
    }
  }

  Future<String> getdata() async {
    int walletsCount = await MultiWalletDatabase.db.countWallets();
    List list = await MultiWalletDatabase.db.getAllWallets();
    print(list.toString());
    var name = "";
    for (int i = 0; i < list.length; i++) {
      if (list[i]["walletName"] == "Wallet${walletsCount + 1}") {
        name = "Wallet${walletsCount + 1 + i}";
        break;
      } else {
        name = "Wallet${walletsCount + 1}";
      }
    }
    return name;
  }

  Future<bool> importWallet_WithPvtkey(String key, String name) async {
    Address().importFor_pvtket(pvtkey: key).then((value) async {
      Logger.logprint("address+ $value");
      if (value.isNotEmpty) {
        pvtKey = key;
        walletaddress = value.toString();

        // add  in database
        int walletsCount = await MultiWalletDatabase.db.countWallets();
        int walletId = DateTime.now().millisecondsSinceEpoch;

        await MultiWalletDatabase.db.insert(
          walletId,
          name,
          walletaddress.toString(),
          "",
          seedphases.join(" ").toString(),
          pvtKey.toString(),
        );
        await SharedPreferenceClass.SetSharedData(
            AppContant.walletid, walletId);
        await SharedPreferenceClass.SetSharedData(
            AppContant.Walletname, "$name");
        await SharedPreferenceClass.SetSharedData(
            AppContant.WalletprivateKey, pvtKey);
        await SharedPreferenceClass.SetSharedData(
            AppContant.Walletaddres, walletaddress);
        await SharedPreferenceClass.SetSharedData(
            AppContant.LOGINSTAUS, "true");
        update();
        Get.offAllNamed(AppRoute.bottomNavigationBar);
        showCustomSnackBar(message: "Wallet create Successfully.");
        return true;
      } else {
        showCustomSnackBar(message: "Error in address", isError: false);
        return false;
      }
    });
    return false;
  }
}

class multichain {
  walletchain chain;
  String address;
  String chainimage;
  List<CoinData> coinlist;
  String Rpcurl;
  multichain(
      {required this.chain,
      required this.address,
      required this.chainimage,
      required this.Rpcurl,
      required this.coinlist});
}

enum walletchain { tron, bsc }
