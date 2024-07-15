import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/signup_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';

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
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffFF7700),
        )
      ),
      home: LoginScreen(),
      // initialRoute: RouteName.login,
      routes:
      {
        '/login': (context) => LoginScreen(),
        '/signup_adult_screen': (context) => SignupAdultScreen(),
        '/signup_child_screen': (context) => SignupChildScreen(),
      },
    );
  }
}
