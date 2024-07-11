// widgets/signup_children_text_form_field_widget.dart

import 'package:flutter/material.dart';

class UserTextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget? prefixIcon;
  final String labelText;
  final bool obscureText;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;

  UserTextFormFieldWidget({
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.actionKeyboard = TextInputAction.next,
    required this.onSubmitField,
    this.prefixIcon,
  });

  @override
  _UserTextFormFieldWidgetState createState() => _UserTextFormFieldWidgetState();
}

class _UserTextFormFieldWidgetState extends State<UserTextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xff424856), fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 300,
        child: TextFormField(
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            isDense: true,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}


class CustomUserTextStyle {
  static const TextStyle signUpTextStyle = TextStyle(
    fontSize: 16,
    color: Color(0xffFF7700),
    fontWeight: FontWeight.w500,
    height: 0,
    letterSpacing: -0.40,
  );
}

