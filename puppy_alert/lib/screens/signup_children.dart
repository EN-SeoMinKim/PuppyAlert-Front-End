import 'package:flutter/material.dart';
import '../widgets/textformfield_widget.dart';

class SignupChildren extends StatelessWidget {

  List<int> signupChildrenYear = List.generate(2005, (index) => index + 20);
  List<int> signupChildrenMonth = List.generate(1, (index) => index + 11);
  List<int> signupChildrenDay = List.generate(1, (index) => index + 30);


  TextEditingController signupChildrenIdController = TextEditingController();
  TextEditingController signupChildrenPasswordController = TextEditingController();
  TextEditingController signupChildrenPasswordCheckController = TextEditingController();
  TextEditingController signupChildrenNameController = TextEditingController();
  TextEditingController signupChildrenAddressController = TextEditingController();
  TextEditingController signupChildrenPhoneNumberController = TextEditingController();
  TextEditingController signupChildrenVerificationCodeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFF7700),
        ),
        body: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text('회원가입',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ))
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _signupChildrenBuildId(),
                          _signupChildrenBuildPassword(),
                          _signupChildrenBuildPasswordConfirmation(),
                          _signupChildrenBuildName(),
                          _signupChildrenBuildAddress(),
                          _signupChildrenBuildPhoneNumber(),
                          _signupChildrenBuildPhoneNumberConfirmation(),
                        ],
                      ),
                    ]),
              ),
            )
        ));
  }


  void signupShowSnackBar(BuildContext context, Text text) {
    final snackBar = SnackBar(
      content: text,
      backgroundColor: Color.fromARGB(255, 112, 48, 48),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}





Widget _signupChildrenBuildId() {
  return TextFormFieldWidget(
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.badge_outlined),
  );
}


Widget _signupChildrenBuildPassword() {
  return TextFormFieldWidget(
    hintText: "비밀번호를 입력하세요",
    labelText: "비밀번호",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.enhanced_encryption),
  );
}


Widget _signupChildrenBuildPasswordConfirmation() {
  return TextFormFieldWidget(
    hintText: "비밀번호를 한번 더 입력하세요",
    labelText: "비밀번호 재확인",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.enhanced_encryption),
  );
}

Widget _signupChildrenBuildName() {
  return TextFormFieldWidget(
    hintText: "이름을 입력하세요",
    labelText: "이름",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.perm_identity),
  );
}


Widget _signupChildrenBuildAddress() {
  return TextFormFieldWidget(
    hintText: "주소를 입력하세요",
    labelText: "주소",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.location_on_outlined),
  );
}

Widget _signupChildrenBuildPhoneNumber() {
  return TextFormFieldWidget(
    hintText: "전화번호를 입력하세요",
    labelText: "전화번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.call),
  );
}


Widget _signupChildrenBuildPhoneNumberConfirmation() {
  return TextFormFieldWidget(
    hintText: "인증번호를 입력하세요",
    labelText: "인증번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    // controller: _passwordController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    prefixIcon: Icon(Icons.verified_outlined),
    // parametersValidate: "Please enter password.",
  );
}



