// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, unused_element

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import '../../dependencies/chains/i_chain.dart';
import '../../dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import '../../dependencies/i_web3wallet_service.dart';
import '../../dependencies/key_service/chain_key.dart';
import '../../dependencies/key_service/i_key_service.dart';
import '../../models/eth/ethereum_transaction.dart';
import '../../utils/eth_utils.dart';
import '../../widgets/wc_connection_widget/wc_connection_model.dart';
import '../../widgets/wc_connection_widget/wc_connection_widget.dart';
import '../../widgets/wc_request_widget.dart/wc_request_widget.dart';
import 'package:web3dart/web3dart.dart';

enum EVMChainId {
  ethereum,
  polygon,
  goerli,
  mumbai,
}

extension KadenaChainIdX on EVMChainId {
  String chain() {
    String name = '';

    switch (this) {
      case EVMChainId.ethereum:
        name = '56';
        break;
      case EVMChainId.polygon:
        name = '137';
        break;
      case EVMChainId.goerli:
        name = '5';
        break;
      case EVMChainId.mumbai:
        name = '80001';
        break;
    }

    return '${EVMService.namespace}:$name';
  }
}

class EVMService extends IChain {
  static const namespace = 'eip155';
  static const pSign = 'personal_sign';
  static const eSign = 'eth_sign';
  static const eSignTransaction = 'eth_signTransaction';
  static const eSignTypedData = 'eth_signTypedData';
  static const eSendTransaction = 'eth_sendTransaction';

  final IBottomSheetService _bottomSheetService =
      GetIt.I<IBottomSheetService>();
  final IWeb3WalletService _web3WalletService = GetIt.I<IWeb3WalletService>();

  final EVMChainId reference;

  final Web3Client ethClient;

