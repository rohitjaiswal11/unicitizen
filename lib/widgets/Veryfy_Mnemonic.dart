// ignore_for_file: camel_case_types

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicitizen/Screens/dashboard/dashboard.dart';
import 'dart:ui';

import '../Screens/Graph_screen.dart';
import '../Utility/bottom_navigation.dart';
import '../utils/Colors.dart';
import '../utils/ConstantClass.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';




class Verify_Mnemonic extends StatefulWidget {
  const Verify_Mnemonic({super.key});

  @override
  State<Verify_Mnemonic> createState() => _Verify_MnemonicState();
}

class mylist_data{
  int mimonic_id;
  String mimonic_string;
  bool minomic_bool;
  mylist_data(this.mimonic_id,this.mimonic_string,this.minomic_bool);
}
class _Verify_MnemonicState extends State<Verify_Mnemonic> {
  List<int> selectedIndices = [];
  List<String> selectedItems = [];
  List<String> mimonic = ConstantClass.mnemonic.split(" ");
  bool completea=false;
  bool completeb=false;
  bool completec=false;
  bool complete1=false;
  bool complete2=false;
  bool complete3=false;
  bool complete21=false;
  bool complete22=false;
  bool complete23=false;
  bool complete31=false;
  bool complete32=false;
  bool complete33=false;
  List<mylist_data> mylist =[];
  List other=ConstantClass.mnemonic.split(" ");

  @override
  void initState() {
    createRandomIndicies();
    // TODO: implement initState
    super.initState();
  }

