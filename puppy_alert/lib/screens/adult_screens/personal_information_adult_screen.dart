import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:puppy_alert/widgets/common_widgets/immutable_user_info_common_widget.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';
import '../../widgets/common_widgets/mutable_user_info_common_widget.dart';

class PersonalInformationAdultScreen extends StatefulWidget {
  const PersonalInformationAdultScreen({super.key});

  @override
  State<PersonalInformationAdultScreen> createState() =>
      _PersonalInformationAdultScreenState();
}

class _PersonalInformationAdultScreenState
    extends State<PersonalInformationAdultScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
      TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _addressController.dispose();
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
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  const Center(
                      child: Text('개인정보',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ))),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        userIdContainer(),
                        userPasswordContainer((controller) {
                          _passwordController = controller;
                        }),
                        userPasswordConfirmationContainer((controller) {
                          _passwordConfirmationController = controller;
                        }),
                        userNicknameContainer(),
                        userNameContainer(),
                        userBirthContainer(),
                        userAddressContainer((controller) {
                          _addressController = controller;
                        }),
                        userPhoneNumberContainer(),
                        const SizedBox(
                          height: 20,
                        ),
                        LongRectangleButtonCommonWidget(
                            onPressed: _submitEditProfileForm, text: "수정하기"),
                        LongRectangleButtonCommonWidget(
                            backgroundColor: Colors.grey[300]!,
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            },
                            text: "로그아웃"),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  void _submitEditProfileForm() {
    String password = _passwordController.text.trim();
    String passwordConfirmation = _passwordConfirmationController.text.trim();
    String address = _addressController.text.trim();

    print('Password: $password');
    print('Address: $address');
  }
}
