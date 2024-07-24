import 'package:flutter/material.dart';

class UserTextFormField extends StatefulWidget {
  final TextEditingController _controller;
  final TextInputType _textInputType;
  final String _hintText;
  final Widget? _prefixIcon;
  final String _labelText;
  final bool _obscureText;
  final TextInputAction _actionKeyboard;
  final double _width;
  final String? Function(String?)? _validator;
  final double _margin;

  const UserTextFormField({
    super.key,
    required TextEditingController controller,
    required TextInputType textInputType,
    required String hintText,
    required String labelText,
    bool obscureText = false,
    TextInputAction actionKeyboard = TextInputAction.next,
    Widget? prefixIcon,
    double width = 300,
    String? Function(String?)? validator,
    double margin = 28,
  })  : _controller = controller,
        _textInputType = textInputType,
        _hintText = hintText,
        _labelText = labelText,
        _obscureText = obscureText,
        _actionKeyboard = actionKeyboard,
        _prefixIcon = prefixIcon,
        _width = width,
        _validator = validator,
        _margin = margin;

  @override
  State<UserTextFormField> createState() => _UserTextFormFieldState();
}

class _UserTextFormFieldState extends State<UserTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget._obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
              color: Color(0xff424856),
              fontSize: 20.0,
              fontWeight: FontWeight.w600),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: widget._margin),
        width: widget._width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget._controller,
              obscureText: _obscureText,
              keyboardType: widget._textInputType,
              textInputAction: widget._actionKeyboard,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
              decoration: InputDecoration(
                prefixIcon: widget._prefixIcon,
                labelText: widget._labelText,
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                hintText: widget._hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                ),
                isDense: true,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                ),
                suffixIcon: widget._obscureText
                    ? IconButton(
                  icon: Icon(_obscureText
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: _toggleObscureText,
                )
                    : null,
              ),
              validator: widget._validator,
            ),
          ],
        ),
      ),
    );
  }
}

Widget idInputWidget(TextEditingController controller, double width) {
  return UserTextFormField(
    width: width,
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.badge_outlined),
    validator: (value) {
      final RegExp idRegExp = RegExp(r'^[a-zA-Z0-9]{4,12}$');
      if (value == null || value.isEmpty) {
        return '아이디를 입력하세요';
      } else if (!idRegExp.hasMatch(value)) {
        return '아이디는 4~12자의 알파벳과 숫자만 포함해야 합니다';
      }
      return null;
    },
  );
}

Widget passwordInputWidget(TextEditingController controller) {
  return UserTextFormField(
    hintText: "비밀번호를 입력하세요",
    labelText: "비밀번호",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    controller: controller,
    prefixIcon: const Icon(Icons.enhanced_encryption_outlined),
    validator: (value) {
      final RegExp passwordRegExp = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*#?&])[a-zA-Z\d@!%*#?&]{8,15}$',
      );
      if (value == null || value.isEmpty) {
        return '비밀번호를 입력하세요';
      } else if (!passwordRegExp.hasMatch(value)) {
        return '비밀번호는 8~15자의 알파벳과 숫자및 특수문자(@!%*#?&)가 하나 이상 포함해야 합니다';
      }
      return null;
    },
  );
}