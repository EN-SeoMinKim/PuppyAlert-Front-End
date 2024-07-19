import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/zipbob_record_adult_screen.dart';
import 'package:puppy_alert/screens/child_screens/zipbob_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/signup_child_screen.dart';
import 'package:puppy_alert/screens/child_screens/today_zipbob_child_screen.dart';
import 'package:puppy_alert/screens/common_screens/login.dart';
import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
import 'package:puppy_alert/screens/speech_screen.dart';


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
        // home: LoginScreen(),
        home:ZipbobChildScreen(),
        routes:
        {
          '/login': (context) => LoginScreen(),
          '/signup_adult_screen': (context) => SignupAdultScreen(),
          '/signup_child_screen': (context) => SignupChildScreen(),
          'record_adult_screen' : (context) => ZipbobRecordAdultScreen(),
        },
      );
    }
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Home(),
//     );
//   }
// }
//
// class Home extends StatelessWidget {
//   final FlutterTts tts = FlutterTts();
//   final TextEditingController controller =
//   TextEditingController(text: '음식을 말해주세요');
//
//   Home({super.key}) {
//     tts.setLanguage('kor');
//     tts.setSpeechRate(0.4);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: controller,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               tts.speak(controller.text);
//             },
//             child: Text('Speak'),
//           )
//         ],
//       ),
//     );
//   }
// }