  createRandomIndicies() {
    for(int j=1;j<=mimonic.length;j++){
      mylist.add(mylist_data(j, mimonic[j-1], false));
    }
    List<int> indices = List.generate(12, (index) => index);
    indices.shuffle(); // Shuffle the indices randomly
    for (int i = 0; i < 3; i++) {
      int randomIndex = indices[i];

      selectedIndices.add(randomIndex+1);
      selectedItems.add(mimonic[randomIndex]);


      mylist[randomIndex].minomic_bool=true;
      other.removeWhere((element) => element == selectedItems[i].toString());

    }
    for(int k=0;k<mylist.length;k++){
      print("my real output is${mylist[k].mimonic_id}       ${mylist[k].mimonic_string}        ${mylist[k].minomic_bool}");
    }

    print("Index:????????    "+mylist[selectedIndices[0]-1].mimonic_string.toString());

    // Print the selected indices and items
    // .removeWhere((item) => selectedItems.contains(item));
  }
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight:CustomDimension.myheight(context)/10,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              size: 32, color: ColorsCustom.black)),
      actions: [
        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                right: CustomDimension.myheight(context) / 35),
            child: CustomFonts.text13('Revist', ColorsCustom.orangelight),
          ),
        ),
      ],
      centerTitle: true,
      title: CustomFonts.heading20('Verify Mnemonic', ColorsCustom.black),
    );
    final statusbatheight = MediaQuery.of(context).padding.top;
    final appbarheight = appbar.preferredSize.height;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: (CustomDimension.myheight(context)),
          padding: EdgeInsets.only(left: CustomDimension.mywidth(context) / 20,
              right: CustomDimension.mywidth(context) / 20),
          width: CustomDimension.mywidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: CustomDimension.myheight(context) / 35,),
              CustomFonts.text12(
                  "Please Write down the following words in the correct order.",
                  ColorsCustom.black54),
              SizedBox(height: CustomDimension.myheight(context) / 35,),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: (1 / .4),
                shrinkWrap: true,
                children: List.generate(12, (index) {
                  // print(selectedIndices[index].toString()+" ---------"+index.toString());
                  // print(selectedIndices[index].toString()==(index).toString()?"helloooowowow ":" shweta   ");
                  // for (int i = 0; i < 12; i++)

                  return orangecard(context,
                      height: 15,
                      toppadding: 5,
                      leftpadding: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: ColorsCustom.black12),

                      ),
                      mychild:
                      Center(child: CustomFonts.heading18(mylist[index].mimonic_id.toString(),
                          mylist[index].minomic_bool==true?  Color(0xff150CD1):ColorsCustom.black.withOpacity(0.5)))
                  );
                }),
              ),
              SizedBox(height: CustomDimension.myheight(context) / 35,),
              CustomFonts.text14(
                  "Choose the ${selectedIndices[0].toString()} No. word",
                  ColorsCustom.black),
              SizedBox(height: CustomDimension.myheight(context) / 55,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        completea=true;
                        complete1=true;
                        complete2=false;
                        complete3=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/3.5,
                        toppadding: 5,
                        leftpadding: 15,
                        decoration: BoxDecoration(
                          color: complete1==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),

                        mychild:
                        Center(child: CustomFonts.text14(mylist[selectedIndices[0]-1].mimonic_string.toString(),
                          complete1==true? ColorsCustom.white:ColorsCustom.black,))
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      setState(() {
                        completea=false;
                        complete1=false;
                        complete2=true;
                        complete3=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete2==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[3].toString(),complete2==true? ColorsCustom.white:ColorsCustom.black))
                    ),
                  ), InkWell(
                    onTap: (){
                      setState(() {
                        completea=false;
                        complete1=false;
                        complete2=false;
                        complete3=true;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete3==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[5].toString(),complete3==true? ColorsCustom.white:ColorsCustom.black))
                    ),
                  ),
                ],
              ),
              SizedBox(height: CustomDimension.myheight(context) / 35,),
              CustomFonts.text14(
                  "Choose the ${selectedIndices[1].toString()} No. word",
                  ColorsCustom.black),
              SizedBox(height: CustomDimension.myheight(context) / 55,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        completeb=false;
                        complete21=true;
                        complete22=false;
                        complete23=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete21==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[2].toString(),complete21==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      setState(() {
                        completeb=true;
                        complete21=false;
                        complete22=true;
                        complete23=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete22==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),
                        ),
                        mychild:
                        Center(child: CustomFonts.text14(mylist[selectedIndices[1]-1].mimonic_string.toString(),
                            complete22==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ), InkWell(
                    onTap: (){
                      setState(() {
                        completeb=false;
                        complete21=false;
                        complete22=false;
                        complete23=true;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete23==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[8].toString(),
                            complete23==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ),
                ],
              ),
              SizedBox(height: CustomDimension.myheight(context) / 35,),
              CustomFonts.text14(
                  "Choose the ${selectedIndices[2].toString()} No. word",
                  ColorsCustom.black),
              SizedBox(height: CustomDimension.myheight(context) / 55,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        completec=false;
                        complete31=true;
                        complete32=false;
                        complete33=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete31==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[4].toString(),
                            complete31==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      setState(() {
                        completec=false;
                        complete31=false;
                        complete32=true;
                        complete33=false;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete32==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild:
                        Center(child: CustomFonts.text14(other[6].toString(),
                            complete32==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ), InkWell(
                    onTap: (){
                      setState(() {
                        completec=true;
                        complete31=false;
                        complete32=false;
                        complete33=true;
                      });
                    },
                    child: orangecard(context,
                        height: CustomDimension.myheight(context)/20,
                        width: CustomDimension.mywidth(context)/4,
                        toppadding: 5,
                        leftpadding: 5,
                        decoration: BoxDecoration(
                          color: complete33==true? Color(0xff150CD1):ColorsCustom.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: ColorsCustom.black12),

                        ),
                        mychild: Center(child: CustomFonts.text14(mylist[selectedIndices[2]-1].mimonic_string.toString(),
                            complete33==true?ColorsCustom.white:ColorsCustom.black))
                    ),
                  ),
                ],
              ),
              SizedBox(height: CustomDimension.myheight(context) / 35,),
            ],
          ),

        ),
      ),

      bottomSheet:  Container(
        color: ColorsCustom.white.withOpacity(0.8),
        padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            
           BottomNavBar()
            
            // Garph_Screen()
             
             
             
             ));
          },

          child: orangecard(context,
            height: CustomDimension.myheight(context) / 15,
            width: CustomDimension.myheight(context),
            toppadding: 10,
            leftpadding: 10,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                colors: [
                  Color(0xff181309),
                  Color(0xff181309),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            mychild: Center(child: CustomFonts.text15(
                "Complete", ColorsCustom.white)),
          ),
        ),
      ),

    );
  }


  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: ColorsCustom.white,
              shadowColor: ColorsCustom.grey,

              insetPadding: const EdgeInsets.symmetric(horizontal: 0),
              contentPadding: const EdgeInsets.all(20),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cancel_outlined,color: ColorsCustom.redbutton,size: 50,),
                  SizedBox(height: 15,),
                  CustomFonts.heading18("Wrong Order Please",ColorsCustom.black),
                  CustomFonts.heading16("Try again.",ColorsCustom.black),
                ],
              ),
              //   title: CustomFonts.heading16("Filter",ColorsCustom.black),
              actions: <Widget>[
                InkWell(
                  child: Center(
                    child: Container(
                      width: CustomDimension.mywidth(context)/3,
                      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                      decoration: BoxDecoration(
                        color: ColorsCustom.redbutton,
                        border: Border.all(color: ColorsCustom.black12),

                        boxShadow:  const [
                          BoxShadow(
                            color: Colors.grey,

                          )
                        ],
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Center(child: CustomFonts.text15("Okay", ColorsCustom.white)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();

                  },
                ),

              ],
            );
          });
        });
  }


}
