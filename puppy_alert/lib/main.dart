import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_screen.dart';
import 'package:puppy_alert/screens/child_screens/signup_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/today_zipbob_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    {
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
        // home:SpeechRecognitionScreen(),
      );
    }
  }
}



