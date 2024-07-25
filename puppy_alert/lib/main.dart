import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/main_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/signup_screen.dart';
import 'package:puppy_alert/screens/common_screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

void main() async {
  await _initNaverMap();
  runApp(const MyApp());
}

Future<void> _initNaverMap() async {
  await dotenv.load(fileName: '.env');
  String id = dotenv.get('NAVER_API_ID');

  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: id, onAuthFailed: (error) => print('Auth failed: $error'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PuppyAlert',
        theme: ThemeData(
            primarySwatch: Colors.orange,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffFF7700),
            )),
        initialRoute: '/login_screen',
        routes: {
          '/login_screen': (context) => const LoginScreen(),
          '/signup_screen': (context) => const SignupScreen(),
          '/speech_recognition_screen': (context) => const SpeechRecognitionScreen(),
          '/main_child_screen': (context) => const MainChildScreen(),
        });
  }
}
