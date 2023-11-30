import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import '../dependencies/i_web3wallet_service.dart';
import '../dependencies/key_service/chain_key.dart';
import '../dependencies/key_service/i_key_service.dart';
import '../utils/dart_defines.dart';
import '../widgets/wc_connection_request/wc_auth_request_model.dart';
import '../widgets/wc_connection_request/wc_connection_request_widget.dart';
import '../widgets/wc_connection_request/wc_session_request_model.dart';
import '../widgets/wc_request_widget.dart/wc_request_widget.dart';

class Web3WalletService extends IWeb3WalletService {
  final IBottomSheetService _bottomSheetHandler =
      GetIt.I<IBottomSheetService>();

  Web3Wallet? _web3Wallet;

  /// The list of requests from the dapp
  /// Potential types include, but aren't limited to:
  /// [SessionProposalEvent], [AuthRequest]
  @override
  ValueNotifier<List<PairingInfo>> pairings =
      ValueNotifier<List<PairingInfo>>([]);
  @override
  ValueNotifier<List<SessionData>> sessions =
      ValueNotifier<List<SessionData>>([]);
  @override
  ValueNotifier<List<StoredCacao>> auth = ValueNotifier<List<StoredCacao>>([]);

  @override
  void create() {
// Create the web3wallet
    _web3Wallet = Web3Wallet(
      core: Core(
        projectId: DartDefines.projectId,
      ),
      metadata: const PairingMetadata(
        name: 'WolfDapp',
        description: 'WolfDapp',
        url: 'pancakeswap.finance/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );

    // Setup our accounts
    List<ChainKey> chainKeys = GetIt.I<IKeyService>().getKeys();
    for (final chainKey in chainKeys) {
      for (final chainId in chainKey.chains) {
        if (chainId.startsWith('kadena')) {
          // print('registering kadena $chainId:${chainKey.publicKey}');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: 'k**${chainKey.publicKey}',
          );
        } else {
          // print('registering other $chainId:${chainKey.publicKey}');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: chainKey.publicKey,
          );
        }
      }
    }

    // Setup our listeners
    print('web3wallet create');
    _web3Wallet!.core.pairing.onPairingInvalid.subscribe(_onPairingInvalid);
    _web3Wallet!.core.pairing.onPairingCreate.subscribe(_onPairingCreate);
    _web3Wallet!.pairings.onSync.subscribe(_onPairingsSync);
    _web3Wallet!.onSessionProposal.subscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.subscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.subscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.subscribe(_onAuthRequest);
  }

  @override
  Future<void> init() async {
    // Await the initialization of the web3wallet
    print('web3wallet init');
    await _web3Wallet!.init();

    pairings.value = _web3Wallet!.pairings.getAll();
    sessions.value = _web3Wallet!.sessions.getAll();
    auth.value = _web3Wallet!.completeRequests.getAll();
  }

  @override
  FutureOr onDispose() {
    print('web3wallet dispose');
    // _web3Wallet!.sessions.delete(auth.value.first.id)
    _web3Wallet!.core.pairing.onPairingInvalid.unsubscribe(_onPairingInvalid);
    _web3Wallet!.pairings.onSync.unsubscribe(_onPairingsSync);
    _web3Wallet!.onSessionProposal.unsubscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.unsubscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.unsubscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.unsubscribe(_onAuthRequest);
  }

  @override
  Web3Wallet getWeb3Wallet() {
    return _web3Wallet!;
  }

  void _onPairingsSync(StoreSyncEvent? args) {
    if (args != null) {
      pairings.value = _web3Wallet!.pairings.getAll();
    }
  }

  void _onSessionProposalError(SessionProposalErrorEvent? args) {
    print("erro ==> " + args.toString());
  }

  void _onSessionProposal(SessionProposalEvent? args) async {
    if (args != null) {
      // print(args);

      // Validate the
      // args.params.

      final Widget w = WCRequestWidget(
        child: WCConnectionRequestWidget(
          wallet: _web3Wallet!,
          sessionProposal: WCSessionRequestModel(
            request: args.params,
          ),
        ),
      );
      final bool? approved = await _bottomSheetHandler.queueBottomSheet(
        widget: w,
      );
//       print('approved: $approved');
//       print("""
//  id: ${args.id},
// namespaces: ${args.params.generatedNamespaces}!
// """);

      if (approved != null && approved) {
        print("Plase wait the tr");
        _web3Wallet!.approveSession(
          id: args.id,
          namespaces: args.params.generatedNamespaces!,
        );
      } else {
        _web3Wallet!.rejectSession(
          id: args.id,
          reason: Errors.getSdkError(
            Errors.USER_REJECTED,
          ),
        );
      }
    }
  }

  void _onPairingInvalid(PairingInvalidEvent? args) {
    print('Pairing Invalid Event: $args');
  }

  void _onPairingCreate(PairingEvent? args) {
    print('Pairing Create Event: $args');
  }

  void _onSessionConnect(SessionConnect? args) {
    if (args != null) {
      print(args);
      sessions.value.add(args.session);
    }
  }

  Future<void> _onAuthRequest(AuthRequest? args) async {
    if (args != null) {
      log('_____args >>$args');

      List<ChainKey> chainKeys = GetIt.I<IKeyService>().getKeysForChain(
        'eip155:56',
      );
      print("args.payloadParams.chainId " +
          args.payloadParams.chainId.toString());
      // Create the message to be signed
      final String iss =
          'did:pkh:eip155:${args.payloadParams.chainId}:${chainKeys.first.publicKey}';

      // print(args);
      final Widget w = WCRequestWidget(
        child: WCConnectionRequestWidget(
          wallet: _web3Wallet!,
          authRequest: WCAuthRequestModel(
            iss: iss,
            request: args,
          ),
        ),
      );
      final bool? auth = await _bottomSheetHandler.queueBottomSheet(
        widget: w,
      );

      if (auth != null && auth) {
        final String message = _web3Wallet!.formatAuthMessage(
          iss: iss,
          cacaoPayload: CacaoRequestPayload.fromPayloadParams(
            args.payloadParams,
          ),
        );

        // EthPrivateKey credentials =
        //     EthPrivateKey.fromHex(chainKeys.first.privateKey);
        // final String sig = utf8.decode(
        //   credentials.signPersonalMessageToUint8List(
        //     Uint8List.fromList(message.codeUnits),
        //   ),
        // );

        final String sig = EthSigUtil.signPersonalMessage(
          message: Uint8List.fromList(message.codeUnits),
          privateKey: chainKeys.first.privateKey,
        );

        await _web3Wallet!.respondAuthRequest(
          id: args.id,
          iss: iss,
          signature: CacaoSignature(
            t: CacaoSignature.EIP191,
            s: sig,
          ),
        );
      } else {
        await _web3Wallet!.respondAuthRequest(
          id: args.id,
          iss: iss,
          error: Errors.getSdkError(
            Errors.USER_REJECTED_AUTH,
          ),
        );
      }
    }
  }
}
