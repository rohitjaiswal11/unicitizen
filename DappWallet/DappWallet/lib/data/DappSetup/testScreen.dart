// ignore_for_file: unused_field

import 'dart:typed_data';

import 'package:dappwallet/data/DappSetup/addressTron.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/web3dart.dart';

class CoinDetailsM {
  final String seedPhrase;
  final String address;
  final String balance;

  CoinDetailsM(
      {required this.seedPhrase, required this.address, required this.balance});
}

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<CoinDetailsM> walletList = [];

  final _web3Wallet = Web3Wallet(
    core: Core(
      projectId: DartDefines.projectId,
    ),
    metadata: const PairingMetadata(
      name: 'Sunlight Wallet',
      description: 'Sunlight Wallet',
      url: 'pancakeswap.finance/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
    ),
  );
  int i = 0;
  // check() async {
  //   final HDWallet wallet =
  //       HDWallet.createWithMnemonic(ConstantClass.selectedWalletMnemonic!);
  //   final key = wallet.getKeyForCoin(TWCoinType.TWCoinTypeTron);
  //   final address = wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron);

  //   print('address-- > $address \n key --> $key');
  // }

  @override
  void initState() {
    super.initState();
  }

  Future<String> getTokenBalance(
    EthereumAddress from,
  ) async {
    final client = Web3Client(
      'https://bsc-dataseed.binance.org/',
      http.Client(),
    );

    final balance = await client.getBalance(from);

    return EthAmountFormatter(balance.getInWei).format();
  }

  @override
  Widget build(BuildContext context) {
    // getlang();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$i',
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: SizedBox(
                height: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TronMsgSignature {
  final Uint8List r;
  final Uint8List s;
  final int v;

  TronMsgSignature(this.r, this.s, this.v);

  Uint8List getSignature() {
    Uint8List sig = Uint8List(65);
    arrayCopy(r, 0, sig, 0, 32);
    arrayCopy(s, 0, sig, 32, 32);
    sig[64] = v;
    return sig;
  }
}

List<int> arrayCopy(bytes, srcOffset, result, destOffset, bytesLength) {
  for (var i = srcOffset; i < bytesLength; i++) {
    result[destOffset + i] = bytes[i];
  }
  return result;
}

/*
Packages Used == >
  trust_wallet_core_lib: ^0.0.6+2.9.6
  tron: ^0.0.1
  grpc: ^3.0.2
  crypto: ^3.0.2

Modifications done in project == >

Added this to MainActivity.kt-

 init {
        System.loadLibrary("TrustWalletCore")
    }

Added this to main.dart's main function-

TrustWalletCoreLib.init();

Created new Folder named Tron in lib and added grpc.dart file

functions made in testScreen.dart == >
 -: getTrxBalance (for fetching trx coin balance)
 -: transcation (for sending trx to other wallet address)
 -: getPrecision (for fetching the precision of a coin and returning the balance accordingly)

//  */

class AbiEntity {
  List<Entrys>? entrys;

  AbiEntity({this.entrys});

  AbiEntity.fromJson(dynamic json) {
    if (json['entrys'] != null) {
      entrys = [];
      json['entrys'].forEach((v) {
        entrys?.add(new Entrys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.entrys != null) {
      data['entrys'] = this.entrys?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => 'AbiEntity(entrys: $entrys)';
}

class Entrys {
  String? name;
  List<Inputs>? inputs;
  List<Outputs>? outputs;
  String? type;
  String? stateMutability;
  bool? constant;

  Entrys(this.name, this.inputs, this.outputs, this.type, this.stateMutability,
      this.constant);

  Entrys.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['inputs'] != null) {
      inputs = [];
      json['inputs'].forEach((v) {
        inputs!.add(new Inputs.fromJson(v));
      });
    }
    if (json['outputs'] != null) {
      outputs = [];
      json['outputs'].forEach((v) {
        outputs!.add(new Outputs.fromJson(v));
      });
    }
    type = json['type'];
    stateMutability = json['stateMutability'];
    constant = json['constant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.inputs != null) {
      data['inputs'] = this.inputs!.map((v) => v.toJson()).toList();
    }
    if (this.outputs != null) {
      data['outputs'] = this.outputs!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['stateMutability'] = this.stateMutability;
    data['constant'] = this.constant;
    return data;
  }

  @override
  String toString() {
    return 'Entrys(name: $name, inputs: $inputs, outputs: $outputs, type: $type, stateMutability: $stateMutability, constant: $constant)';
  }
}

class Inputs {
  String? name;
  String? type;
  bool? indexed;

  Inputs({this.name, this.type, this.indexed});

  Inputs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    indexed = json['indexed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['indexed'] = this.indexed;
    return data;
  }

  @override
  String toString() => 'Inputs(name: $name, type: $type, indexed: $indexed)';
}

class Outputs {
  String? type;

  Outputs({this.type});

  Outputs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }

  @override
  String toString() => 'Outputs(type: $type)';
}

class DartDefines {
  static const String projectId = String.fromEnvironment(
      '4c91b940ab0c622adad1f302ae3e7983',
      defaultValue: '4c91b940ab0c622adad1f302ae3e7983');
  // static const String kadenaPrivateKey = String.fromEnvironment(
  //   'KADENA_PRIVATE_KEY',
  //   defaultValue:
  //       '7d54a79feeb95ac4efdc6cfd4b702da5ee5dc1c31781b76ea092301c266e2451',
  // );
  // static const String kadenaPublicKey = String.fromEnvironment(
  //   'KADENA_PUBLIC_KEY',
  //   defaultValue:
  //       'af242a8d963f184eca742271a5134ee3d3e006f0377d667510e15f6fc18e41d9',
  // );
}
