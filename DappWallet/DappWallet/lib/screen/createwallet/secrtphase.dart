import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/services.dart';

class secretePhase extends StatefulWidget {
  const secretePhase({super.key});

  @override
  State<secretePhase> createState() => _secretePhaseState();
}

class _secretePhaseState extends State<secretePhase> {
  List phases = [];
  var _instance = Get.find<walletController>();
  @override
  void initState() {
    phases.addAll(_instance.seedphases);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
        width: width(context),
        margin: EdgeInsets.only(bottom: 15, left: 8, right: 8),
        height: height(context) * 0.05,
        colors: Theme.of(context).primaryColor,
        onTap: () {
          Get.toNamed(AppRoute.secretPhase_Match);
        },
        text: "Continue",
        textcolor: Theme.of(context).hintColor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(children: [
          CustomeAppbar(
            title: "Your secret phrase",
          ),
          SizedBox(
            height: height(context) * 0.02,
          ),
          Text(
            "Tap the words to put them next to the each other in the correct order",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(
            height: height(context) * 0.05,
          ),
          Container(
              width: width(context),
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.07),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    phases.length,
                    (int index) => secretChip(
                        width(context), height(context), index, phases),
                  ))),
          SizedBox(
            height: height(context) * 0.05,
          ),
          CustomButton(
            width: width(context) * 0.3,
            roundradius: 5,
            height: 30,
            colors: Theme.of(context).primaryColor,
            onTap: () async {
              print(phases.join(" "));
              await Clipboard.setData(ClipboardData(text: phases.join(" ")));
              showCustomSnackBar(
                  message: "Your secret phase's copy.", isError: false);
            },
            text: "Copy",
            textcolor: Theme.of(context).hintColor,
          ),
          SizedBox(
            height: height(context) * 0.05,
          ),
          Container(
            width: width(context),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Theme.of(context).cardColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "Reminder!!",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  Text(
                    "Do not share your secret phrase!",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: height(context) * 0.01,
                  ),
                  Text(
                    "If someone has your secret phrase. they will have full control of your wallet.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).hoverColor,
                        //fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget secretChip(double width, double height, int i, data) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.015, vertical: height * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${i + 1}.',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
          Text(
            ' ${data[i]}',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
