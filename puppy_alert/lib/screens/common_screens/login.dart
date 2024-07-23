import 'package:flutter/material.dart';
import '../../widgets/common_widgets/user_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('회원 유형 선택'),
          content: Text('회원 유형을 선택해주세요',
              style: TextStyle(
                color: Colors.grey[600],
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup_child_screen");
              },
              child: const Text(
                '결식아동',
                style: TextStyle(
                  color: Color(0xffFF7700),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup_adult_screen");
              },
              child: const Text(
                '1인 가구',
                style: TextStyle(
                  color: Color(0xffFF7700),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitLoginForm() {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();

    print('Id: $id');
    print('Password: $password');
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
                      child: Text('로그인',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ))),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        loginIdInputWidget(_idController),
                        passwordInputWidget(_passwordController),
                        const SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitLoginForm();
                                Navigator.pushNamed(context, "/speech_recognition_screen");
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFF7700)),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            )),
                        const SizedBox(
                          height: 50.0,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "비밀번호를 잊어버리셨나요?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFF7700),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.40,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('계정이 없으신가요?'),
                            TextButton(
                              onPressed: () {
                                _showChoiceDialog();
                              },
                              child: const Text(
                                "가입하기",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffFF7700),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.40,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
