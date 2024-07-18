import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/screens/adult_screens/meal_record_adult_screen.dart';
import 'package:puppy_alert/screens/child_screens/meal_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/signup_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/today_meal_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await _initNaverMap();
  runApp(MyApp());
}

Future<void> _initNaverMap() async {
  await dotenv.load(fileName: '.env');
  String id = dotenv.get('CLIENT_ID');

  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: id,
  );
}

class MyApp extends StatelessWidget {
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
        // home: LoginScreen(),
        home:MealChildScreen(),
        routes:
        {
          '/login': (context) => LoginScreen(),
          '/signup_adult_screen': (context) => SignupAdultScreen(),
          '/signup_child_screen': (context) => SignupChildScreen(),
          'record_adult_screen' : (context) => MealRecordAdultScreen(),
        },
      );
    }
  }

}

