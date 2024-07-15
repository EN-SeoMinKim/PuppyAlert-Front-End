import 'package:flutter/material.dart';
import '../../widgets/common_widgets/custom_user_text_style.dart';
import '../../widgets/common_widgets/user_form.dart';
import '../child_screens/signup_child_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
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
                      child: Text('로그인',
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
                        idInputWidget((controller) {
                          _idController = controller;
                        }),
                        passwordInputWidget((controller) {
                          _passwordController = controller;
                        }),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitLoginForm();
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupChildScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffFF7700)),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            )),
                        SizedBox(
                          height: 50.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/findPassword'); // 비밀번호 찾기
                          },
                          child: Text(
                            "비밀번호를 잊어버리셨나요?",
                            style: CustomUserTextStyle.signUpTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('계정이 없으신가요?'),
                            TextButton(
                              onPressed: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (
                                //     context) => SignupChildren()))   ;
                              },
                              child: Text(
                                "가입하기",
                                style: CustomUserTextStyle.signUpTextStyle,
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

  void _submitLoginForm() {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();

    print('Id: $id');
    print('Password: $password');
  }
}
