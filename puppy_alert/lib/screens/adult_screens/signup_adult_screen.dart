import 'package:flutter/material.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_datepicker.dart';
import '../../widgets/common_widgets/white_background_button.dart';
import '../../widgets/common_widgets/custom_user_text_style.dart';
import '../../widgets/common_widgets/user_textformfield.dart';

class SignupAdultScreen extends StatefulWidget {
  @override
  State<SignupAdultScreen> createState() => _SignupAdultScreenState();
}

class _SignupAdultScreenState extends State<SignupAdultScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
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
    _nicknameController.dispose();
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              idInputWidget(_idController),
                              WhiteBackgroundButton(
                                  onPressed: _submitSignUpForm,
                                  text:   "중복확인"),
                            ],
                          ),
                        ),
                        passwordInputWidget(_passwordController),
                        passwordConfirmationInputWidget(_passwordConfirmationController),
                        nicknameInputWidget(_nicknameController),
                        nameInputWidget(_nameController),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width:10),
                                  Icon(Icons.date_range, size: 20),
                                  SizedBox(width:10),
                                  Text(
                                    '생년월일',
                                    style: TextStyle(
                                      color: Color(0xff424856),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              UserDatePicker(),
                            ],
                          ),
                        ),
                        addressInputWidget(_addressController),
                        phonenumberInputWidget(_phonenumberController),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              phonenumberConfirmationInputWidget(_phonenumberconfirmationController),
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
                      ],
                    ),
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
    String nickname = _nicknameController.text.trim();
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String phonenumber = _phonenumberController.text.trim();
    String phonenumberConfirmation =
        _phonenumberconfirmationController.text.trim();


    print('Id: $id');
    print('Password: $password');
    print('Nickname: $nickname');
    print('name: $name');
    print('Address: $address');
    print('Phonenumber: $phonenumber');
    print('PhonenumberConfirmation: $phonenumberConfirmation');
  }
}
