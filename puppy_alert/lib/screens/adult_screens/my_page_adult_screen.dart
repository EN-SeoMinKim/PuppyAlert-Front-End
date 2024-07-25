import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/personal_information_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/food_record_adult_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';

class MyPageAdultScreen extends StatefulWidget {
  const MyPageAdultScreen({super.key});

  @override
  State<MyPageAdultScreen> createState() => _MyPageAdultScreenState();
}

class _MyPageAdultScreenState extends State<MyPageAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFD6BF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              color: const Color(0xffFFD6BF),
              child: Column(children: [
                const SizedBox(height: 30.0),
                ClipOval(
                  child: Image.asset(
                    "assets/image.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Anton',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PersonalInformationAdultScreen()));
                },
                text: "개인 정보"),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FoodRecordAdultScreen()));
                },
                text: "집밥 기록"),
          ],
        ),
      ),
    );
  }
}
