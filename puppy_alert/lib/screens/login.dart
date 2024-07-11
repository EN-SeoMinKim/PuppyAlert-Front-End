import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/singup_children.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController loginIdController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFF7700),
      ),
      // id, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
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
              Form(
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.grey,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(color: Color(0xff424856), fontSize: 20.0, fontWeight: FontWeight.w600))),
                    child: Container(
                      padding: EdgeInsets.all(60.0),
                        child: Builder(builder: (context) {
                          return Column(
                            children: [
                              TextField(
                                controller: loginIdController,
                                autofocus: true,
                                decoration: InputDecoration(labelText: '아이디'),
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              TextField(
                                controller: loginPasswordController,
                                decoration:
                                InputDecoration(labelText: '비밀번호'),
                                keyboardType: TextInputType.text,
                                obscureText: true, // 비밀번호 안보이도록 하는 것
                              ),
                              SizedBox(
                                height: 50.0,
                              ),
                              ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (loginIdController.text == 'mei@hello.com' &&
                                          loginPasswordController.text == '1234') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    LoginNextPage()));
                                      }
                                      else if (loginIdController.text == 'mei@hello.com' && loginPasswordController.text != '1234') {
                                        loginShowSnackBar(context, Text('Wrong password'));
                                      }
                                      else if (loginIdController.text != 'mei@hello.com' && loginPasswordController.text == '1234') {
                                        loginShowSnackBar(context, Text('Wrong id'));
                                      }
                                      else {
                                        loginShowSnackBar(context, Text('Check your info again'));
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffFF7700)),
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
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffFF7700),
                                    fontWeight: FontWeight.w500,
                                    height: 0,
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
                                      Navigator.push(context, MaterialPageRoute(builder: (
                                          context) => SignupChildren()));
                                    },
                                    child: Text(
                                      "가입하기",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffFF7700),
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                        letterSpacing: -0.40,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        })),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

void loginShowSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(
    content: text,
    backgroundColor: Color.fromARGB(255, 112, 48, 48),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class LoginNextPage extends StatelessWidget {
  const LoginNextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}