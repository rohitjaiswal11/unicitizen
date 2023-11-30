import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dappwallet/data/DappSetup/testScreen.dart';
import 'package:dappwallet/data/DappSetup/tron.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:pointycastle/export.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'package:wallet/wallet.dart' as wallet;
import 'package:http/http.dart' as http;
import 'package:tron/tron.dart' as $t;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:dappwallet/data/DappSetup/typeChanges/abi.dart' as abi;
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf_google/protobuf_google.dart' as $0;
import 'package:tron/src/grpc/core/contract/smart_contract.pb.dart' as $5;

class AddressTron {
  String genaretTronAddress(List<String> phase) {
    final passphrase = '';
    final seed = wallet.mnemonicToSeed(phase, passphrase: passphrase);
    final master = wallet.ExtendedPrivateKey.master(seed, wallet.xprv);
    final root = master.forPath("m/44'/195'/0'/0/0");

    final privateKey =
        wallet.PrivateKey((root as wallet.ExtendedPrivateKey).key);
    final publicKey = wallet.tron.createPublicKey(privateKey);
    final address = wallet.tron.createAddress(publicKey);
    Logger.logprint("tron $address");

    // String hexString =
    //     BigInt.parse(privateKey.value.toString()).toRadixString(16);

    // if (hexString.length < 64) {
    //   hexString = hexString.padLeft(64, '0');
    // }
    //Logger.logprint("key ${hexString.toUpperCase()}");
    // TRON private keys are typically in uppercase

    return address;
    // final seed = bip39.mnemonicToSeed(phase.join(" "));
    // final master = wallet.ExtendedPrivateKey.master(seed, wallet.xprv);
    // final root = master.forPath("m/44'/195'/0'/0/0");

    // final privateKey =
    //     wallet.PrivateKey((root as wallet.ExtendedPrivateKey).key);
    // final publicKey = wallet.tron.createPublicKey(privateKey);
    // final address = wallet.tron.createAddress(publicKey);
    // print("Prive key --> " + privateKey.value.toString());
    // print("address key --> " + address.toString());
    // BigInt bigInteger = BigInt.parse(privateKey.value.toString());
    // return "";
  }

  String genartepvtkey(List<String> phase) {
    final passphrase = '';
    final seed = wallet.mnemonicToSeed(phase, passphrase: passphrase);
    final master = wallet.ExtendedPrivateKey.master(seed, wallet.xprv);
    final root = master.forPath("m/44'/195'/0'/0/0");
    print("keyBIh ${(root as wallet.ExtendedPrivateKey).key}");
    final privateKey =
        wallet.PrivateKey((root as wallet.ExtendedPrivateKey).key);
    final publicKey = wallet.tron.createPublicKey(privateKey);
    final address = wallet.tron.createAddress(publicKey);
    String hexString =
        BigInt.parse(privateKey.value.toString()).toRadixString(16);

    if (hexString.length < 64) {
      hexString = hexString.padLeft(64, '0');
    }
    Logger.logprint("key ${hexString.toUpperCase()}");
    // TRON private keys are typically in uppercase

    return hexString.toUpperCase();
  }

  void importPvtkey(String key) {
    var big_key = BigInt.parse(key, radix: 16);
    print(big_key);
    final publicKey = wallet.tron.createPublicKey(wallet.PrivateKey(big_key));
    // print(publicKey.value);

    final address = wallet.tron.createAddress(publicKey);
    print(address);
  }
  // void gettronAddress(String phase) {
  //   // final seed = bip39.mnemonicToSeed(phase)
  //   final HDWallet wallet = HDWallet.createWithMnemonic(phase);
  //   int coinType = TWCoinType.TWCoinTypeTron;
  //   final key = wallet.getKeyForCoin(coinType);
  //   final privateKey = HEX.encode(key.data());
  //   final address = wallet.getAddressForCoin(coinType);
  //   print("tron Second " + address.toString());
  // }

  // String gettronkey(String phase) {
  //   // final seed = bip39.mnemonicToSeed(phase)
  //   final HDWallet wallet = HDWallet.createWithMnemonic(phase);
  //   int coinType = TWCoinType.TWCoinTypeTron;
  //   final key = wallet.getKeyForCoin(coinType);
  //   final privateKey = HEX.encode(key.data());
  //   final address = wallet.getAddressForCoin(coinType);
  //   print("tron key " + privateKey.toString());
  //   return privateKey;
  // }

