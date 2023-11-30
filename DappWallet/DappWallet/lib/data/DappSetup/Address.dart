import 'dart:convert';
import 'dart:math';

import 'package:bip39/bip39.dart' as bip39;
import 'package:dappwallet/utils/export.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import "package:hex/hex.dart";
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

abstract class OKAddressETH {
  String generateMnemonic();

  Future<String> getPrivateKey(String mnemonic);

  Future<EthereumAddress> getPublicAddress(String privateKey);

  Future<EtherAmount> getCoinBalnace(String address, String url);
}

class Address implements OKAddressETH {
  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(HEX.decode(seed),
        masterSecret: 'Bitcoin seed');
    final privateKey = HEX.encode(master.key);
    print('private: $privateKey');
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.extractAddress();
    print('address: $address');
    return address;
  }

  Future<String> importFor_pvtket({
    required String pvtkey,
  }) async {
    //user address
    var credentials = EthPrivateKey.fromHex(pvtkey);
    var walletaddress = await credentials.extractAddress();

    print("privte key wallet $walletaddress");
    return walletaddress.hex;
  }

  //Get balance for address (Only get the native token balance)
  @override
  Future<EtherAmount> getCoinBalnace(String key, String url) async {
    var credentials = EthPrivateKey.fromHex(key);
    var address = await credentials.extractAddress();

    var httpClient = Client();
    var ethClient = Web3Client(url, httpClient);
    EtherAmount balance = await ethClient.getBalance(address);
    print("Balnace: " + balance.toString() + "    " + url);
    return balance;
  }

