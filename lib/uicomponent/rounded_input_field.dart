import 'package:flutter/material.dart';

import '../res/ResColor.dart';
import '../res/ResString.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextInputType inputType;
  final ValueChanged<String> onChanged;
  final VoidCallback opTapField;
  final double cornerRadius;
  final double horizontalmargin;
  final double verticalmargin;
  final double elevations;
  final Color borderColor;
  final Color textcolor;
  final double textsize;
  final TextAlign textAlign;
  final bool obscureText;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.cornerRadius,
    required this.inputType,
    required this.horizontalmargin,
    required this.elevations,
    required this.borderColor,
    required this.textAlign,
    required this.verticalmargin,
    required this.textcolor,
    required this.textsize,
    required this.obscureText,
    required this.opTapField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: verticalmargin),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              textAlign: textAlign,
              onChanged: onChanged,
              cursorColor: mainColor,
              keyboardType: inputType,
              onTap: () {
                opTapField();
              },

              obscureText: obscureText,
              style: TextStyle(
                  fontFamily: roboto_medium,
                  fontSize: textsize, //14
                  color: textcolor),
              //EditTextColor
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: textcolor),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
