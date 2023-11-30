import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import '../dependencies/i_web3wallet_service.dart';
import '../utils/constants.dart';
import '../widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget with GetItStatefulWidgetMixin {
  AppsPage({
    Key? key,
  }) : super(key: key);

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with GetItStateMixin {



  final Web3Wallet web3Wallet = GetIt.I<IWeb3WalletService>().getWeb3Wallet();

  @override
  void initState() {
    // web3wallet.onSessionDelete.subscribe(_onSessionDelete);
    // web3Wallet.core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    // web3Wallet.core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    super.initState();
  }

  @override
  void dispose() {
    // web3wallet.onSessionDelete.unsubscribe(_onSessionDelete);
    // web3Wallet.core.pairing.onPairingDelete.unsubscribe(_onPairingDelete);
    // web3Wallet.core.pairing.onPairingExpire.unsubscribe(_onPairingDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 

    return Stack(
      children: [
                Positioned(
          bottom: StyleConstants.magic20,
          right: StyleConstants.magic20,
          child: Row(
            children: [
              // Disconnect buttons for testing
              _buildIconButton(
                Icons.discord,
                () {
                  web3Wallet.core.relayClient.disconnect();
                },
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
              _buildIconButton(
                Icons.connect_without_contact,
                () {
                  web3Wallet.core.relayClient.connect();
                },
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
              _buildIconButton(
                Icons.copy,
                _onCopyQrCode,
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
             
            ],
          ),
        ),
      ],
    );
  }

   Widget _buildIconButton(IconData icon, void Function()? onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.primaryColor,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear48,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: StyleConstants.titleTextColor,
        ),
        iconSize: StyleConstants.linear24,
        onPressed: onPressed,
      ),
    );
  }

  Future _onCopyQrCode() async {
    final String? uri = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return UriInputPopup();
      },
    );

    // print(uri);

    _onFoundUri(uri);
  }



  Future _onFoundUri(String? uri) async {
    if (uri != null) {
      try {
        final Uri uriData = Uri.parse(uri);
        await web3Wallet.pair(
          uri: uriData,
        );
      } catch (e) {
        // _invalidUriToast();
      }
    } else {
      // _invalidUriToast();
    }
  }

  // void _invalidUriToast() {
  //   showToast(
  //     child: Container(
  //       padding: const EdgeInsets.all(StyleConstants.linear8),
  //       margin: const EdgeInsets.only(
  //         bottom: StyleConstants.magic40,
  //       ),
  //       decoration: BoxDecoration(
  //         color: StyleConstants.errorColor,
  //         borderRadius: BorderRadius.circular(
  //           StyleConstants.linear16,
  //         ),
  //       ),
  //       child: const Text(
  //         StringConstants.invalidUri,
  //         style: StyleConstants.bodyTextBold,
  //       ),
  //     ),
  //     context: context,
  //   );
  // }

 

}
