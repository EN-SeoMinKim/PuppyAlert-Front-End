import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/home_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import '../../widgets/common_widgets/custom_user_text_style.dart';
import '../../widgets/common_widgets/user_textformfield.dart';
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
                        idInputWidget((controller) {
                          _idController = controller;
                        }),
                        passwordInputWidget((controller) {
                          _passwordController = controller;
                        }),
                        SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _submitLoginForm();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomeAdultScreen()));
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
                                _showChoiceDialog();
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


// typedef ControllerCallback = void Function(TextEditingController controller);

Widget idInputWidget(ControllerCallback controllerCallback) {
  TextEditingController loginIdController = TextEditingController();

  controllerCallback(loginIdController);

  return UserTextFormField(
    width: 300,
    hintText: "아이디를 입력하세요",
    labelText: "아이디",
    textInputType: TextInputType.text,
    actionKeyboard: TextInputAction.done,
    // functionValidate: commonValidation,
    controller: loginIdController,
    // focusNode: _passwordControllerFocus,
    onSubmitField: () {},
    // parametersValidate: "Please enter password.",
    prefixIcon: Icon(Icons.badge_outlined),
  );
}



