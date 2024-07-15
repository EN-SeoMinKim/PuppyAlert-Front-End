import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/common_widgets/text_widget.dart';

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


