import 'package:dappwallet/utils/ColorsCollecation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.colors,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.roundradius,
      this.text,
      this.textcolor,
      this.prefixWidget,
      this.suffixWidget,
      this.tapwidth});

  Color? colors;
  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;
  Color? textcolor;
  String? text;
  double? roundradius;
  Widget? prefixWidget;

  Widget? suffixWidget;
  double? tapwidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: margin ?? EdgeInsets.zero,
          height: height ?? 40,
          width: width ?? double.maxFinite,
          decoration: _builddecoratiobnStyle(),
          child: _buildButtonWithOrWithoutIcon(),
        ));
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textcolor ?? Colors.white,
              fontSize: 12.5,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Center(
        child: Text(
          text ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textcolor ?? Colors.white,
            fontSize: 12.5,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  _builddecoratiobnStyle() {
    return BoxDecoration(
      color: colors ?? AppColor.bluecolors,
      borderRadius: BorderRadius.circular(roundradius ?? 5),
      border: Border.all(color: colors!, width: 0.7),
    );
  }
  /* _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      backgroundColor: colors,
      side: BorderSide(color:colors!, width: getHorizontalSize(1.00,),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(roundradius?? 8),
      ),
    );
  }*/
}

class ButtonProcess extends StatelessWidget {
  double? height;
  double? width;

  ButtonProcess({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
      width: width ?? 20,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
