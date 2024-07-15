import 'package:flutter/material.dart';

class UserTextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final Widget? prefixIcon;
  final String labelText;
  final bool obscureText;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;

  UserTextFormFieldWidget(
      {super.key,
    required this.controller,
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
          controller: widget.controller,
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
            // validator: (value) => CheckValidate().validateEmail(_emailFocus, value ?? ''),
            // onSaved: (value) {},
          ),
        ),
      ),
    );
  }
}



typedef ControllerCallback = void Function(TextEditingController controller);

Widget idInputWidget(ControllerCallback controllerCallback) {
  TextEditingController loginIdController = TextEditingController();

  controllerCallback(loginIdController);

  return UserTextFormFieldWidget(
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: loginIdController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.badge_outlined),
  );
}


Widget passwordInputWidget(ControllerCallback controllerCallback) {
  TextEditingController passwordController = TextEditingController();

  controllerCallback(passwordController);

  return UserTextFormFieldWidget(
    hintText: "비밀번호를 입력하세요",
    labelText: "비밀번호",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.enhanced_encryption),
  );
}


Widget passwordConfirmationInputWidget(ControllerCallback controllerCallback) {
  TextEditingController passwordConfirmationController = TextEditingController();

  controllerCallback(passwordConfirmationController);

  return UserTextFormFieldWidget(
    hintText: "비밀번호를 한번 더 입력하세요",
    labelText: "비밀번호 재확인",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller:passwordConfirmationController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.enhanced_encryption),
  );
}

Widget nameInputWidget(ControllerCallback controllerCallback) {
  TextEditingController nameController = TextEditingController();

  controllerCallback(nameController);

  return UserTextFormFieldWidget(
    hintText: "이름을 입력하세요",
    labelText: "이름",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: nameController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.perm_identity),
  );
}

Widget nicknameInputWidget(ControllerCallback controllerCallback) {
  TextEditingController nicknameController = TextEditingController();

  controllerCallback(nicknameController);

  return UserTextFormFieldWidget(
    hintText: "닉네임을 입력하세요",
    labelText: "닉네임",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: nicknameController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.perm_identity),
  );
}




Widget addressInputWidget(ControllerCallback controllerCallback) {
  TextEditingController addressController = TextEditingController();

  controllerCallback(addressController);

  return UserTextFormFieldWidget(
    hintText: "주소를 입력하세요",
    labelText: "주소",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: addressController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.location_on_outlined),
  );
}

Widget phonenumberInputWidget(ControllerCallback controllerCallback) {
  TextEditingController phonenumberController = TextEditingController();

  controllerCallback(phonenumberController);

  return UserTextFormFieldWidget(
    hintText: "전화번호를 입력하세요",
    labelText: "전화번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: phonenumberController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.call),
  );
}


Widget phonenumberConfirmationInputWidget(ControllerCallback controllerCallback) {
  TextEditingController phonenumberConfirmationController = TextEditingController();

  controllerCallback( phonenumberConfirmationController);

  return UserTextFormFieldWidget(
    hintText: "인증번호를 입력하세요",
    labelText: "인증번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: phonenumberConfirmationController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    prefixIcon: Icon(Icons.verified_outlined),
    // parametersValidate: "Please enter password.",
  );
}

