import 'package:dappwallet/utils/size.dart';
import 'package:flutter/material.dart';

class CustomeTextformfiled extends StatelessWidget {
  String heading = "";
  TextEditingController controller = TextEditingController();
  FormFieldValidator<String>? validator;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  ValueChanged<String>? onchnage;
  bool? enable;
  CustomeTextformfiled(
      {required this.heading,
      required this.controller,
      this.validator,
      this.textInputAction,
      this.onchnage,
      this.enable = true,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 45,
          width: width(context),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Theme.of(context).cardColor),
          ),
          child: TextFormField(
              controller: controller,
              enabled: enable,
              cursorColor: Theme.of(context).primaryColor,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              onChanged: onchnage,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: validator),
        ),
      ],
    );
  }
}
