import 'package:flutter/material.dart';

import '../../dependencies/key_service/chain_key.dart';

abstract class IKeyService with ChangeNotifier {
  /// Returns a list of all the keys.
  List<ChainKey> getKeys();
  List<ChainKey> changeKeys();

  /// Returns a list of all the chain ids.
  List<String> getChains();

  /// Returns a list of all the keys for a given chain id.
  /// If the chain is not found, returns an empty list.
  ///  - [chain]: The chain to get the keys for.
  List<ChainKey> getKeysForChain(String chain);

  /// Returns a list of all the accounts in namespace:chainId:address format.
  List<String> getAllAccounts();
}
