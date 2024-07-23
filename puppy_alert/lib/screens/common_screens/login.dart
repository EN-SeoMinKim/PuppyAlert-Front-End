import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/home_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_screen.dart';
import '../../widgets/common_widgets/user_textformfield.dart';
import '../child_screens/signup_child_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showChoiceDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('회원 유형 선택'),
          content: Text('회원 유형을 선택해주세요',
          style: TextStyle(
            color: Colors.grey[600],
          )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('child');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupChildScreen()));
              },
              child: Text('결식아동',
              style: TextStyle(
                color:Color(0xffFF7700),
              ),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('adult');
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupAdultScreen()));
              },
              child: Text('1인 가구',
              style: TextStyle(
                color: Color(0xffFF7700),
              ),),
            ),
          ],
        );
      },
    ).then((value) {
      print('Selected option: $value');
    });
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
                          ))),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        loginIdInputWidget(_idController),
                        passwordInputWidget(_passwordController),
                        SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitLoginForm();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SpeechRecognitionScreen()));
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
                          onPressed: () {},
                          child: Text(
                            "비밀번호를 잊어버리셨나요?",
                            style: TextStyle(
                              fontSize: 16,
                              color:  Color(0xffFF7700),
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.40,
                            ),
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
                                _showChoiceDialog();
                              },
                              child: Text(
                                "가입하기",
                                style: TextStyle(
                                  fontSize: 16,
                                  color:  Color(0xffFF7700),
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

  void _submitLoginForm() {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();

    print('Id: $id');
    print('Password: $password');
  }
}




Widget loginIdInputWidget(TextEditingController controller) {

  return UserTextFormField(
    width: 300,
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    controller: controller,
    prefixIcon: Icon(Icons.badge_outlined),
    validator: (value) {
      final RegExp idRegExp = RegExp(r'^[a-zA-Z0-9]{4,12}$');
      if (value == null || value.isEmpty) {
        return '아이디를 입력하세요';
      } else if (!idRegExp.hasMatch(value)) {
        return '아이디는 4~12자의 알파벳과 숫자만 포함해야 합니다';
      }
      return null;
    },
  );
}



