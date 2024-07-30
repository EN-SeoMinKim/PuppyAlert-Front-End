import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/common_widgets/immutable_user_info_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/long_rectangle_button_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/mutable_user_info_common_widget.dart';
import 'package:puppy_alert/widgets/common_widgets/white_background_button_common_widget.dart';

class PersonalInformationScreen extends StatefulWidget {

  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
  }

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

  Widget _buildColumn() {
    return GestureDetector(
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
                  const ImmutableUserInfoCommonWidget(
                    label: '아이디',
                    value: 'userId',
                  ),
                  MutableUserInfoCommonWidget(
                      controller: _passwordController, label: '비밀번호'),
                  MutableUserInfoCommonWidget(
                      controller: _passwordConfirmationController,
                      label: '비밀번호 재확인'),
                  const ImmutableUserInfoCommonWidget(
                    label: '이름',
                    value: 'userName',
                  ),
                  const ImmutableUserInfoCommonWidget(
                    label: '생년월일',
                    value: '2024.09.09',
                  ),
                  const ImmutableUserInfoCommonWidget(
                    label: '주소',
                    value: '서울특별시 광진구 능동로 209',
                  ),
                  const ImmutableUserInfoCommonWidget(
                    label: '상세주소',
                    value: '세종대학교 ',
                  ),
                  const ImmutableUserInfoCommonWidget(
                    label: '전화번호',
                    value: '010-1234-1234',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildColumn(),
    );
  }
}
