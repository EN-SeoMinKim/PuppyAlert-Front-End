import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_datepicker.dart';
import '../../widgets/common_widgets/user_text_form_field.dart';
import '../../widgets/common_widgets/white_background_button.dart';

class SignupScreen extends StatefulWidget {
  final int _id = 0,
      _password = 1,
      _passwordConfirmation = 2,
      _nickName = 3,
      _name = 4,
      _address = 5,
      _addressDetail = 6,
      _phoneNumber = 7,
      _phoneNumberConfirmation = 8;

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final _formKey;
  late final List<TextEditingController> _textEditingController;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _textEditingController = List.generate(9, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (TextEditingController t in _textEditingController) {
      t.dispose();
    }
    super.dispose();
  }

  void _checkDuplicateId() {
    print('id 중복 확인 버튼 클릭됨');
  }

  void _checkDuplicateNickname() {
    print('닉네임 중복 확인 버튼 클릭됨');
  }

  void _submitSignUpForm() {
    final formState = _formKey.currentState;
    bool isValid = formState?.validate() ?? false;

    if (isValid) {
      String id = _textEditingController[widget._id].text.trim();
      String password = _textEditingController[widget._password].text.trim();
      String passwordConfirmation =
          _textEditingController[widget._passwordConfirmation].text.trim();
      String nickname = _textEditingController[widget._nickName].text.trim();
      String name = _textEditingController[widget._name].text.trim();
      String address = _textEditingController[widget._address].text.trim();
      String addressDetail =
          _textEditingController[widget._addressDetail].text.trim();
      String phoneNumber =
          _textEditingController[widget._phoneNumber].text.trim();
      String phoneNumberConfirmation =
          _textEditingController[widget._phoneNumberConfirmation].text.trim();

      print('Id: $id');
      print('Password: $password');
      print('Password Confirmation: $passwordConfirmation');
      print('Nickname: $nickname');
      print('Name: $name');
      print('Address: $address');
      print('Address Detail: $addressDetail');
      print('PhoneNumber: $phoneNumber');
      print('PhoneNumber Confirmation: $phoneNumberConfirmation');
      if (_selectedDate != null) {
        print(
            'Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}');
      }
    }
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
                            idInputWidget(
                                _textEditingController[widget._id], 230),
                            WhiteBackgroundButton(
                              onPressed: _checkDuplicateId,
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      passwordInputWidget(
                          _textEditingController[widget._password]),
                      passwordConfirmationInputWidget(
                          _textEditingController[widget._passwordConfirmation],
                          _textEditingController[widget._password]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            nicknameInputWidget(
                                _textEditingController[widget._nickName]),
                            WhiteBackgroundButton(
                              onPressed: _checkDuplicateNickname,
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      nameInputWidget(_textEditingController[widget._name]),
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
                            addressInputWidget(
                                _textEditingController[widget._address]),
                            WhiteBackgroundButton(
                              onPressed: _submitSignUpForm,
                              text: "우편번호 검색",
                            ),
                          ],
                        ),
                      ),
                      addressDetailInputWidget(
                          _textEditingController[widget._addressDetail]),
                      phoneNumberInputWidget(
                          _textEditingController[widget._phoneNumber]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phoneNumberConfirmationInputWidget(
                                _textEditingController[
                                    widget._phoneNumberConfirmation]),
                            WhiteBackgroundButton(
                              onPressed: _submitSignUpForm,
                              text: "인증번호확인",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login_screen', (route) => false);
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
}
