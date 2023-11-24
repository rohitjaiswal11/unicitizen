
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';



import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';
import '../widgets/AboutPrivate_key.dart';
import '../widgets/About_Mnemonic.dart';
import '../widgets/Backup_History.dart';
import '../widgets/ChangeWalletNamePage.dart';
import '../widgets/Change_Password.dart';
import '../widgets/Select_Wallet.dart';

class WalletDetailsPage extends StatefulWidget {
  const WalletDetailsPage({super.key});

  @override
  State<WalletDetailsPage> createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getdontShow();
  }

     getdontShow () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
       ConstantClass.DontShowkeystore = await prefs.getBool('DontShowkeystore')!;
       ConstantClass.DontShowprivate = await prefs.getBool('DontShowprivate')!;
       ConstantClass.DontShowmnemonic = await prefs.getBool('DontShowmnemonic')!;


     print("""""""""""""""""""""'object'""""""""""""""""""""");
     print( ConstantClass.DontShowkeystore.toString() + ConstantClass.DontShowprivate.toString() + ConstantClass.DontShowmnemonic.toString());

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff28256a),
        appBar: AppBar(
          backgroundColor:  const Color(0xff28256a),
          toolbarHeight: CustomDimension.myheight(context)/10,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading:  InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, size: 32, color: Colors.white)),
          title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomFonts.heading20('Wallet Details', Colors.white)),
          actions: [
            Padding(
              padding: EdgeInsets.only(right:  CustomDimension.mywidth(context) / 20),
              child: CustomFonts.text12(ConstantClass.Network.toString(), ColorsCustom.orangelight),
            ),

          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            // height: CustomDimension.myheight(context),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff28256a),
                  Color(0xff0e093c),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: CustomDimension.myheight(context)/50,),
                Padding(
                  padding: EdgeInsets.symmetric(
                  horizontal: CustomDimension.mywidth(context) / 20),
                  child: orangecard(
                    context,
                    toppadding: CustomDimension.myheight(context) / 35,
                    leftpadding: CustomDimension.mywidth(context) / 25,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffeeb954),
                          Color(0xfff59141),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    mychild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomFonts.heading18(ConstantClass.Name.toString(), ColorsCustom.white),
                            SizedBox(width: CustomDimension.mywidth(context)* 0.03),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeWalletNamePage()));
                              },
                              child: CustomImages.setAssetImage(
                                CustomImages.editText,
                                height: 15,
                                width: 15,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Select_Wallet()));
                              },
                              child: CustomImages.setAssetImage(
                                CustomImages.exchange,
                                height: 15,
                                width: 15,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: CustomDimension.myheight(context)* 0.015),
                           Row(
                            children: [
                              Container(
                                width: CustomDimension.mywidth(context)/2,
                                child: CustomFonts.text13(
                                    ConstantClass.fakewallet.toString(),
                                    ColorsCustom.white),
                              ),
                              SizedBox(width: CustomDimension.mywidth(context)* 0.01),
                              InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text:ConstantClass.fakewallet.toString())).then((value) => ConstantClass.showToast("Copied",duration: Toast.lengthShort));
                                  },
                                  child: const Icon(Icons.copy, color: Colors.white, size: 15))
                            ],
                        ),
                        SizedBox(height: CustomDimension.myheight(context)* 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white24),
                              child: CustomFonts.text10(
                                  'Path: m/44/4554/5445', ColorsCustom.white),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Change_Password()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomImages.setAssetImage(
                                      CustomImages.editText,
                                      height: 12,
                                      width: 12,
                                      fit: BoxFit.fill,
                                    ),
                                    CustomFonts.text10(
                                        'Change Password', ColorsCustom.white),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: CustomDimension.myheight(context)* 0.015),
                Padding(
                  padding: EdgeInsets.only(
                      left: CustomDimension.mywidth(context) / 20,
                      right: CustomDimension.mywidth(context) / 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      CustomImages.setAssetImage(
                        CustomImages.question,
                        height: 12,
                        width: 12,
                        color: ColorsCustom.white54
                      ),
                      const SizedBox(width: 10),
                      CustomFonts.text10('Related Wallet(s): 0', Colors.white),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios,
                          size: 15, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(height: CustomDimension.myheight(context)* 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomDimension.mywidth(context) / 20),
                  child: orangecard(context,
                      toppadding: CustomDimension.myheight(context) / 80,
                      leftpadding: CustomDimension.myheight(context) / 35,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: ColorsCustom.white24,
                      ),
                      mychild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                ConstantClass.DontShowprivate==false?  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutPrivate_Key())):
                                  ConstantClass.enterPassword(context, false,false, 0);
                                },
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  CustomImages.Customimg(
                                      context, CustomImages.key,scale: 3.5),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomFonts.text12400(
                                      "Back Up\nPrivate Key", ColorsCustom.white),
                                ]),
                              ),
                              SizedBox(
                                  height: CustomDimension.myheight(context)* 0.08,
                                  child: const VerticalDivider(
                                    color: Colors.white24,
                                  )),
                              // InkWell(
                              //   onTap: () {
                              //     ConstantClass.DontShowkeystore==false?  Navigator.of(context).push(MaterialPageRoute(
                              //         builder: (context) => const KeyStore())):
                              //     ConstantClass.enterPassword(context, false, 1);
                              //   },
                              //   child: Column(children: [
                              //     CustomImages.Customimg(
                              //         context, CustomImages.write,scale: 3.2),
                              //     const SizedBox(
                              //       height: 10,
                              //     ),
                              //     CustomFonts.text10("Back Up \nKey Store",
                              //         ColorsCustom.white),
                              //   ]),
                              // ),
                              // SizedBox(
                              //     height: CustomDimension.myheight(context)* 0.08,
                              //     child: const VerticalDivider(
                              //       color: Colors.white24,
                              //     )),
                              InkWell(
                                onTap: () {
                                  ConstantClass.DontShowmnemonic==false? Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                      const About_Mnemonic())):
                                  ConstantClass.enterPassword(context, false,false, 2);
                                },
                                child: Column(children: [
                                  CustomImages.Customimg(
                                      context, CustomImages.page,scale: 3.8),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomFonts.text12400(
                                      "Back Up \nMnemonic", ColorsCustom.white),
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Backup_History()));

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomFonts.text12400(
                                    'View Backup History', Colors.blue.shade300),
                                // SizedBox(width: CustomDimension.mywidth(context)* 0.02),
                                Icon(Icons.arrow_forward_ios,
                                    size: 9, color: Colors.blue.shade300)
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: CustomDimension.myheight(context)* 0.02),
                orangecard(
                  context,
                  height: CustomDimension.myheight(context)*0.662,
                  toppadding: CustomDimension.myheight(context) / 55,
                  leftpadding: 0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffffffff),
                        Color(0xffffffff),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  mychild: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CustomDimension.mywidth(context)* 0.001,
                              vertical: CustomDimension.myheight(context)* 0.01),
                          child: Column(
                            children: [
                              customCard(CustomDimension.mywidth(context), CustomDimension.myheight(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: CustomDimension.mywidth(context)* 0.035,
                                      vertical: CustomDimension.myheight(context)* 0.025),
                                  cardItemsList: [
                                    CustomCardItem(
                                        imagePath: CustomImages.accountKey,
                                        title: 'Permission'),
                                    CustomCardItem(
                                        imagePath: CustomImages.accountApprove,
                                        title: 'Approval Management',
                                        subTitle:
                                            'View your approval Contacts'),
                                  ]),
                              SizedBox(height: CustomDimension.myheight(context)* 0.01),
                              customCard(CustomDimension.mywidth(context), CustomDimension.myheight(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: CustomDimension.mywidth(context)* 0.035,
                                      vertical: CustomDimension.myheight(context)* 0.025),
                                  cardItemsList: [
                                    CustomCardItem(
                                        imagePath: CustomImages.moneyRound,
                                        title: 'Multising Transaction',
                                        subTitle:
                                            'Request or process multising transaction'),
                                  ]),
                              SizedBox(height: CustomDimension.myheight(context)* 0.01),
                              customCard(CustomDimension.mywidth(context), CustomDimension.myheight(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: CustomDimension.mywidth(context)* 0.035,
                                      vertical: CustomDimension.myheight(context)* 0.025),
                                  cardItemsList: [
                                    CustomCardItem(
                                        imagePath: CustomImages.link,
                                        title: 'Connections'),
                                  ]),
                            ],
                          ),
                        ),
                        SizedBox(height: CustomDimension.myheight(context)* 0.005),
                        InkWell(
                          onTap: (){
                            ConstantClass.enterPassword(context, true,false, 3);


                          },
                          child: Container(
                            width: CustomDimension.mywidth(context),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: ColorsCustom.white,
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, blurRadius: 0.3)
                              ],
                            ),
                            child: Center(
                              child: CustomFonts.text14(
                                  'Delete Wallet', ColorsCustom.red),
                            ),
                          ),
                        ),
                        // SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }


  Future<void> View(BuildContext context) async {
    ToastContext().init(context);
    return await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                scrollable: true,
                backgroundColor: ColorsCustom.white,
                shadowColor: ColorsCustom.white,
                insetPadding: EdgeInsets.zero,
                // insetPadding:  EdgeInsets.all(15),
                contentPadding: EdgeInsets.zero,
                content: Form(
                    key: _formKey,
                    child: Container(
                      height: CustomDimension.myheight(context),
                      width: CustomDimension.mywidth(context),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                             Container(
                               height: CustomDimension.myheight(context) / 7,
                               padding: EdgeInsets.only(
                                   top: CustomDimension.myheight(context) / 70,
                                   left: CustomDimension.mywidth(context) / 30,
                                   right: CustomDimension.mywidth(context) / 30),
                               alignment: Alignment.center,
                               decoration: BoxDecoration(
                                   borderRadius: const BorderRadius.only(
                                       bottomLeft: Radius.circular(20),
                                       bottomRight: Radius.circular(20)),
                                   gradient: LinearGradient(
                                       colors: [
                                         ColorsCustom.darkPurple,
                                         ColorsCustom.lightPurple
                                       ],
                                       begin: Alignment.bottomLeft,
                                       end: Alignment.topRight)),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   InkWell(
                                       onTap: () {
                                         Navigator.pop(context);
                                       },
                                       child: const Icon(Icons.arrow_back,
                                           size: 32, color: Colors.white)),
                                   SizedBox(
                                       width:
                                       CustomDimension.mywidth(context) / 4.8),
                                   CustomFonts.heading20(
                                       'Back Up Mnemonic', Colors.white),
                                 ],
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(
                                   top: CustomDimension.myheight(context) / 30,
                                   left: CustomDimension.mywidth(context) / 20,
                                   right: CustomDimension.mywidth(context) / 20),
                               child: CustomFonts.text13(
                                   "Please Write down the following words in the correct\n order.",
                                   ColorsCustom.black),
                             ),
                             SizedBox(
                               height: CustomDimension.myheight(context) / 8,
                             ),
                             Center(
                                 child: CustomImages.Customimg(
                                     context, CustomImages.backupPrivatekey,scale: 1.6)),
                             SizedBox(
                               height: CustomDimension.myheight(context) / 20,
                             ),
                             Center(
                                 child: CustomFonts.text12(
                                     "Anyone with your mnemonic can access all your\n assets. Please keep the information to yourself.",
                                     ColorsCustom.black.withOpacity(0.6))),
                             SizedBox(
                               height: CustomDimension.myheight(context) / 20,
                             ),
                             InkWell(
                               child: Center(
                                 child: Container(
                                   width: CustomDimension.mywidth(context) / 2.2,
                                   padding: const EdgeInsets.only(
                                       top: 15, bottom: 15, right: 20, left: 20),
                                   decoration: BoxDecoration(
                                       boxShadow: const [
                                         BoxShadow(
                                           color: Colors.grey,
                                         )
                                       ],
                                       borderRadius: BorderRadius.circular(5),
                                       gradient: const LinearGradient(
                                         begin: Alignment.topCenter,
                                         end: Alignment.bottomCenter,
                                         colors: [
                                           Color(0xff6E68EF),
                                           Color(0xff150CD1),
                                         ],
                                       )),
                                   child: Center(
                                       child: CustomFonts.text15(
                                           "View Mnemonic", ColorsCustom.white)),
                                 ),
                               ),
                               onTap: () {
                                 if (_formKey.currentState!.validate()) {
                                   // Do something like updating SharedPreferences or User Settings etc.

                                   // enterPassword(context,false);

                                 }
                               },
                             ),

                            SizedBox(
                              height: CustomDimension.myheight(context) / 12,
                            ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: CustomDimension.myheight(context) / 30,
                                    left: CustomDimension.mywidth(context) / 20,
                                    right: CustomDimension.mywidth(context) / 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImages.Customimg(
                                        context, CustomImages.warning,scale: 2.0,
                                        color: ColorsCustom.orangelight),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CustomFonts.Text12(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.",
                                        ColorsCustom.black54),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: CustomDimension.myheight(context) / 30,
                                    left: CustomDimension.mywidth(context) / 20,
                                    right: CustomDimension.mywidth(context) / 20),
                                child: InkWell(
                                  child: Container(
                                    width: CustomDimension.mywidth(context),
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15, right: 20, left: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffC1C1C1),
                                    ),
                                    child: Center(
                                        child: CustomFonts.text15(
                                            "Already Backed Up",
                                            ColorsCustom.white)),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(
                                height: CustomDimension.myheight(context) / 20,
                              ),

                          ],
                        ),
                      ),
                    )),
              ),
            );
          });
        });
  }

}
