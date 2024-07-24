import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_datepicker.dart';
import '../../widgets/common_widgets/user_textformfield.dart';
import '../../widgets/common_widgets/white_background_button.dart';

class SignupAdultScreen extends StatefulWidget {
  final int _id = 0,
      _password = 1,
      _passwordConfirmation = 2,
      _nickName = 3,
      _name = 4,
      _address = 5,
      _addressDetail = 6,
      _phoneNumber = 7,
      _phoneNumberConfirmation = 8;

  const SignupAdultScreen({super.key});

  @override
  State<SignupAdultScreen> createState() => _SignupAdultScreenState();
}

class _SignupAdultScreenState extends State<SignupAdultScreen> {
  late final _formKey;
  late final List<TextEditingController> _textEditingController;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    for (int i = 0; i < 9; i++) {
      _textEditingController[i] = TextEditingController();
    }
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
                            idInputWidget(_textEditingController[widget._id], 230),
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
}

Widget passwordConfirmationInputWidget(TextEditingController controller,
    TextEditingController passwordController) {
  return UserTextFormField(
    hintText: "비밀번호를 한번 더 입력하세요",
    labelText: "비밀번호 재확인",
    obscureText: true,
    textInputType: TextInputType.visiblePassword,
    controller: controller,
    prefixIcon: const Icon(Icons.enhanced_encryption),
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
    prefixIcon: const Icon(Icons.perm_identity),
    validator: (value) {
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
    prefixIcon: const Icon(Icons.perm_identity),
    validator: (value) {
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
    prefixIcon: const Icon(Icons.location_on_outlined),
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

Widget phoneNumberInputWidget(TextEditingController controller) {
  return UserTextFormField(
    hintText: "전화번호를 입력하세요",
    labelText: "전화번호",
    textInputType: TextInputType.text,
    controller: controller,
    prefixIcon: const Icon(Icons.call),
    validator: (value) {
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

Widget phoneNumberConfirmationInputWidget(TextEditingController controller) {
  return UserTextFormField(
    width: 200,
    hintText: "인증번호를 입력하세요",
    labelText: "인증번호",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    controller: controller,
    prefixIcon: const Icon(Icons.verified_outlined),
  );
}