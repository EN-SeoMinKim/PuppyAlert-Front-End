import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
import 'package:puppy_alert/widgets/common_widgets/white_background_button.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_datepicker.dart';
import '../../widgets/common_widgets/user_textformfield.dart';
import '../adult_screens/signup_adult_screen.dart';

class SignupChildScreen extends StatefulWidget {
  const SignupChildScreen({super.key});

  @override
  State<SignupChildScreen> createState() => _SignupChildScreenState();
}

class _SignupChildScreenState extends State<SignupChildScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmationController;
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _addressDetailController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _phoneNumberConfirmationController;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _addressDetailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _phoneNumberConfirmationController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    _phoneNumberController.dispose();
    _phoneNumberConfirmationController.dispose();
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
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Center(
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
                              onPressed: _checkDuplicateId,
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      passwordInputWidget(_passwordController),
                      passwordConfirmationInputWidget(
                          _passwordConfirmationController, _passwordController),
                      nameInputWidget(_nameController),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
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
                                  print(
                                      "선택된 날짜: ${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}");
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
                      phoneNumberInputWidget(_phoneNumberController),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phoneNumberConfirmationInputWidget(
                                _phoneNumberConfirmationController),
                            WhiteBackgroundButton(
                              onPressed: _submitSignUpForm,
                              text: "인증번호확인",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
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
                    const Text('계정이 있으신가요?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        "로그인하기",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffFF7700),
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
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
    final formState = _formKey.currentState;
    bool isValid = formState?.validate() ?? false;

    if (isValid) {
      String id = _idController.text.trim();
      String password = _passwordController.text.trim();
      String passwordConfirmation = _passwordConfirmationController.text.trim();
      String name = _nameController.text.trim();
      String address = _addressController.text.trim();
      String phoneNumber = _phoneNumberController.text.trim();
      String phoneNumberConfirmation =
          _phoneNumberConfirmationController.text.trim();

      print('Id: $id');
      print('Password: $password');
      print('Password Confirmation: $passwordConfirmation');
      print('Name: $name');
      print('Address: $address');
      print('PhoneNumber: $phoneNumber');
      print('PhoneNumber Confirmation: $phoneNumberConfirmation');
      if (_selectedDate != null) {
        print(
            'Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}');
      }
    }
  }

  void _checkDuplicateId() {
    print('중복 확인 버튼 클릭됨');
  }
}
