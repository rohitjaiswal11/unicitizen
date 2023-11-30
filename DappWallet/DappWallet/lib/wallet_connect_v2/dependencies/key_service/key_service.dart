import 'package:dappwallet/data/base/Contant.dart';

import '../../dependencies/key_service/chain_key.dart';
import '../../dependencies/key_service/i_key_service.dart';

class KeyService extends IKeyService {
  List<ChainKey> keys = [
    // ChainKey(
    //   chains: [
    //     'kadena:mainnet01',
    //     'kadena:testnet04',
    //     'kadena:development',
    //   ],
    //   privateKey: DartDefines.kadenaPrivateKey,
    //   publicKey: DartDefines.kadenaPublicKey,
    // ),
    ChainKey(
      chains: [
        'eip155:1',
        // 'eip155:56',
        'eip155:56',
        'eip155:5',
        'eip155:137',
        'eip155:80001',
      ],
      privateKey: pvtkey,
      publicKey: walletadddres, // Eth Address, not actual public key
    )
  ];

  @override
  List<String> getChains() {
    final List<String> chainIds = [];
    for (final ChainKey key in keys) {
      chainIds.addAll(key.chains);
    }
    return chainIds;
  }

  @override
  List<ChainKey> getKeys() {
    return keys;
  }

  @override
  List<ChainKey> changeKeys() {
    notifyListeners();
    return keys;
  }

  @override
  List<ChainKey> getKeysForChain(String chain) {
    return keys.where((e) => e.chains.contains(chain)).toList();
  }

  @override
  List<String> getAllAccounts() {
    final List<String> accounts = [];
    for (final ChainKey key in keys) {
      for (final String chain in key.chains) {
        accounts.add('$chain:${key.publicKey}');
      }
    }
    return accounts;
  }
}
