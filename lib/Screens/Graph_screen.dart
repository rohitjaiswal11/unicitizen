import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:unicitizen/Screens/profile.dart';

// Import other utility classes
import '../utils/Colors.dart';
import '../utils/CustomCard.dart';
import '../utils/CustomImages.dart';
import '../utils/Dimensions.dart';
import '../utils/Fonts.dart';

class Garph_Screen extends StatefulWidget {
  const Garph_Screen({super.key});

  @override
  State<Garph_Screen> createState() => _Garph_ScreenState();
}

class _Garph_ScreenState extends State<Garph_Screen> {
  bool toggleValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomDimension.myheight(context) / 9,
        leading: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context) / 35),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 32, color: ColorsCustom.black),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: CustomDimension.myheight(context) / 35),
          child:
              CustomFonts.heading20('Binance USD (BUSD)', ColorsCustom.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: CustomDimension.mywidth(context) / 20,
            right: CustomDimension.mywidth(context) / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: CustomDimension.myheight(context) / 20),
                CustomFonts.text12("USD", ColorsCustom.black),
                SizedBox(height: CustomDimension.mywidth(context) / 25),
                CustomFonts.text18("  0.99965", ColorsCustom.black),
                Spacer(),
                Column(
                  children: [
                    SizedBox(),
                    CustomFonts.text12("ATH: 1.15", ColorsCustom.black),
                    SizedBox(),
                    CustomFonts.text14("-0.06344%", ColorsCustom.red),
                  ],
                )
              ],
            ),
            CustomImages.Customimg(context, CustomImages.graph, scale: 1.8),
            SizedBox(height: CustomDimension.myheight(context) / 100),
            Row(
              children: [
                CustomFonts.text10("12H", ColorsCustom.black,),
                Spacer(),
                CustomFonts.text10("1D", ColorsCustom.black),
                Spacer(),
                CustomFonts.text10("7D", ColorsCustom.black),
                Spacer(),
                CustomFonts.text10("1M", ColorsCustom.black),
                Spacer(),
                CustomFonts.text10("1Y", ColorsCustom.black),
              ],
            ),
            Row(
              children: [
                SizedBox(height: CustomDimension.myheight(context) / 15),
                CustomFonts.text14("Price Alert", ColorsCustom.black),
                Spacer(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) {
                    final scale = Tween<double>(begin: 1, end: 0.8).animate(animation);
                    return ScaleTransition(scale: scale, child: child);
                  },
                  child: GFToggle(
                    onChanged: (val) {
                      setState(() {
                        toggleValue = val!;
                      });
                    },
                    value: toggleValue,
                    type: GFToggleType.ios,
                    disabledThumbColor: Colors.white,
                    disabledTrackColor: Colors.green,
                    enabledThumbColor: Colors.white,
                    enabledTrackColor: Color(0xff009FD4),
                    // icon: Icon(Icons.star, size: 30), // Set the icon size here
                  ),
                ),

              ],
            ),
            SizedBox(height: CustomDimension.myheight(context) / 200),
            CustomFonts.text12(
              "Binance USD (BUSD) is a stable coin pegged to USD that\n"
              "has received approval from the New York State Department\n"
              "of Financial Services (NYDFS). BUSD will be available\n"
              "for direct purchase and redemption at a rate of 1 BUSD = 1 \n USD",
              ColorsCustom.black.withOpacity(0.5),
            ),
            SizedBox(height: CustomDimension.myheight(context) / 35),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13("Website", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text13(
                        "https://www.paxos.co...", Color(0xff009FD4)),
                  ],
                ),

                SizedBox(height: CustomDimension.myheight(context) / 85),
                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13("Explorer", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text13(
                        "https://www.paxos.co...", Color(0xff009FD4)),
                  ],
                ),

                //////////////////////////////////////////////
                SizedBox(height: CustomDimension.myheight(context) / 25),

                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13("Market Cap", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text12(
                        "USD 2466778665", ColorsCustom.black.withOpacity(0.5)),
                  ],
                ),
                SizedBox(height: CustomDimension.myheight(context) / 85),

                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13("Volume(24h", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text12(
                        "USD 24667665", ColorsCustom.black.withOpacity(0.5)),
                  ],
                ),
                SizedBox(height: CustomDimension.myheight(context) / 85),

                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13(
                        "Circulating Supply", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text12(
                        "2466778665", ColorsCustom.black.withOpacity(0.5)),
                  ],
                ),
                SizedBox(height: CustomDimension.myheight(context) / 85),

                Row(
                  children: [
                    SizedBox(),
                    CustomFonts.text13("Total Supply", ColorsCustom.black),
                    Spacer(),
                    SizedBox(),
                    CustomFonts.text12(
                        "2466778665", ColorsCustom.black.withOpacity(0.5)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 31),
            InkWell(
              onTap: () {
                // Add navigation logic for the "VIEW ON COINGECKO" button
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile()));
              },
              child: orangecard(
                context,
                height: CustomDimension.myheight(context) / 15,
                width: CustomDimension.myheight(context),
                toppadding: 10,
                leftpadding: 10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff130c06),
                      Color(0xff130c06),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                mychild: Center(
                    child: CustomFonts.text15(
                        "VIEW ON COINGECKO", ColorsCustom.white)),



              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
