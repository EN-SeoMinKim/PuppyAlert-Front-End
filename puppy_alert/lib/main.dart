import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/login.dart';
import 'package:puppy_alert/screens/signup_children.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PuppyAlert',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LogIn(),
      routes: {
        '/login': (context) => Login(),
        '/signupChildren': (context) => SignupChildren(),
      },
    );
  }
}
