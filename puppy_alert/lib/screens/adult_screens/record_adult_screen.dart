import 'package:flutter/material.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/user_textformfield_widget.dart';

class RecordAdultScreen extends StatefulWidget {
  const RecordAdultScreen({super.key});

  @override
  _RecordAdultScreenState createState() => _RecordAdultScreenState();
}

class _RecordAdultScreenState extends State<RecordAdultScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmationController =
  TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _addressController.dispose();
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
                      child: Text('집밥기록',
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
                        // idInputWidget((controller) {
                        //   _idController = controller;
                        // }),
                        passwordInputWidget((controller) {
                          _passwordController = controller;
                        }),
                        passwordConfirmationInputWidget((controller) {
                          _passwordConfirmationController = controller;
                        }),
                        // nicknameInputWidget((controller) {
                        //   _nicknameController = controller;
                        // }),
                        // nameInputWidget((controller) {
                        //   _nameController = controller;
                        // }),
                        addressInputWidget((controller) {
                          _addressController = controller;
                        }),
                        // phonenumberInputWidget((controller) {
                        //   _phonenumberController = controller;
                        // }),
                        SizedBox(
                          height: 20,
                        ),
                        LongRectangleButton(
                            onPressed: _submitSignUpForm,
                            text:   "수정하기"
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )));
  }

  void _submitSignUpForm() {

    String password = _passwordController.text.trim();
    String passwordConfirmation = _passwordConfirmationController.text.trim();
    String address = _addressController.text.trim();


    print('Password: $password');
    print('Address: $address');
  }
}

Widget userContainer(){
  return Container(
    margin: EdgeInsets.only(top: 50),
    width: 300,
    child: Column(
        children: [
          Text(
              'asdf',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              )
          ),
          Text(
              'asdf',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              )
          ),
        ]
    ),
  );
}
