import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_model.dart';

class MyPageHeaderCommonWidget extends StatelessWidget {
  final UserModel _userModel;

  const MyPageHeaderCommonWidget({
    super.key,
    required UserModel userModel,
  }) : _userModel = userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      color: const Color(0xffFFD6BF),
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          ClipOval(
            child: Image.network(
              _userModel.userProfileImageURL,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            _userModel.nickName,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
