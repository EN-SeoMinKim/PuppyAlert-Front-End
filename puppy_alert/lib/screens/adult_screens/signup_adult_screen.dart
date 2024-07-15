import 'package:flutter/material.dart';
import '../../widgets/common_widgets/custom_button.dart';
import '../../widgets/common_widgets/user_textformfield_widget.dart';

class SignupAdultScreen extends StatefulWidget {
  @override
  _SignupAdultScreenState createState() => _SignupAdultScreenState();
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
                            children: [
                              idInputWidget((controller) {
                                _idController = controller;
                              }),
                              CustomButton(
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
                        nicknameInputWidget((controller) {
                          _nicknameController = controller;
                        }),
                        nameInputWidget((controller) {
                          _nameController = controller;
                        }),
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
                              CustomButton(
                                  onPressed: _submitSignUpForm,
                                  text:   "인증번호확인"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            onPressed: _submitSignUpForm,
                            text:   "회원가입"),
                      ],
                    ),
                  ),
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
