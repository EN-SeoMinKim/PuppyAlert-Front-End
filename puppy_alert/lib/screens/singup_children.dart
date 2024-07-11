import 'package:flutter/material.dart';

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
          elevation: 0.0,
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
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: 300,
                    child: TextFormField(
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "e-mail",
                        labelStyle: TextStyle(
                          color: Color(0xE5001F3F),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE5001F3F),
                          ),
                        ),
                        isDense: true,
                        hintText: '이메일을 입력하세요',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 10,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.33,
                      ),
                      // controller: _emailController,
                      // validator: (value) => CheckValidate().validateEmail(_emailFocus, value ?? ''),
                      // onSaved: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: 300,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.badge),
                        labelText: "닉네임",
                        labelStyle: TextStyle(
                          color: Color(0xE5001F3F),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE5001F3F),
                          ),
                        ),
                        isDense: true,
                        hintText: '닉네임을 입력하세요',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        // 다른 속성들 설정
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.33,
                      ),
                      // controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '닉네임을 입력해주세요.';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: 300,
                    child: TextFormField(
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "P/W",
                        labelStyle: TextStyle(
                          color: Color(0xE5001F3F),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE5001F3F),
                          ),
                        ),
                        isDense: true,
                        hintText: '비밀번호를 입력하세요',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        // 다른 속성들 설정
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.33,
                      ),
                      // controller: _passwordController,
                      // validator: (value) => CheckValidate().validatePassword(_passwordFocus, value ?? ''),
                      // onSaved: (value) {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: 300,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.enhanced_encryption),
                        labelText: "P/W C",
                        labelStyle: TextStyle(
                          color: Color(0xE5001F3F),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xE5001F3F),
                          ),
                        ),
                        isDense: true,
                        hintText: '비밀번호를 한번 더 입력하세요',
                        hintStyle: TextStyle(
                          color: Color(0xFFCCCCCC),
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontFamily: 'GowunBatang',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                        // 다른 속성들 설정
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: -0.33,
                      ),
                      // controller: _passwordConfirmController,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return '비밀번호를 한 번 더 입력해주세요.';
                      //   } else if (value != _passwordController.text.toString()) {
                      //     return '비밀번호가 일치하지 않습니다.';
                      //   }
                      //   return null;
                      // },
                      // onSaved: (value) {},
                    ),
                  ),
                  _signupChildrenBuildPasswordConfirmation(),
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




final class SignupChildrenTextFormFieldWidget extends StatefulWidget {
  TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  // final String defaultText;
  // final FocusNode focusNode;
  final bool obscureText;
  // final TextEditingController controller;
  // final Function functionValidate;
  // final String parametersValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  // final Function onFieldTap;

  SignupChildrenTextFormFieldWidget(
      { required this.hintText,
        // required this.focusNode,
        required this.textInputType,
        // required this.defaultText,
        this.obscureText = false,
        // this.controller,
        // this.functionValidate,
        // this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        required this.onSubmitField,
        // required this.onFieldTap,
        required this.prefixIcon});

  @override
  _SignupChildrenTextFormFieldWidgetState createState() => _SignupChildrenTextFormFieldWidgetState();
}

class _SignupChildrenTextFormFieldWidgetState extends State<SignupChildrenTextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color(0xffFF7700),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 300,
        child: TextFormField(
          obscureText: true,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          // focusNode: widget.focusNode,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            // contentPadding: EdgeInsets.only(
            //     top: 50, bottom: bottomPaddingToError, left: 8.0, right: 8.0),
            isDense: true,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCCCCCC)),
            ),
          ),
          // controller: widget.controller,
          // validator: (value) {
          //   if (widget.functionValidate != null) {
          //     String resultValidate =
          //     widget.functionValidate(value, widget.parametersValidate);
          //     if (resultValidate != null) {
          //       return resultValidate;
          //     }
          //   }
          //   return null;
          // },
          // onFieldSubmitted: (value) {
          //   if (widget.onSubmitField != null) widget.onSubmitField();
          // },
          // onTap: () {
          //   if (widget.onFieldTap != null) widget.onFieldTap();
          // },
        ),
      ),
    );
  }
}

Widget _signupChildrenBuildPasswordConfirmation() {
  return SignupChildrenTextFormFieldWidget(
    hintText: "비밀번호를 한번 더 입력하세요",
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