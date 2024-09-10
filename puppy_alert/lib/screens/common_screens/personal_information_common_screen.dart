import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/widgets/common_widgets/immutable_user_info_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/mutable_user_info_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/white_background_button_common_widget.dart';

class PersonalInformationCommonScreen extends StatefulWidget {
  final UserModel _userModel;

  const PersonalInformationCommonScreen({super.key, required userModel})
      : _userModel = userModel;

  @override
  State<PersonalInformationCommonScreen> createState() =>
      _PersonalInformationCommonScreenState();
}

class _PersonalInformationCommonScreenState
    extends State<PersonalInformationCommonScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _submitEditProfileForm() {
    String password = _passwordController.text.trim();
    String passwordConfirmation = _passwordConfirmationController.text.trim();
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
                    ImmutableUserInfoCommonWidget(
                      label: '아이디',
                      value: widget._userModel.userId,
                    ),
                    MutableUserInfoCommonWidget(
                        controller: _passwordController, label: '비밀번호'),
                    MutableUserInfoCommonWidget(
                        controller: _passwordConfirmationController,
                        label: '비밀번호 재확인'),
                    ImmutableUserInfoCommonWidget(
                      label: '이름',
                      value: widget._userModel.name,
                    ),
                    ImmutableUserInfoCommonWidget(
                      label: '생년월일',
                      value: widget._userModel.birth,
                    ),
                    ImmutableUserInfoCommonWidget(
                      label: '주소',
                      value: widget._userModel.address,
                    ),
                    ImmutableUserInfoCommonWidget(
                      label: '상세주소',
                      value: widget._userModel.address,
                    ),
                    ImmutableUserInfoCommonWidget(
                      label: '전화번호',
                      value: widget._userModel.phoneNumber,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    WhiteBackgroundButtonCommonWidget(
                        onPressed: () {}, text: "프로필 사진 수정하기"),
                    LongRectangleButtonCommonWidget(
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
}