  String TronAddresswith_pvtkey(String key) {
    final amt = ConvertToUnit256(num.parse(key));
    final privateKey = wallet.PrivateKey(amt);
    final publicKey = wallet.tron.createPublicKey(privateKey);
    final address = wallet.tron.createAddress(publicKey);

    Logger.logprint("$key    $publicKey     $address");
    return address;
  }

  static BigInt ConvertToUnit256(num amount) {
    // var amt=BigInt.from(10).pow(18)*BigInt.from(double.parse(amount.toString()));
    var amt = BigInt.from(double.parse(amount.toString()) * pow(10, 18));
    return amt;
  }

  Future<double?> getTrxBalance(
      CoinData coin, String meno, String address) async {
    // final HDWallet wallet = HDWallet.createWithMnemonic(meno);
    // final address = wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron);

    final channel = ClientChannelManager.getChannel(
        coin.coinNetwork == NetworkType.TronTestnet
            ? AppContant.trongrpc
            : 'grpc.trongrid.io');
    final stub = $t.WalletClient(channel);
    Uint8List originAddress = Base58.base58Decode(address)!.sublist(0, 21);

    try {
      $t.Account response =
          await stub.getAccount($t.Account()..address = originAddress);

      double trxBalance = response.balance.toDouble() / getPrecision(6);
      Logger.logprint('trx balance == > $trxBalance');
      return trxBalance;
    } catch (e) {
      Logger.logprint('FAiled ==22========>');
      return 0.0;
    }
  }

