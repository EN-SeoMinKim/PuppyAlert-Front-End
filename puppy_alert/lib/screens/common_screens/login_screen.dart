import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/user_model.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_adult_screen.dart';
import 'package:puppy_alert/screens/child_screens/main_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/signup_screen.dart';
import 'package:puppy_alert/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:puppy_alert/widgets/common_widgets/user_text_form_field_common_widget.dart';

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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignupScreen(
                    userType: UserType.child,
                  );
                }));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignupScreen(
                    userType: UserType.adult,
                  );
                }));
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

  void _submitLoginForm() async {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/user/login');
    http.Response response = await http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'password': password,
        }));

    if (response.body == '존재하지 않는 아이디입니다' || response.body == '비밀번호가 옳지 않습니다') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('로그인에 실패했습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    _goNextPage(jsonDecode(response.body), id, password);
  }

  void _goNextPage(
      Map<String, dynamic> jsonData, String id, String password) async {
    UserModel userDto = await _getUserDto(id, password);

    if (jsonData['userType'] == 'HOST') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SpeechRecognitionAdultScreen(
          userDto: userDto,
        );
      }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainChildScreen(
          userDto: userDto,
        );
      }));
    }
  }

  Future<UserModel> _getUserDto(String userId, String userPassword) async {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/user?id=$userId');
    final value = (await http.get(uri)).bodyBytes;
    final jsonData = jsonDecode(utf8.decode(value));

    return UserModel.fromJson(jsonData, userPassword);
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
                        idInputWidget(_idController, 300),
                        passwordInputWidget(_passwordController),
                        const SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitLoginForm();
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
