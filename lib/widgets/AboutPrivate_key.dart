import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';



class AboutPrivate_Key extends StatefulWidget {
  const AboutPrivate_Key({super.key});

  @override
  State<AboutPrivate_Key> createState() => _AboutPrivate_KeyState();
}

class _AboutPrivate_KeyState extends State<AboutPrivate_Key> {
  bool show=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController password_controller = TextEditingController();
   String? title="About Private Key";


  Future<void> dontShow (bool show) async {
    if(show==true){
      ConstantClass.DontShowprivate=show;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('DontShowprivate', ConstantClass.DontShowprivate!);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button
         toolbarHeight: CustomDimension.myheight(context)/10,
        leading:   InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                size: 32, color: Colors.white)),
        centerTitle: true,
        title: CustomFonts.heading20(title.toString(), Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors:[ColorsCustom.darkPurple, ColorsCustom.lightPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          height: CustomDimension.myheight(context)/1.15,
          padding:  EdgeInsets.symmetric(horizontal: CustomDimension.mywidth(context)/20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: CustomDimension.myheight(context)/40,),
                  CustomFonts.heading16500("What is private Key?", ColorsCustom.black),
                  SizedBox(height:10),
                  CustomFonts.text12("Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et doloremagna aliqua. Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit involuptate velit esse cillum dolore eu fugiat nulla pariatur.",ColorsCustom.black38 ),
                  SizedBox(height: CustomDimension.myheight(context)/30,),
                  orangecard(context,
                      toppadding: CustomDimension.myheight(context)/55,
                      leftpadding: CustomDimension.mywidth(context)/25,
                      decoration:    BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(CustomImages.backgroundprivatekey),
                            scale: 1.6
                        ),
                        borderRadius:BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: ColorsCustom.grey.withOpacity(0.4)),),
                      mychild:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFonts.heading16500("How to keep it Secure?", ColorsCustom.black),
                          SizedBox(height:10),

                          ListTile(contentPadding: EdgeInsets.zero,
                            leading: CustomImages.Customimg(context, CustomImages.coldwallet,scale: 1.6),
                            title: CustomFonts.text12("Write it downor store it in an offline device\n such as a cold wallet.",ColorsCustom.black ),
                          ), SizedBox(height:10),

                          ListTile(contentPadding: EdgeInsets.zero,
                            leading: CustomImages.Customimg(context, CustomImages.screenshot,scale: 1.6),
                            title: CustomFonts.text12("Never store it by taking screenshot.",ColorsCustom.black ),
                          ), SizedBox(height:10),

                          ListTile(contentPadding: EdgeInsets.zero,
                            leading: CustomImages.Customimg(context, CustomImages.coldwallet,scale: 1.6),
                            title: CustomFonts.text12("Never store it in social media apps,emails,\n mobile memos,cloud services, etc.",ColorsCustom.black ),
                          ),

                        ],
                      )),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          checkColor: ColorsCustom.white,
                          activeColor: Color(0xff150CD1),
                          value: show,
                          side: BorderSide(
                            // ======> CHANGE THE BORDER COLOR HERE <======
                            color: Colors.grey,
                            // Give your checkbox border a custom width
                            width: 1.5,
                          ),
                          onChanged: (checked) {
                            setState(() {
                              show = checked!;
                            });
                            dontShow(show);
                          }),
                      CustomFonts.text12("Don't show this again",ColorsCustom.black38),
                    ],
                  ) ,
                ],
              ),
              // SizedBox(height: CustomDimension.myheight(context)/3.5,),


          ]),
        ),
      ),
    bottomSheet:   Container(
      color: ColorsCustom.white.withOpacity(0.8),
      padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: InkWell(
        onTap: (){
          ConstantClass.enterPassword(context, false,false, 0);

        },
        child: orangecard(context,
          height: CustomDimension.myheight(context)/15,
          width: CustomDimension.myheight(context),
          toppadding: 10,
          leftpadding: 10,
          decoration:   const BoxDecoration(
            borderRadius:BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: [
                Color(0xff6E68EF),
                Color(0xff150CD1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          mychild: Center(child: CustomFonts.text15("View Private Key", ColorsCustom.white)),
        ),
      ),
    ),
    );
  }



  // Future<void> showInformationDialog(BuildContext context) async {
  //   return await showDialog(
  //       useSafeArea: true,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             backgroundColor: ColorsCustom.white,
  //             shadowColor: ColorsCustom.grey,
  //
  //             insetPadding: const EdgeInsets.symmetric(horizontal: 0),
  //             contentPadding: const EdgeInsets.all(20),
  //             content: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     CustomFonts.heading16("Enter Password",ColorsCustom.black),
  //                     SizedBox(height: 10,),
  //                     orangecard(context,
  //                       toppadding: CustomDimension.myheight(context)/150,
  //                       leftpadding: CustomDimension.myheight(context)/35,
  //                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
  //                       border: Border.all(color: ColorsCustom.black12)
  //                       ),
  //                       mychild: TextFormField(
  //                         controller: password_controller,decoration:InputDecoration(
  //                         border: InputBorder.none,
  //                         // hintText: "Enter the token's contract address",
  //                         // hintStyle:  TextStyle(
  //                         //   color: ColorsCustom.black38,
  //                         //   fontSize: 14,
  //                         //   fontFamily: 'Poppins',
  //                         //   fontWeight: FontWeight.w400,
  //                         //
  //                         // ),
  //                         labelStyle: TextStyle(
  //                           color: ColorsCustom.black,
  //                           fontSize: 14,
  //                           fontFamily: 'Poppins',
  //                           fontWeight: FontWeight.w500,
  //
  //                         ),
  //
  //                       ),
  //
  //
  //
  //                       ),
  //                     ),
  //                     SizedBox(height: 10,),
  //                   ],
  //                 )),
  //             //   title: CustomFonts.heading16("Filter",ColorsCustom.black),
  //             actions: <Widget>[
  //
  //               InkWell(
  //                 child: Container(
  //                   width: CustomDimension.mywidth(context)/3.2,
  //                   padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: ColorsCustom.black12),
  //                     borderRadius: BorderRadius.circular(5),
  //
  //                   ),
  //                   child: Center(child: CustomFonts.text15("Cancel", ColorsCustom.black)),
  //                 ),
  //                 onTap: () {
  //                   if (_formKey.currentState!.validate()) {
  //                     password_controller.clear();
  //                     // Do something like updating SharedPreferences or User Settings etc.
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               ),
  //               InkWell(
  //                 child: Container(
  //                   width: CustomDimension.mywidth(context)/3.2,
  //                   padding: const EdgeInsets.only(top: 15,bottom: 15,right: 20,left: 20),
  //                   decoration: BoxDecoration(
  //                       boxShadow:  const [
  //                         BoxShadow(
  //                           color: Colors.grey,
  //                         )
  //                       ],
  //                       borderRadius: BorderRadius.circular(5),
  //                       gradient: const LinearGradient(
  //                         begin: Alignment.topCenter,
  //                         end: Alignment.bottomCenter,
  //                         colors: [
  //                           Color(0xff6E68EF),
  //                           Color(0xff150CD1),
  //                         ],
  //                       )
  //                   ),
  //                   child: Center(child: CustomFonts.text15("Confirm", ColorsCustom.white)),
  //                 ),
  //                 onTap: () {
  //                   if (_formKey.currentState!.validate()) {
  //                     // Do something like updating SharedPreferences or User Settings etc.
  //                     password_controller.clear();
  //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const View_Key()));
  //
  //                   }
  //                 },
  //               ),
  //             ],
  //           );
  //
  //         });
  //       });
  // }

}