//Get balance for smart contarct (it get other token balance)]

  Future<String> getBalance_WithSmartContract(
      {required Object Contractfile,
      required String funcationname,
      required String Contactaddress,
      required String privatekey,
      required String url}) async {
    //User Address
    var credentials = EthPrivateKey.fromHex(privatekey);
    var walletaddress = await credentials.extractAddress();

    //DepolyContract
    final EthereumAddress contractAddr =
        EthereumAddress.fromHex('$Contactaddress');
    final contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(Contractfile), 'Usdt'), contractAddr);

    // extracting the functions
    final balanceFunction = contract.function('$funcationname');

    var httpClient = Client();
    var ethClient = Web3Client(url, httpClient);
    final balance = await ethClient.call(
        contract: contract, function: balanceFunction, params: [walletaddress]);
    print("Coin custome token balnace is: $balance");

    //convert the amount in BigInt to String

    EtherUnit fromUnit = EtherUnit.wei;
    EtherUnit toUnit = EtherUnit.ether;
    // final amount = EtherAmount.fromUnitAndValue(fromUnit,
    //         EtherAmount.fromBigInt(EtherUnit.ether, balance.first).getInEther)
    //     .getValueInUnit(toUnit)
    //     .toString();

    return balance.first;
  }

  Future<dynamic> SendCoin_WithContrcact(
      {required Object Contractfile,
      required String funcationname,
      required String Contactaddress,
      required String privatekey,
      required String receiveraddress,
      required String amount,
      required String url}) async {
    var paramDic;
    try {
      //user address
      var credentials = EthPrivateKey.fromHex(privatekey);
      var walletaddress = await credentials.extractAddress();

      //Recevier address  convert
      final receiverwalletaddress = EthereumAddress.fromHex('$receiveraddress');

      //Depoly contract
      final EthereumAddress contactAddr =
          EthereumAddress.fromHex('$Contactaddress');
      final contract = DeployedContract(
          ContractAbi.fromJson(jsonEncode(Contractfile), 'Usdt'), contactAddr);

      // extracting the functions
      final sendFunction = contract.function('$funcationname');

      //convert amount into stand
      final amt = ConvertToUnit256(num.parse(amount));

      print(
          "the Send coins input: wallet: $walletaddress  recevier: $receiverwalletaddress  $amt Contractadd: $Contactaddress");

      var httpClient = Client();
      var ethClient = Web3Client(url, httpClient);
      final chainID = await ethClient.getChainId();

      final sendcoin = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: sendFunction,
          parameters: [receiverwalletaddress, amt],
          from: walletaddress,
        ),
        chainId: chainID.toInt(),
      );
      print("the coin done is response  $sendcoin");

      paramDic = {"status": "Done", "message": "$sendcoin"};
    } catch (e) {
      print("error" + e.toString());
      showCustomSnackBar(message: e.toString().toString(), isError: true);
      paramDic = {"status": "error", "message": "${e.toString()}"};
      return paramDic;
    }
    return paramDic;
  }

  Future<dynamic> Send_NavtiveCoin(
      {required String privatekey,
      required String receiveraddress,
      required String amount,
      required String url}) async {
    //user address
    var credentials = EthPrivateKey.fromHex(privatekey);
    var walletaddress = await credentials.extractAddress();

    //Recevier address  convert
    final receiverwalletaddress = EthereumAddress.fromHex('$receiveraddress');

    //convert amount into stand
    final amt = EtherAmount.inWei(ConvertToUnit256(num.parse(amount)));

    print(
        "the Send coins input: wallet: $walletaddress  recevier: $receiverwalletaddress  $amt");
    var paramDic;
    try {
      var httpClient = Client();
      var ethClient = Web3Client(url, httpClient);
      final chainID = await ethClient.getChainId();
      final sendcoin = await ethClient.sendTransaction(
        credentials,
        Transaction(
          from: walletaddress,
          to: receiverwalletaddress,
          value: amt,
        ),
        chainId: chainID.toInt(),
        fetchChainIdFromNetworkId: false,
      );
      print("the coin done is response  $sendcoin");
      paramDic = {"status": "Done", "message": "$sendcoin"};
      return paramDic;
    } catch (e) {
      print("error" + e.toString());
      showCustomSnackBar(message: e.toString().toString(), isError: true);
      paramDic = {"status": "error", "message": "${e.toString()}"};
      return paramDic;
    }
  }

  static BigInt ConvertToUnit256(num amount) {
    // var amt=BigInt.from(10).pow(18)*BigInt.from(double.parse(amount.toString()));
    var amt = BigInt.from(double.parse(amount.toString()) * pow(10, 18));
    return amt;
  }

  Future<bool> isvalidateMnemonic(String mnemonic) async {
    bool ischcek = await bip39.validateMnemonic(mnemonic);
    return ischcek;
  }

  static BigInt getWei(String amount, int decimal) {
    final int max = decimal;
    if (amount == "") {
      amount = "0.0";
    }
    final int dotIndex = amount.indexOf(".");
    String ans;

    if (dotIndex == -1) {
      ans = EtherAmount.fromUnitAndValue(EtherUnit.ether, amount)
          .getInWei
          .toString();
    } else {
      final int zerosNo = 18 - (amount.length - dotIndex - 1);
      amount = amount.replaceAll(".", "");
      if (zerosNo < 0) {
        amount = amount.substring(0, amount.length + zerosNo - 1);
      } else {
        for (var i = 0; i < zerosNo; i++) {
          amount += "0";
        }
      }
      ans = amount;
    }
    ans = ans.substring(0, ans.length - (18 - max));
    return BigInt.parse(ans.toString());
  }

  Future<String> getGasFee(String url) async {
    var httpClient = Client();
    final client = Web3Client(
      url,
      httpClient,
    );

    final gasPrice = await client.getGasPrice();
    final finalPrice =
        gasPrice.getValueInUnit(EtherUnit.ether).toStringAsFixed(16);
    final estimatedGas = await client.estimateGas();

    String gasFee =
        (double.parse(finalPrice) * estimatedGas.toDouble()).toStringAsFixed(9);
    Logger.logprint("Gas Fee" + gasFee);
    return gasFee;
  }

  checktransition(String hash, String url) async {
    var httpClient = Client();
    var ethClient = Web3Client(url, httpClient);
    var response = await ethClient.getTransactionByHash(hash);
    print(response);
  }

  Future<String> getInfo_Contract(
      {required Object Contractfile,
      required String funcationname,
      required String Contactaddress,
      required String url,
      var parameter}) async {
    //DepolyContract
    final EthereumAddress contractAddr =
        EthereumAddress.fromHex('$Contactaddress');
    final contract = DeployedContract(
        ContractAbi.fromJson(jsonEncode(Contractfile), 'Usdt'), contractAddr);

    // extracting the functions
    final Function = contract.function('$funcationname');

    try {
      var httpClient = Client();
      var ethClient = Web3Client(url, httpClient);
      var respo = await ethClient.call(
          contract: contract, function: Function, params: parameter ?? []);
      Logger.logprint("REsponse ${respo.toString()}");
      return "${respo.first.toString()}";
    } catch (e) {
      showCustomSnackBar(message: e.toString());
      return "false";
    }
  }

  Future<dynamic> Send_InfoContract(
      {required Object Contractfile,
      required String funcationname,
      required String Contactaddress,
      required String privatekey,
      required String url,
      String? amount,
      bool value = false,
      var parameter}) async {
    var paramDic;
    try {
      print("$parameter");
      //user address
      var credentials = EthPrivateKey.fromHex(privatekey);
      var walletaddress = await credentials.extractAddress();

      //Depoly contract
      final EthereumAddress contactAddr =
          EthereumAddress.fromHex('$Contactaddress');
      final contract = DeployedContract(
          ContractAbi.fromJson(jsonEncode(Contractfile), 'Usdt'), contactAddr);

      // extracting the functions
      final sendFunction = contract.function('$funcationname');

      var httpClient = Client();
      var ethClient = Web3Client(url, httpClient);
      final chainID = await ethClient.getChainId();
      var fee;
      if (value) {
        //convert amount into stand
        final amt = ConvertToUnit256(num.parse(amount!));
        fee = EtherAmount.inWei(amt);
      }

      final sendcoin = await ethClient.sendTransaction(
        credentials,
        value
            ? Transaction.callContract(
                contract: contract,
                function: sendFunction,
                parameters: parameter ?? [],
                from: walletaddress,
                value: fee,
              )
            : Transaction.callContract(
                contract: contract,
                function: sendFunction,
                parameters: parameter ?? [],
                from: walletaddress,
              ),
        chainId: chainID.toInt(),
      );
      print("the coin done is response  $sendcoin");

      paramDic = {"status": "Done", "message": "$sendcoin"};
    } catch (e) {
      print("error" + e.toString());
      showCustomSnackBar(message: e.toString().toString(), isError: true);
      paramDic = {"status": "error", "message": "${e.toString()}"};
      return paramDic;
    }
    return paramDic;
  }

  Future<String> getRecipt(String walletaddress, String hash) async {
    var url =
        "https://${AppContant.bnbbase}/api?module=account&action=tokentx&address=$walletaddress&page=1&offset=1&startblock=0&endblock=99999999999&sort=desc&apikey=${AppContant.bsc_API_KEY}";
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
    print(data.toString());
    if (data["result"][0]["tokenSymbol"].toString() == "WBNB" &&
        data["result"][0]["hash"].toString() == "$hash") {
      var val = double.parse(
              BigInt.from(double.parse(data["result"][0]['value']))
                  .toString()) /
          pow(10, 18);
      return val.toString();
    } else {
      return "";
    }
  }
}