  EVMService({
    required this.reference,
    Web3Client? ethClient,
  }) : ethClient = ethClient ??
            // Web3Client('https://bsc-dataseed1.binance.org/', http.Client()) {
            Web3Client(' https://data-seed-prebsc-1-s1.binance.org:8545/',
                http.Client()) {
    final Web3Wallet wallet = _web3WalletService.getWeb3Wallet();
    for (final String event in getEvents()) {
      wallet.registerEventEmitter(chainId: getChainId(), event: event);
    }
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: pSign,
      handler: personalSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSign,
      handler: ethSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTransaction,
      handler: ethSignTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSendTransaction,
      handler: ethSendTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTypedData,
      handler: ethSignTypedData,
    );
  }

  @override
  String getNamespace() {
    return namespace;
  }

  @override
  String getChainId() {
    return reference.chain();
  }

  @override
  List<String> getEvents() {
    return ['chainChanged', 'accountsChanged'];
  }

  Future<String?> requestAuthorization(String text) async {
    log('Sign Text -- $text -- \n TExt ${WCConnectionModel(
      text: text,
    ).toString()}');

    final bool? approved = await _bottomSheetService.queueBottomSheet(
      widget: WCRequestWidget(
        child: WCConnectionWidget(
          title: 'Sign Transaction',
          info: [
            WCConnectionModel(
              text: text,
            ),
          ],
        ),
      ),
    );

    if (approved != null && approved == false) {
      return 'User rejected signature';
    }

    return null;
  }

  Future personalSign(String topic, dynamic parameters) async {
    print('received personal sign request: $parameters');

    final String message = EthUtils.getUtf8Message(parameters[0]);

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      // Load the private key
      final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
        getChainId(),
      );
      final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);

      final String signature = hex.encode(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(
            utf8.encode(message),
          ),
        ),
      );

      return '0x$signature';
    } catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future ethSign(String topic, dynamic parameters) async {
    print('received eth sign request: $parameters');

    final String message = EthUtils.getUtf8Message(parameters[1]);

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      // Load the private key
      final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
        getChainId(),
      );
      // print('private key');
      // print(keys[0].privateKey);

      // final String signature = EthSigUtil.signMessage(
      //   message: Uint8List.fromList(
      //     utf8.encode(message),
      //   ),
      //   privateKey: keys[0].privateKey,
      // );
      final EthPrivateKey credentials = EthPrivateKey.fromHex(
        keys[0].privateKey,
      );
      final String signature = hex.encode(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(
            utf8.encode(message),
          ),
        ),
      );
      print(signature);

      return '0x$signature';
    } catch (e) {
      print('error:');
      print(e);
      return 'Failed';
    }
  }

  //     final String signedTx = hex.encode(sig);
  //     print('-- signedTx -- $signedTx');
  //     // Return the signed transaction as a hexadecimal string
  //     return '0x$signedTx';
  //   } catch (e) {
  //     print('error ---- > $e');
  //     return 'Failed';
  //   }
  // }

  Future<String> ethSendTransaction(String topic, dynamic parameters) async {
    print('received eth send transaction request: $parameters');

    // final String transactionData = parameters[0];
    // final String? authAcquired = await requestAuthorization(transactionData);
    // if (authAcquired != null) {
    //   return authAcquired;
    // }

    try {
      // Load the private key from the key service
      final List<ChainKey> keys =
          GetIt.I<IKeyService>().getKeysForChain(getChainId());
      final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);
      print('Here --> 1 ' + keys[0].privateKey.toString());
      // Parse the EthereumTransaction from JSON
      final EthereumTransaction ethTransaction =
          EthereumTransaction.fromJson(parameters[0]);
      print('Here --> 2');

      final from = EthereumAddress.fromHex(ethTransaction.from);
      print('Check Error --> 1');

      final to = EthereumAddress.fromHex(ethTransaction.to);
      print('Check Error --> 2');
      print('Check Error --> ethTransaction.value' +
          ethTransaction.value.toString());

      final value = EtherAmount.fromUnitAndValue(EtherUnit.wei,
          BigInt.tryParse(ethTransaction.value ?? '') ?? BigInt.zero);
      print('Check Error --> 3' + value.toString());

      // final gasPrice = ethTransaction.gasPrice != null

      final data = (ethTransaction.data != null && ethTransaction.data != '0x')
          ? hexToBytes(ethTransaction.data!)
          : null;

      print('Check Error --> 8');

      // Construct a Transaction object from the EthereumTransaction
      final Transaction transaction = Transaction(
        from: from,
        to: to,
        value: value,
        // gasPrice: gasPrice,
        // maxFeePerGas: maxFeePerGas,
        // maxPriorityFeePerGas: maxPriorityFeePerGas,

        // nonce: nonce,
        data: data,
      );
      print('Here --> 3');

      final String txHash = await ethClient
          .sendTransaction(credentials, transaction, chainId: 56);
      print('Transaction Hash: $txHash');

      return txHash;
    } catch (e) {
      print('Error sending transaction: $e');
      throw e;
      // return 'Failed';
    }
  }

  Future ethSignTransaction(String topic, dynamic parameters) async {
    print('received eth sign transaction request: $parameters');
    final String? authAcquired = await requestAuthorization(
      jsonEncode(
        parameters[0],
      ),
    );
    if (authAcquired != null) {
      return authAcquired;
    }

    // Load the private key
    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      getChainId(),
    );
    final Credentials credentials = EthPrivateKey.fromHex(
      '0x${keys[0].privateKey}',
    );

    EthereumTransaction ethTransaction = EthereumTransaction.fromJson(
      parameters[0],
    );
    // Construct a transaction from the EthereumTransaction object
    final transaction = Transaction(
      from: EthereumAddress.fromHex(ethTransaction.from),
      to: EthereumAddress.fromHex(ethTransaction.to),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.tryParse(ethTransaction.value ?? '') ?? BigInt.zero,
      ),
      gasPrice: ethTransaction.gasPrice != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.gasPrice!) ?? BigInt.zero,
            )
          : null,
      maxFeePerGas: ethTransaction.maxFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxFeePerGas!) ?? BigInt.zero,
            )
          : null,
      maxPriorityFeePerGas: ethTransaction.maxPriorityFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxPriorityFeePerGas!) ??
                  BigInt.zero,
            )
          : null,
      maxGas: int.tryParse(ethTransaction.gasLimit ?? ''),
      nonce: int.tryParse(ethTransaction.nonce ?? ''),
      data: (ethTransaction.data != null && ethTransaction.data != '0x')
          ? Uint8List.fromList(hex.decode(ethTransaction.data!))
          : null,
    );

    try {
      final Uint8List sig = await ethClient.signTransaction(
        credentials,
        transaction,
      );

      // Sign the transaction
      final String signedTx = hex.encode(sig);

      // Return the signed transaction as a hexadecimal string
      return '0x$signedTx';
    } catch (e) {
      print('Errr ----$e');
      return 'Failed';
    }
  }

  Future ethSignTypedData(String topic, dynamic parameters) async {
    print('received eth sign typed data request: $parameters');
    final String data = parameters[1];
    final String? authAcquired = await requestAuthorization(data);
    if (authAcquired != null) {
      return authAcquired;
    }

    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      getChainId(),
    );

    // EthPrivateKey credentials = EthPrivateKey.fromHex(keys[0].privateKey);
    // credentials.

    return EthSigUtil.signTypedData(
      privateKey: keys[0].privateKey,
      jsonData: data,
      version: TypedDataVersion.V4,
    );
  }

  String _getReadableTransactionData(String transactionData) {
    // Convert the transaction data to a Map.
    try {
      Map<String, dynamic> transactionDataMap = jsonDecode(transactionData);

      // Get the transaction details.
      String fromAddress = transactionDataMap['from'] ?? '';
      // String toAddress = transactionDataMap['to'] ?? '';
      String value = transactionDataMap['value'] ?? '0';
      String gasPrice = transactionDataMap['gas'] ?? '0';
      // String gasUsed = transactionDataMap['gasUsed'] ?? '0';

      // Format the transaction details.
      String formattedFromAddress = '0x' + fromAddress;
      // String formattedToAddress = '0x' + toAddress;
      String formattedValue = BigInt.parse(value).toString();
      String formattedGasPrice = BigInt.parse(gasPrice).toString();
      // String formattedGasUsed = BigInt.parse(gasUsed).toString();

      // Return the formatted transaction details.
      return 'From: $formattedFromAddress\n'
          'Value: ${_getValueInBNB(formattedValue)}\n'
          'Gas price: ${_getGasPriceInBNB(formattedGasPrice)} BNB (approx)';
    } catch (e) {
      return transactionData;
    }
  }

  String _getGasPriceInBNB(String gasPrice) {
    // Get the gas price in Gwei.
    int gasPriceInGwei = int.parse(gasPrice);

    // Convert the gas price in Gwei to BNB.
    double gasPriceInBNB = gasPriceInGwei / 100000000;

    // Format the gas price in BNB.
    String formattedGasPriceInBNB = gasPriceInBNB.toStringAsFixed(4);

    // Return the formatted gas price in BNB.
    return formattedGasPriceInBNB;
  }

  String _getValueInBNB(String value) {
    // Get the value in Wei.
    int valueInWei = int.parse(value);

    // Convert the value in Wei to BNB.
    double valueInBNB = valueInWei / 1000000000000000000;

    // Format the value in BNB.
    String formattedValueInBNB = valueInBNB.toStringAsFixed(4);

    // Return the formatted value in BNB.
    return formattedValueInBNB;
  }
}
