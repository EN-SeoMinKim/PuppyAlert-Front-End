import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppy_alert/provider/food_provider.dart';
import 'package:puppy_alert/screens/child_screens/main_child_screen.dart';

void main() async {
  runApp(const MyApp());
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
        home: ChangeNotifierProvider<FoodProvider>(
          create: (context) => FoodProvider(),
          child: const MainChildScreen(),
        ));
  }
}
