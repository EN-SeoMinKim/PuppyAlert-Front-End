import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/personal_information_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/meal_record_adult_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button.dart';

class MypageAdultScreen extends StatefulWidget {
  const MypageAdultScreen({super.key});

  @override
  State<MypageAdultScreen> createState() => _MypageAdultScreenState();
}

class _MypageAdultScreenState extends State<MypageAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFD6BF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
              color: Color(0xffFFD6BF),
              child: Column(children: [
                SizedBox(height: 30.0),
                ClipOval(
                  child: Image.asset(
                    "image.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Anton',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedShadowButton(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonalInformationAdultScreen()));
                },
                text: "개인 정보"),
            SizedBox(
              height: 20,
            ),
            ElevatedShadowButton(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MealRecordAdultScreen()));
                },
                text: "집밥 기록"),
          ],
        ),
      ),
    );
  }
}