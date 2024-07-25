import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';
import '../../widgets/common_widgets/user_date_picker_common_widget.dart';
import '../../widgets/common_widgets/user_text_form_field_common_widget.dart';
import '../../widgets/common_widgets/white_background_button_common_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmationController;
  late final TextEditingController _nicknameController;
  late final TextEditingController _nameController;
  late final TextEditingController _postcodeController;
  late final TextEditingController _addressController;
  late final TextEditingController _addressDetailController;
  late final TextEditingController _phonenumberController;
  late final TextEditingController _phonenumberconfirmationController;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _nicknameController = TextEditingController();
    _nameController = TextEditingController();
    _postcodeController = TextEditingController();
    _addressController = TextEditingController();
    _addressDetailController = TextEditingController();
    _phonenumberController = TextEditingController();
    _phonenumberconfirmationController = TextEditingController();
    _postcodeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nicknameController.dispose();
    _nameController.dispose();
    _postcodeController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    _phonenumberController.dispose();
    _phonenumberconfirmationController.dispose();
    super.dispose();
  }

  void _searchAddress(BuildContext context) async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    final postcode = model.zonecode ?? '';
    _postcodeController.value = TextEditingValue(
      text: postcode,
    );

    final address = model.address ?? '';
    _addressController.value = TextEditingValue(
      text: address,
    );

    final buildingName = model.buildingName ?? '';
    _addressDetailController.value = TextEditingValue(
      text: buildingName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showIcon = _postcodeController.text.isEmpty;

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
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            idInputWidget(width: 230, _idController),
                            Column(
                              children: [
                                WhiteBackgroundButtonCommonWidget(
                                  onPressed: _checkDuplicateId,
                                  text: "중복확인",
                                ),
                                if(_formKey.currentState?.validate() ?? false)
                                  const SizedBox(height:100),
                              ],
                            ),
                          ],
                        ),
                      ),
                      passwordInputWidget(_passwordController),
                      passwordConfirmationInputWidget(
                          _passwordConfirmationController, _passwordController),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            nicknameInputWidget(_nicknameController),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(_formKey.currentState?.validate() ?? true)
                                  const SizedBox(height:50),
                                WhiteBackgroundButtonCommonWidget(
                                  onPressed: _checkDuplicateNickname,
                                  text: "중복확인",
                                ),
                                if(_formKey.currentState?.validate() ?? false)
                                  const SizedBox(height:150),
                              ],
                            ),
                          ],
                        ),
                      ),
                      nameInputWidget(_nameController),
                      SizedBox(
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
                            UserDatePickerCommonWidget(
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
                            const SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: _postcodeController,
                                decoration: InputDecoration(
                                  hintText: '우편번호',
                                  prefixIcon: showIcon
                                      ? Icon(Icons.location_on_outlined)
                                      : null,
                                ),
                                readOnly: true,
                              ),
                            ),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: () => _searchAddress(context),
                              text: "우편번호 검색",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            hintText: '           주소',
                          ),
                          readOnly: true,
                        ),
                      ),
                      addressDetailInputWidget(_addressDetailController),
                      phonenumberInputWidget(_phonenumberController),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phonenumberConfirmationInputWidget(
                                _phonenumberconfirmationController),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: _submitSignUpForm,
                              text: "인증번호확인",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      LongRectangleButtonCommonWidget(
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
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
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
      String nickname = _nicknameController.text.trim();
      String name = _nameController.text.trim();
      String address = _addressController.text.trim();
      String addressDetail = _addressDetailController.text.trim();
      String phonenumber = _phonenumberController.text.trim();
      String phonenumberConfirmation =
      _phonenumberconfirmationController.text.trim();

      print('Id: $id');
      print('Password: $password');
      print('Password Confirmation: $passwordConfirmation');
      print('Nickname: $nickname');
      print('Name: $name');
      print('Address: $address');
      print('Address Detail: $addressDetail');
      print('Phonenumber: $phonenumber');
      print('Phonenumber Confirmation: $phonenumberConfirmation');
      if (_selectedDate != null) {
        print(
            'Selected Date: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}');
      }
    }
  }

  void _checkDuplicateId() {
    print('id 중복 확인 버튼 클릭됨');
  }

  void _checkDuplicateNickname() {
    print('닉네임 중복 확인 버튼 클릭됨');
  }
}
