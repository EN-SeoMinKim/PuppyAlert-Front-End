import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/common_widgets/white_background_button.dart';
import '../../widgets/common_widgets/custom_user_text_style.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_datepicker.dart';
import '../../widgets/common_widgets/user_textformfield.dart';

class SignupChildScreen extends StatefulWidget {
  const SignupChildScreen({super.key});

  @override
  State<SignupChildScreen> createState() => _SignupChildScreenState();
}

class _SignupChildScreenState extends State<SignupChildScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
  TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _phonenumberconfirmationController =
  TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phonenumberController.dispose();
    _phonenumberconfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Center(
                      child: Text('회원가입',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ))
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              idInputWidget((controller) {
                                _idController = controller;
                              }),
                              WhiteBackgroundButton(
                                  onPressed: _submitSignUpForm,
                                  text:   "중복확인"),
                            ],
                          ),
                        ),
                        passwordInputWidget((controller) {
                          _passwordController = controller;
                        }),
                        passwordConfirmationInputWidget((controller) {
                          _passwordConfirmationController = controller;
                        }),
                        nameInputWidget((controller) {
                          _nameController = controller;
                        }),
                        SizedBox(
                          height: 30,
                        ),
                        UserDatePicker(),
                        addressInputWidget((controller) {
                          _addressController = controller;
                        }),
                        phonenumberInputWidget((controller) {
                          _phonenumberController = controller;
                        }),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              phonenumberConfirmationInputWidget((controller) {
                                _phonenumberconfirmationController = controller;
                              }),
                              WhiteBackgroundButton(
                                  onPressed: _submitSignUpForm,
                                  text:   "인증번호확인"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LongRectangleButton(
                            onPressed: _submitSignUpForm,
                            text:   "회원가입"),
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('계정이 없으신가요?'),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupChildren()))   ;
                        },
                        child: Text(
                          "가입하기",
                          style: CustomUserTextStyle.signUpTextStyle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  void _submitSignUpForm() {

    String id = _idController.text.trim();
    String password = _passwordController.text.trim();
    String passwordConfirmation = _passwordConfirmationController.text.trim();
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String phonenumber = _phonenumberController.text.trim();
    String phonenumberConfirmation =
    _phonenumberconfirmationController.text.trim();


    print('Id: $id');
    print('Password: $password');
    print('name: $name');
    print('Address: $address');
    print('Phonenumber: $phonenumber');
    print('PhonenumberConfirmation: $phonenumberConfirmation');
  }
}
