import 'package:flutter/material.dart';


class ImmutableUserInfoCommonWidget extends StatelessWidget {
  final String label;
  final String value;

  const ImmutableUserInfoCommonWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 55,
      width: 300,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF757575))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

Widget userIdContainer(){
  return  const ImmutableUserInfoCommonWidget(
    label: '아이디',
    value: 'userId',
  );
}

Widget userNicknameContainer(){
  return  const ImmutableUserInfoCommonWidget(
    label: '닉네임',
    value: 'userNickname',
  );
}

Widget userNameContainer(){
  return  const ImmutableUserInfoCommonWidget(
    label: '이름',
    value: 'userName',
  );
}

Widget userBirthContainer(){
  return  const ImmutableUserInfoCommonWidget(
    label: '생년월일',
    value: '2024.09.09',
  );
}

Widget userPhoneNumberContainer(){
  return  const ImmutableUserInfoCommonWidget(
    label: '전화번호',
    value: '010-1234-1234',
  );
}









