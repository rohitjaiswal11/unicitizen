import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class NEWApi {
  Future<void> sendTRX(String senderAddress, String receiverAddress,
      double amountTRX, String privateKey) async {
    final int amountSUN = (amountTRX * 1000000).toInt();

//depth pave west only neck write weather chunk jacket refuse logic stable

    // Create a transaction object
    final Map<String, dynamic> transaction = {
      'to_address': receiverAddress,
      'owner_address': senderAddress,
      'amount': amountSUN,
      "visible": true
    };

    final responseSign = await http.post(
        Uri.parse('https://api.shasta.trongrid.io/wallet/createtransaction'),
        body: json.encode(transaction),
        headers: {
          'Content-Type': 'application/json',
          "TRON-PRO-API-KEY": "f5c266c8-245f-424f-8a37-6947ebf54be0"
        });

    final signedTransaction = json.decode(responseSign.body);
    print(signedTransaction.toString());

    String transactionStr = json.encode(transaction);

    // Hash the transaction
    Digest transactionHash = sha256.convert(utf8.encode(transactionStr));
    String hashedTransaction = transactionHash.toString();

    // Sign the transaction hash using the private key
    Digest signature = Hmac(sha256, utf8.encode(privateKey))
        .convert(utf8.encode(hashedTransaction));
    String hexSignature = signature.toString();
    print(signature);

    final pram = {
      "raw_data": signedTransaction["raw_data"],
      "raw_data_hex": signedTransaction["raw_data_hex"],
      "txID": signedTransaction["txID"],
      "signature": [
        '$hexSignature',
      ],
      "visible": "true"
    };

    HttpClient()
        .postUrl(Uri.parse(
            'https://api.shasta.trongrid.io/wallet/broadcasttransaction'))
        .then((HttpClientRequest request) {
      request.headers.set('Content-Type', 'application/json');
      request.headers
          .set('TRON-PRO-API-KEY', 'f5c266c8-245f-424f-8a37-6947ebf54be0');
      request.write(json.encode(pram));
      return request.close();
    }).then((value) {
      value.transform(utf8.decoder).listen((contents) {
        print('Transaction broadcasted: $contents');
      });
    });

    // final signedTransaction = json.decode(responseSign.body);
    // print(signedTransaction.toString());
    // final now = DateTime.now();

    // int coin = TWCoinType.TWCoinTypeTron;

    // final input = Tron.SigningInput(
    //     // transaction: Tron.Transaction.fromJson(json
    //     //     .encode(signedTransaction["raw_data"]["contract"][0]["parameter"])),
    //     transaction: Tron.Transaction(
    //       transfer: Tron.TransferContract(
    //         ownerAddress: senderAddress,
    //         toAddress: '$receiverAddress',
    //         amount: $fixnum.Int64.parseInt('100000'),
    //       ),
    //       timestamp:
    //           $fixnum.Int64.parseInt(now.millisecondsSinceEpoch.toString()),
    //       expiration: $fixnum.Int64.parseInt(
    //           '${now.millisecondsSinceEpoch + 10 * 60 * 60 * 1000}'),
    //       blockHeader: Tron.BlockHeader(
    //         timestamp: signedTransaction["timestamp"],
    //         // txTrieRoot: hex.decode(blockHeader['txTrieRoot']),
    //         // parentHash: hex.decode(blockHeader['parentHash']),
    //         // number: $fixnum.Int64.parseInt(blockHeader['number'].toString()),
    //         // witnessAddress: hex.decode(blockHeader['witness_address']),
    //         // version: blockHeader['version'],
    //       ),
    //     ),
    //     privateKey: gettronkey(
    //         "depth pave west only neck write weather chunk jacket refuse logic stable"));

    // final output = Tron.SigningOutput.fromBuffer(
    //     AnySigner.sign(input.writeToBuffer(), coin).toList());
    // print(output.json);
    // var data = json.decode(output.json);

    // final pram = {
    //   "raw_data": signedTransaction["raw_data"],
    //   "raw_data_hex": signedTransaction["raw_data_hex"],
    //   "txID": signedTransaction["txID"],
    //   "signature": data["signature"][0],
    //   "visible": "true"
    // };
    // // print(pram);
    // final responseBroadcast = await http.post(
    //     Uri.parse('https://api.shasta.trongrid.io/wallet/broadcasttransaction'),
    //     body: json.encode(pram),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       "TRON-PRO-API-KEY": "f5c266c8-245f-424f-8a37-6947ebf54be0"
    //     });

    // final result = json.decode(responseBroadcast.body);
    // print("Borade  $result");
    // // Check the result to see if the transaction was successful
    // if (result['result']) {
    //   print('Transaction ID: ${result['transaction']['txID']}');
    // } else {
    //   print('Error sending TRX: ${result['message']}');
    // }
    // } catch (error) {
    //  print('Error sending TRX: $error');
    // }
  }

  dynamic gettronkey(String phase) {
    // final seed = bip39.mnemonicToSeed(phase)
    final HDWallet wallet = HDWallet.createWithMnemonic(phase);
    int coinType = TWCoinType.TWCoinTypeTron;
    final key = wallet.getKeyForCoin(coinType);
    print(key.getPublicKey(16).data());
    return key.data();
    final privateKey = HEX.encode(key.data());

    final address = wallet.getAddressForCoin(coinType);
    print("tron key " + privateKey.toString());
    // var hexString = BigInt.parse(privateKey).toRadixString(16);
    return address;
  }
}
