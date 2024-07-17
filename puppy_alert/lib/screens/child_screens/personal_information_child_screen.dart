import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/common_widgets/immutable_user_info_container.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/mutable_user_info_container.dart';
import '../../widgets/common_widgets/white_background_button.dart';

class PersonalInformationChildScreen extends StatefulWidget {
  const PersonalInformationChildScreen({super.key});

  @override
  State<PersonalInformationChildScreen> createState() =>
      _PersonalInformationChildScreenState();
}

class _PersonalInformationChildScreenState
    extends State<PersonalInformationChildScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _addressController = TextEditingController();
  }

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
              Padding(padding: EdgeInsets.only(top: 50)),
              Center(
                child: Text(
                  '개인정보',
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
                    userIdContainer(),
                    userPasswordContainer((controller) {
                      _passwordController = controller;
                    }),
                    userPasswordConfirmationContainer((controller) {
                      _passwordConfirmationController = controller;
                    }),
                    userNameContainer(),
                    userBirthContainer(),
                    userAddressContainer((controller) {
                      _addressController = controller;
                    }),
                    userPhoneNumberContainer(),
                    SizedBox(height: 25,),
                    WhiteBackgroundButton(
                        onPressed: () {},
                        text:   "프로필 사진 수정하기"),
                    LongRectangleButton(
                      onPressed: _submitEditProfileForm,
                      text: "수정하기",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitEditProfileForm() {
    String password = _passwordController.text.trim();
    String passwordConfirmation = _passwordConfirmationController.text.trim();
    String address = _addressController.text.trim();

    print('Password: $password');
    print('Address: $address');
  }
}