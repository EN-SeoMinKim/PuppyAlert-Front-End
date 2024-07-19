import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressDetailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _phonenumberconfirmationController = TextEditingController();

  DateTime? _selectedDate;  // 선택된 날짜를 저장할 변수

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
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
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      passwordInputWidget(_passwordController),
                      passwordConfirmationInputWidget(_passwordConfirmationController,_passwordController),
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
                                SizedBox(width: 10),
                                Icon(Icons.date_range, size: 20),
                                SizedBox(width: 10),
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
                            UserDatePicker(
                              onDateSelected: (date) {
                                setState(() {
                                  _selectedDate = date;
                                });
                                if (date != null) {
                                  print("선택된 날짜: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            addressInputWidget(_addressController),
                            WhiteBackgroundButton(
                              onPressed: _submitSignUpForm,
                              text: "우편번호 검색",
                            ),
                          ],
                        ),
                      ),
                      addressDetailInputWidget(_addressDetailController),
                      phonenumberInputWidget(_phonenumberController),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phonenumberConfirmationInputWidget(_phonenumberconfirmationController),
                            WhiteBackgroundButton(
                              onPressed: _submitSignUpForm,
                              text: "인증번호확인",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LongRectangleButton(
                        onPressed: _submitSignUpForm,
                        text: "회원가입",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('계정이 있으신가요?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "로그인하기",
                        style: CustomUserTextStyle.signUpTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitSignUpForm() {
    if (_formKey.currentState?.validate() ?? false) {
      String id = _idController.text.trim();
      String password = _passwordController.text.trim();
      String passwordConfirmation = _passwordConfirmationController.text.trim();
      String name = _nameController.text.trim();
      String address = _addressController.text.trim();
      String phonenumber = _phonenumberController.text.trim();
      String phonenumberConfirmation = _phonenumberconfirmationController.text.trim();

      print('Id: $id');
      print('Password: $password');
      print('Password Confirmation: $passwordConfirmation');
      print('Name: $name');
      print('Address: $address');
      print('Phonenumber: $phonenumber');
      print('Phonenumber Confirmation: $phonenumberConfirmation');
      if (_selectedDate != null) {
        print('Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}');
      }
    }
  }
}
