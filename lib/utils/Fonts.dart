import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomFonts{
  static Widget heading26(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize:26,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis
      ),);
  }
  static Widget heading22(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize:22,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis
      ),);
  }  static Widget heading30(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize:30,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis
      ),);
  }  static Widget heading20(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize: 20,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis
      ),);
  } static Widget heading18(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize: 18,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis
      ),);
  }
static Widget heading18800(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize: 18,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w800,
          overflow: TextOverflow.ellipsis
      ),);
  }

  static Widget heading16(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 16,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w600,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget heading16500(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 16,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget Text16(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 16,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w500,
   ),);


} static Widget Text12(String mytext,Color mycolor){
   return Expanded(
     child: Text(mytext,softWrap: true,maxLines: 5,
       style: TextStyle(
       color: mycolor,
       fontSize: 12,
       fontFamily: 'Poppins',
       fontWeight: FontWeight.w500,
       fontStyle: FontStyle.normal,
           overflow: TextOverflow.ellipsis

     ),),
   );


}static Widget text10(String mytext,Color mycolor){
   return Text(mytext,softWrap: true,maxLines: 5,
     style: TextStyle(
     color: mycolor,
     fontSize: 10,
     fontFamily: 'Poppins',
     fontWeight: FontWeight.w400,
     fontStyle: FontStyle.normal,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text13ex(String mytext,Color mycolor){
   return Text(mytext,softWrap: true,maxLines:10,
     style: TextStyle(
       letterSpacing: 0.5,
     color: mycolor,
     fontSize: 13,
     fontFamily: 'Poppins',
     fontWeight: FontWeight.w400,
     fontStyle: FontStyle.normal,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text11(String mytext,Color mycolor){
   return Text(mytext,
     textAlign: TextAlign.start,
     maxLines: 2,

     style: TextStyle(
       color: mycolor,
     fontSize: 11.5,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w400,
         overflow: TextOverflow.ellipsis,
   ),);


}static Widget text18(String mytext,Color mycolor){
   return Text(mytext,
     textAlign: TextAlign.center,

     style: TextStyle(
       color: mycolor,
     fontSize: 18,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w600,
         overflow: TextOverflow.ellipsis,
   ),);


}static Widget text11underline(String mytext,Color mycolor){
   return Text(mytext,
     textAlign: TextAlign.center,
     style: TextStyle(
       decoration: TextDecoration.underline,
       decorationColor: Colors.white,
       decorationThickness: 2,
       color: mycolor,
     fontSize: 11.5,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w400,
         overflow: TextOverflow.ellipsis,
   ),);


}static Widget text11next(String mytext,Color mycolor){
   return Center(
     child: Text(mytext,
       softWrap: true,
       maxLines: 2,
       style: TextStyle(
       color: mycolor,
       fontSize: 11.0,
       fontFamily: 'Poppins',
       fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,

         overflow: TextOverflow.fade,
     ),),
   );


}
static Widget text12(String mytext,Color mycolor,){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 12,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w500,
   ),);


}static Widget text13(String mytext,Color mycolor){
   return Text(mytext,
     softWrap: true,
     style: TextStyle(
     color: mycolor,
     fontSize: 13.5,
     fontFamily: 'Poppins',
     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
       fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text14(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 14,
     fontFamily: 'Poppins',

     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text14600(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 14,
     fontFamily: 'Poppins',

     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.bold,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text14ex(String mytext,Color mycolor){
   return Text(mytext,
     softWrap: true,
     maxLines: 8,
     style: TextStyle(
     color: mycolor,
     fontSize: 14,
     fontFamily: 'Poppins',

     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget text16ex(String mytext,Color mycolor){
   return Text(mytext,
     softWrap: true,
     maxLines: 4,
     style: TextStyle(
     color: mycolor,
     fontSize: 16,
     fontFamily: 'Poppins',

     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget text10ex(String mytext,Color mycolor){
   return Text(mytext,
     softWrap: true,
     maxLines: 6,
     style: TextStyle(
     color: mycolor,
     fontSize: 10,
     fontFamily: 'Poppins',

     letterSpacing: 0.5,
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis

   ),);


}static Widget text14400(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 14,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w400,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget text13400(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 13,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w400,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget text12400(String mytext,Color mycolor){
   return Text(mytext,
     maxLines: 5,
     style: TextStyle(
     color: mycolor,

     fontSize: 12,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w400,
         overflow: TextOverflow.ellipsis     ),);


}static Widget text15(String mytext,Color mycolor){
   return Text(mytext,
     style: TextStyle(
     color: mycolor,
     fontSize: 15,
     fontFamily: 'Poppins',
     fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w500,
         overflow: TextOverflow.ellipsis
   ),);


}static Widget text15b(String mytext,Color mycolor) {
    return Text(mytext,
      style: TextStyle(
          color: mycolor,
          fontSize: 15,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis

      ),);
  }
  static TextStyle sty(BuildContext context){
    return TextStyle(
        color: Theme.of(context).textTheme.bodyLarge!.color,
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
    );
  }
  
}