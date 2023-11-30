import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/export.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({super.key});

  @override
  State<CreateWallet> createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  int selectedRadioTile1 = 0, selectedRadioTile2 = 0, selectedRadioTile3 = 0;

  @override
  void initState() {
    Get.find<walletController>().getphase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
        width: width(context),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
        height: height(context) * 0.05,
        colors: selectedRadioTile1 == 1 &&
                selectedRadioTile2 == 2 &&
                selectedRadioTile3 == 3
            ? Theme.of(context).primaryColor
            : Theme.of(context).dividerColor,
        onTap: () {
          if (selectedRadioTile1 == 1 &&
              selectedRadioTile2 == 2 &&
              selectedRadioTile3 == 3) {
            Get.toNamed(AppRoute.SecretePhase);
          }
        },
        text: "Continue",
        textcolor: Theme.of(context).hintColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            CustomeAppbar(
              title: "Back up wallet now!",
            ),
            SizedBox(
              height: height(context) * 0.03,
            ),
            CustomImageView(
              imagePath: Appimages.Backupwallet,
              height: height(context) * 0.37,
              width: width(context),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "In the next step you will see Secret phrase(12 words) that allows you to recover a wallet",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(letterSpacing: 0.3)),
            SizedBox(
              height: height(context) * 0.03,
            ),
            RadioListTile(
              value: 1,
              groupValue: selectedRadioTile1,
              onChanged: (value) {
                selectedRadioTile1 = 1;
                setState(() {});
              },
              activeColor: Colors.green,
              tileColor: Theme.of(context).cardColor,
              selectedTileColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "If I lost my secret phrase, my funds will be lost forever.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hoverColor, fontSize: 13),
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            RadioListTile(
              value: 2,
              groupValue: selectedRadioTile2,
              onChanged: (value) {
                selectedRadioTile2 = 2;
                setState(() {});
              },
              activeColor: Colors.green,
              tileColor: Theme.of(context).cardColor,
              selectedTileColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "If I expose or share my secrert phrase to anybody, my funds can get stolen.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hoverColor, fontSize: 13),
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            RadioListTile(
              value: 3,
              groupValue: selectedRadioTile3,
              onChanged: (value) {
                selectedRadioTile3 = 3;
                setState(() {});
              },
              activeColor: Colors.green,
              tileColor: Theme.of(context).cardColor,
              selectedTileColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(
                "It is my full responsibility to keep my  secret phrase secure.",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hoverColor, fontSize: 13),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
