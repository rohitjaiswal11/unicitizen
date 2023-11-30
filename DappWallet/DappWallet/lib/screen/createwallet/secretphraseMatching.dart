import 'dart:async';

import 'package:dappwallet/data/Controller/walletController.dart';
import 'package:dappwallet/utils/export.dart';
import 'package:flutter/services.dart';

class SecretPhase_Match extends StatefulWidget {
  const SecretPhase_Match({super.key});

  @override
  State<SecretPhase_Match> createState() => _SecretPhase_MatchState();
}

class _SecretPhase_MatchState extends State<SecretPhase_Match> {
  List phases = [];
  List selectPhase = [];
  bool _loading = false;
  @override
  void initState() {
    phases.addAll(Get.find<walletController>().seedphases);
    phases.shuffle();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _loading
          ? ButtonProcess(
              height: 30,
              width: 30,
            )
          : CustomButton(
              width: width(context),
              margin: EdgeInsets.only(bottom: 15, left: 8, right: 8),
              height: height(context) * 0.05,
              colors: selectPhase.length == 12
                  ? Theme.of(context).primaryColor
                  : AppColor.lightbluecolors,
              onTap: () {
                //Get.toNamed(AppRoute.bottomNavigationBar);
                _loading = true;
                setState(() {});
                Timer(Duration(seconds: 2), () {
                  if (selectPhase.length == 12) {
                    if (
                      
                      listEquals(
                        Get.find<walletController>().seedphases, selectPhase)) {
                      String phs = selectPhase.join(" ");
                      Get.find<walletController>()
                          .genrateaddress(phs, "")
                          .then((value) {
                        if (value) {
                          showCustomSnackBar(
                              message: "Wallet create Successfully.");
                          Get.toNamed(AppRoute.bottomNavigationBar);
                        } else {
                          showCustomSnackBar(
                              message: "Error in address", isError: false);
                        }
                      });
                    }
                    
                    
                     else {
                      showCustomSnackBar(
                          message: "Phrase not matched....", isError: true);
                    }
                    _loading = false;
                    setState(() {});
                  }
                  
                  
                  
                   else {
                    _loading = false;
                    setState(() {});
                    showCustomSnackBar(
                        message: "Select all the Words...", isError: true);
                  }
                });
              },
              text: "Done",
              textcolor: Theme.of(context).hintColor,
            ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(children: [
          CustomeAppbar(
            title: "Verify Secret phrase",
          ),
          SizedBox(
            height: height(context) * 0.02,
          ),
          Text(
            "Tap the words to put them next to the each other in the correct order",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: height(context) * 0.05,
          ),
          Container(
              width: width(context),
              height: height(context) * 0.3,
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.07),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    phases.length,
                    (int index) => InkWell(
                      onTap: () {
                        selectPhase.add(phases[index]);
                        phases.removeAt(index);
                        setState(() {});
                      },
                      child: secretChip(
                          width(context), height(context), index, phases),
                    ),
                  ))),
          SizedBox(
            height: height(context) * 0.04,
          ),
          Container(
              width: width(context),
              height: height(context) * 0.3,
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.07),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    12,
                    (int i) => InkWell(
                      onTap: () {
                        phases.add(selectPhase[i]);
                        selectPhase.removeAt(i);
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.015,
                            vertical: height(context) * 0.01),
                        padding: EdgeInsets.symmetric(
                            horizontal: width(context) * 0.02,
                            vertical: height(context) * 0.01),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            selectPhase.length < i + 1
                                ? Text(
                                    '${i + 1}    ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color),
                                  )
                                : Text(
                                    ' ${selectPhase[i]}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: 14),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ))),
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
