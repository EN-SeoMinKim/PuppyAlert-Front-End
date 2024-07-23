import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button.dart';

class FoodRegistrationCompletionAdultScreen extends StatefulWidget {
  const FoodRegistrationCompletionAdultScreen({super.key});

  @override
  State<FoodRegistrationCompletionAdultScreen> createState() => _FoodRegistrationCompletionAdultScreenState();
}

class _FoodRegistrationCompletionAdultScreenState extends State<FoodRegistrationCompletionAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(child: Text('똥강아지\n모집완료!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: Colors.red,
              ))),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'food.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '비빔밥\n 18:00',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          ElevatedShadowButton(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {},
              text: "취소"),
        ],
      ),
    );
  }
}