  Future<bool> sendtron(
      {required String address,
      required String toAddress,
      required String sendAmount,
      required CoinData coinData,
      required String seed}) async {
    try {
      double amount =
          double.parse(sendAmount) * getPrecision(coinData.coindecimal);
      final HDWallet wallet = HDWallet.createWithMnemonic(seed);
      int coinType = TWCoinType.TWCoinTypeTron;
      final key = wallet.getKeyForCoin(coinType);
      final privateKey = hex.encode(key.data());

      final address = wallet.getAddressForCoin(coinType);
      print(address);
      int coin = TWCoinType.TWCoinTypeTron;

      final addressList =
          Base58.base58DecodeNoCheck(wallet.getAddressForCoin(coin));

      if (addressList == null) {
        print("addressList null !!!");
        return false;
      }
      String hexaaddress = hex.encode(addressList);

      Uint8List originFromAddress =
          Base58.base58Decode(address)!.sublist(0, 21);
      late Uint8List originToAddress;
      try {
        originToAddress = Base58.base58Decode(toAddress)!.sublist(0, 21);
      } catch (e) {
        print("error");
      }

      final tc = $t.TransferContract();
      final channel = ClientChannelManager.getChannel(
          coinData.coinNetwork == NetworkType.TronTestnet
              ? 'grpc.shasta.trongrid.io'
              : 'grpc.trongrid.io');
      final stub = $t.WalletClient(channel);

      tc.amount = $fixnum.Int64(amount.toInt());
      tc.ownerAddress = originFromAddress;
      tc.toAddress = originToAddress;
      $t.TransactionExtention trxResult = await stub.createTransaction2(tc);
      $t.Transaction transaction = trxResult.transaction;
      $t.Transaction_raw rawData = trxResult.transaction.rawData;

      Uint8List hash =
          sha256.convert(rawData.writeToBuffer()).bytes as Uint8List;

      MsgSignature msgSignature = sign(hash, hexToBytes(privateKey));

      TronMsgSignature msgSignature2 = TronMsgSignature(
          intToBytes(msgSignature.r),
          intToBytes(msgSignature.s),
          msgSignature.v);
      Uint8List ms2 = msgSignature2.getSignature();

      transaction.signature.add(ms2);
      print(ms2);
      $t.Return result = await stub.broadcastTransaction(transaction);

      if (result.toProto3Json().toString().contains('true') == true) {
        print("done");
        return true;
      } else {
        print('transTrx result error msg: ${utf8.decode(result.message)}');
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  getcontract_trigger({
    required String address,
    required String contractaddress,
    required String coinData,
    required Object coinabi,
  }) async {
    final channel = ClientChannelManager.getChannel(
        coinData.toString() == "TronTestnet"
            ? AppContant.trongrpc
            : 'grpc.trongrid.io');
    final stub = $t.WalletClient(channel);
    String abiCode = jsonEncode(coinabi.toString()).substring(10);
    abiCode = abiCode.substring(0, abiCode.length - 1);
    String functionName = 'name';
    AbiEntity abiEntity = AbiEntity.fromJson(jsonDecode(coinabi.toString()));
    List<String> inputList = [];
    if (abiEntity != null && abiEntity.entrys != null) {
      for (Entrys item in abiEntity.entrys!) {
        if (functionName == item.name) {
          if (item.inputs != null) {
            for (Inputs input in item.inputs!) {
              inputList.add(input.type!);
            }
          }
        }
      }
    }
    Uint8List methodID = abi.methodID(functionName, [address]);
    //Uint8List rawEncode = abi.rawEncode(inputList, []);
    //Uint8List dataList = hexToBytes('a9059cbb' + bytesToHex(rawEncode));
    var tri = $5.TriggerSmartContract(
        contractAddress: Base58.base58Decode(contractaddress),
        ownerAddress: Base58.base58Decode(address),
        callValue: $fixnum.Int64(0),
        data: methodID);
    var respo = await stub.triggerContract(
      tri,
    );
    print("response ${respo.txid}");
  }

  Future<bool> trc20Transfer(
      {required String address,
      required String toAddress,
      required String sendAmount,
      required CoinData coinData,
      required String seed}) async {
    final channel = ClientChannelManager.getChannel(
        coinData.coinNetwork == NetworkType.TronTestnet
            ? AppContant.trongrpc
            : 'grpc.trongrid.io');
    final stub = $t.WalletClient(channel);
    final HDWallet wallet = HDWallet.createWithMnemonic(seed.toString());
    int coinType = TWCoinType.TWCoinTypeTron;
    final key = wallet.getKeyForCoin(coinType);
    final privateKey = hex.encode(key.data());
    final address = wallet.getAddressForCoin(coinType);
    //var privateKey = await genartepvtkey(seed.split(" "));
    print("key   $privateKey");

    try {
      $t.SmartContract response = await stub.getContract($t.BytesMessage()
        ..value =
            Base58.base58Decode(coinData.contractAddress!)!.sublist(0, 21));
      String abiCode = jsonEncode(response.abi.toProto3Json()).substring(10);
      abiCode = abiCode.substring(0, abiCode.length - 1);
      String functionName = 'transfer';
      AbiEntity abiEntity = AbiEntity.fromJson(
          response.abi.toProto3Json() as Map<String, dynamic>);

      List<String> inputList = [];
      if (abiEntity != null && abiEntity.entrys != null) {
        for (Entrys item in abiEntity.entrys!) {
          if (functionName == item.name) {
            if (item.inputs != null) {
              for (Inputs input in item.inputs!) {
                inputList.add(input.type!);
              }
            }
          }
        }
      }

      Uint8List methodID = abi.methodID(functionName, inputList);

      List<dynamic> params = [];
      String abiToAddress = getAbiTronAddress(toAddress);
      double amount =
          double.parse(sendAmount) * getPrecision(coinData.coindecimal);
      params.add(abiToAddress);
      params.add(amount.toStringAsFixed(0));
      Logger.logprint('params $params');
      Uint8List rawEncode = abi.rawEncode(inputList, params);
      Uint8List dataList = hexToBytes('a9059cbb' + bytesToHex(rawEncode));
      Logger.logprint(
          'dataList Data hex = > ${bytesToHex(methodID)} -- ${bytesToHex(rawEncode)}');

      String hexPrivateKey = privateKey;

      bool flag = await execute(
          stub, hexPrivateKey, address, coinData.contractAddress!, dataList, 0);
      if (flag) {
        showCustomSnackBar(message: "Sucess", isError: false);
      } else {
        //showCustomSnackBar(message: "failed", isError: false);
      }
      print(flag);
      return flag;
    } catch (e) {
      Logger.logprint(e.toString());
      return false;
    }
  }

  Future<bool> execute(
      $t.WalletClient stub,
      String hexPrivateKey,
      String base58OwnerAddress,
      String base58ContractAddress,
      Uint8List dataList,
      int callValue) async {
    final $t.TriggerSmartContract req = $t.TriggerSmartContract();
    req.ownerAddress = Base58.base58Decode(base58OwnerAddress)!.sublist(0, 21);
    req.contractAddress =
        Base58.base58Decode(base58ContractAddress)!.sublist(0, 21);
    req.callValue = $fixnum.Int64(callValue);
    req.data = dataList;

    Logger.logprint('dataList $dataList');
    $t.Transaction trans = await buildTransaction(stub, req, hexPrivateKey,
        $t.Transaction_Contract_ContractType.TriggerSmartContract, dataList);
    $t.Return result = await stub.broadcastTransaction(
      trans,
    );
    Logger.logprint(result.toProto3Json().toString());
    if (result.toProto3Json().toString().contains('true') == true) {
      return true;
    } else {
      showCustomSnackBar(
          message: "failed ${utf8.decode(result.message)}", isError: false);

      print('execute error msg: ${utf8.decode(result.message)}');
      return false;
    }
  }

  Future<$t.Transaction> buildTransaction(
      $t.WalletClient stub,
      $t.TriggerSmartContract req,
      String hexPrivateKey,
      $t.Transaction_Contract_ContractType ctxType,
      Uint8List data) async {
    $t.Transaction trans = $t.Transaction();
    trans.rawData = $t.Transaction_raw();
    $t.Transaction_Contract transContract = $t.Transaction_Contract();
    transContract.type = ctxType;
    transContract.parameter = $0.Any.pack(req);
    trans.rawData.contract.add(transContract);

    $t.BlockExtention resp = await stub.getNowBlock2($t.EmptyMessage());
    trans.rawData.refBlockBytes = resp.blockHeader.rawData.number
        .toBytes()
        .reversed
        .toList()
        .sublist(6, 8);
    trans.rawData.refBlockHash = sha256
        .convert(resp.blockHeader.rawData.writeToBuffer())
        .bytes
        .sublist(8, 16);
    trans.rawData.timestamp =
        $fixnum.Int64(DateTime.now().toUtc().millisecondsSinceEpoch);
    trans.rawData.feeLimit = $fixnum.Int64(30 * 1000000);
    trans.rawData.expiration = $fixnum.Int64(DateTime.now()
        .toUtc()
        .add(Duration(seconds: 300))
        .millisecondsSinceEpoch);

    Uint8List hash =
        sha256.convert(trans.rawData.writeToBuffer()).bytes as Uint8List;

    MsgSignature msgSignature = sign(hash, hexToBytes(hexPrivateKey));

    TronMsgSignature msgSignature2 = TronMsgSignature(
        intToBytes(msgSignature.r), intToBytes(msgSignature.s), msgSignature.v);
    Uint8List ms2 = msgSignature2.getSignature();

    trans.signature.add(ms2);
    return trans;
  }

  String getAbiTronAddress(String base58Address) {
    Uint8List address = Base58.base58Decode(base58Address)!.sublist(1, 21);
    return '0x' + bytesToHex(address);
  }

  Future<dynamic> getTrc20Balance(
      CoinData coinData, String urll, String address) async {
    var para;
    try {
      final params = {'address': address, 'limit': '1000'};
      final url = Uri.https(urll, 'api/account/tokens', params);
      Logger.logprint(url.toString());
      try {
        final response = await http.get(
          url,
        );
        final data = jsonDecode(response.body);
        final List coinsList = data['data'];
        final coin = coinsList.firstWhere(
          (element) =>
              element['tokenType'] == 'trc20' &&
              element['tokenId'] == coinData.contractAddress!,
          orElse: () => -1,
        );
        Logger.logprint('coin $coin--  coinsList -- $coinsList');
        if (coin == -1) {
          print('bal = 0');
          para = {
            "status": "0",
          };
          return para;
        } else {
          final balance = int.parse(coin['balance'].toString());
          print('balance : $balance');
          para = {
            "status": "1",
            "balance": balance.toDouble() / getPrecision(6),
            "price": coin['tokenPriceInUsd'].toString(),
          };
          return para;
          // return balance.toDouble() / getPrecision(6);
        }
      } catch (e) {
        Logger.logprint(' Error == $e ==');
        para = {
          "status": "0",
        };
        return para;
      }
    } catch (e) {
      Logger.logprint(' Error 2== $e ==');

      para = {
        "status": "0",
      };
      return para;
    }
  }

  static double getPrecision(int precision) {
    double result = 1;
    double baseValue = 10;
    for (int i = 0; i < precision; i++) {
      result = result * baseValue;
    }
    return result;
  }
}

class EthAmountFormatter {
  EthAmountFormatter(this.amount);

  final BigInt? amount;
  String format({
    EtherUnit fromUnit = EtherUnit.wei,
    EtherUnit toUnit = EtherUnit.ether,
  }) {
    if (amount == null) {
      return '-';
    }

    return EtherAmount.fromUnitAndValue(fromUnit, amount)
        .getValueInUnit(toUnit)
        .toString();
  }
}
