import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/food_record_screen.dart';
import 'package:puppy_alert/widgets/adult_widgets/elevated_shadow_button_adult_widget.dart';
import '../../widgets/common_widgets/my_page_header_common_widget.dart';
import '../common_screens/personal_information_screen.dart';

class MyPageAdultScreen extends StatefulWidget {
  const MyPageAdultScreen({super.key});

  @override
  State<MyPageAdultScreen> createState() => _MyPageAdultScreenState();
}

class _MyPageAdultScreenState extends State<MyPageAdultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const MyPageHeaderCommonWidget(imagePath: 'assets/image.png', userName: 'Anton'),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PersonalInformationScreen()));
                },
                text: "개인 정보"),
            const SizedBox(
              height: 20,
            ),
            ElevatedShadowButtonAdultWidget(
              width: 200,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FoodRecordScreen(isChildScreen: false)));
                },
                text: "집밥 기록"),
          ],
        ),
      ),
    );
  }
}
