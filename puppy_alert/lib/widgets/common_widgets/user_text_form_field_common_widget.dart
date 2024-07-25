import 'package:flutter/material.dart';

class UserTextFormFieldCommonWidget extends StatefulWidget {
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

  const UserTextFormFieldCommonWidget({
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
  State<UserTextFormFieldCommonWidget> createState() => _UserTextFormFieldCommonWidgetState();
}

class _UserTextFormFieldCommonWidgetState extends State<UserTextFormFieldCommonWidget> {
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
  return UserTextFormFieldCommonWidget(
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
        return '아이디는 4~12자의 알파벳과 \n숫자만 포함해야 합니다';
      }
      return null;
    },
  );
}

Widget passwordInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
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
        return '비밀번호는 8~15자의 알파벳과 숫자및 \n특수문자(@!%*#?&)가 하나 이상 포함해야 합니다';
      }
      return null;
    },
  );
}

Widget passwordConfirmationInputWidget(TextEditingController controller,
    TextEditingController passwordController) {
  return UserTextFormFieldCommonWidget(
    hintText: "비밀번호를 한번 더 입력하세요",
    labelText: "비밀번호 재확인",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    controller: controller,
    prefixIcon: const Icon(Icons.enhanced_encryption),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '비밀번호를 확인하세요';
      } else if (value != passwordController.text) {
        return '비밀번호가 일치하지 않습니다';
      }
      return null;
    },
  );
}

Widget nameInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    hintText: "이름을 입력하세요",
    labelText: "이름",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.perm_identity),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '이름을 입력하세요';
      }
    },
  );
}

Widget nicknameInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    width: 230,
    hintText: "닉네임을 입력하세요",
    labelText: "닉네임",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.perm_identity),
    validator: (value) {
      final RegExp nicknameRegExp = RegExp(
        r'^[a-zA-Z][a-zA-Z0-9_-]{2,18}[a-zA-Z0-9]$',
      );
      if (value == null || value.isEmpty) {
        return '닉네임을 입력하세요';
      } else if (!nicknameRegExp.hasMatch(value)) {
        return '닉네임은 3~20자의 알파벳, 숫자, \n_ 와 - 만 포함할 수 있습니다.';
      }
      return null;
    },
  );
}

Widget addressInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    margin: 20,
    width: 200,
    hintText: "우편번호를 입력하세요",
    labelText: "우편번호",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.location_on_outlined),
  );
}

Widget addressDetailInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    margin: 10.0,
    hintText: "상세 주소를 입력하세요",
    labelText: "           상세주소",
    textInputType: TextInputType.text,
    controller: controller,
  );
}

Widget phoneNumberInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    hintText: "전화번호를 입력하세요",
    labelText: "전화번호",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.call),
    validator: (value) {
      final RegExp idRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');
      if (value == null || value.isEmpty) {
        return '전화번호를 입력하세요';
      } else if (!idRegExp.hasMatch(value)) {
        return '010-1234-1234같이 대쉬를 포함해야 합니다';
      }
      return null;
    },
  );
}

Widget phoneNumberConfirmationInputWidget(TextEditingController controller) {
  return UserTextFormFieldCommonWidget(
    width: 200,
    hintText: "인증번호를 입력하세요",
    labelText: "인증번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    controller: controller,
    prefixIcon: const Icon(Icons.verified_outlined),
  );
}