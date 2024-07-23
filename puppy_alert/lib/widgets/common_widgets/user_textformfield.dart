import 'package:flutter/material.dart';

class UserTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final Widget? prefixIcon;
  final String labelText;
  final bool obscureText;
  final TextInputAction actionKeyboard;
  final double width;
  final String? Function(String?)? validator;
  final double margin;

  UserTextFormField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    this.actionKeyboard = TextInputAction.next,
    this.prefixIcon,
    this.width = 300,
    this.validator,
    this.margin = 28,
  });

  @override
  State<UserTextFormField> createState() => _UserTextFormFieldState();
}

class _UserTextFormFieldState extends State<UserTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
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
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xff424856), fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: widget.margin),
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
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
                suffixIcon: widget.obscureText ? IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: _toggleObscureText,
                ) : null,
              ),
              validator: widget.validator,
            ),
          ],
        ),
      ),
    );
  }
}





Widget idInputWidget(TextEditingController controller) {
  return UserTextFormField(
    width: 230,
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: Icon(Icons.badge_outlined),
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
    prefixIcon: Icon(Icons.enhanced_encryption_outlined),
    validator: (value){
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


Widget passwordConfirmationInputWidget(TextEditingController controller, TextEditingController passwordController) {

  return UserTextFormField(
    hintText: "비밀번호를 한번 더 입력하세요",
    labelText: "비밀번호 재확인",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    controller:controller,
    prefixIcon: Icon(Icons.enhanced_encryption),
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

  return UserTextFormField(
    hintText: "이름을 입력하세요",
    labelText: "이름",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: Icon(Icons.perm_identity),
    validator: (value){
      if (value == null || value.isEmpty) {
        return '이름을 입력하세요';
      }
    },
  );
}

Widget nicknameInputWidget(TextEditingController controller) {

  return UserTextFormField(
    width: 230,
    hintText: "닉네임을 입력하세요",
    labelText: "닉네임",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: Icon(Icons.perm_identity),
    validator: (value){
      final RegExp nicknameRegExp = RegExp(
        r'^[a-zA-Z][a-zA-Z0-9_-]{2,18}[a-zA-Z0-9]$',
      );
      if (value == null || value.isEmpty) {
        return '닉네임을 입력하세요';
      } else if (!nicknameRegExp.hasMatch(value)) {
        return '닉네임은 3~20자의 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 포함할 수 있습니다.';
      }
      return null;
    },
  );
}




Widget addressInputWidget(TextEditingController controller) {

  return UserTextFormField(
    margin: 20,
    width: 200,
    hintText: "우편번호를 입력하세요",
    labelText: "우편번호",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: Icon(Icons.location_on_outlined),
  );
}

Widget addressDetailInputWidget(TextEditingController controller) {

  return UserTextFormField(
    margin: 10.0,
    hintText: "상세 주소를 입력하세요",
    labelText: "           상세주소",
    textInputType: TextInputType.text,
    controller: controller,
  );
}


Widget phonenumberInputWidget(TextEditingController controller) {

  return UserTextFormField(
    hintText: "전화번호를 입력하세요",
    labelText: "전화번호",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: Icon(Icons.call),
    validator: (value){
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


Widget phonenumberConfirmationInputWidget(TextEditingController controller) {

  return UserTextFormField(
    width: 200,
    hintText: "인증번호를 입력하세요",
    labelText: "인증번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    controller: controller,
    prefixIcon: Icon(Icons.verified_outlined),
  );
}

