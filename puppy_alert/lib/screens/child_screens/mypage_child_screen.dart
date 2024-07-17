import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/child_screens/personal_information_child_screen.dart';
import 'package:puppy_alert/widgets/child_widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/common_widgets/long_rectangle_button.dart';
import '../../widgets/common_widgets/profile_info_button.dart';
import '../common_screens/login.dart';

class MypageChildScreen extends StatefulWidget {
  const MypageChildScreen({super.key});

  @override
  State<MypageChildScreen> createState() => _MypageChildScreenState();
}

class _MypageChildScreenState extends State<MypageChildScreen> {
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
            ProfileInfoButton(
                icon: Icons.manage_accounts,
                text: '   개인 정보',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PersonalInformationChildScreen()));
                }),
            ProfileInfoButton(
                icon: Icons.library_books, text: '   집밥 기록', onPressed: () {}),
            ProfileInfoButton(
                icon: Icons.rice_bowl, text: '   오늘의 집밥', onPressed: () {}),
            LongRectangleButton(
                backgroundColor: Colors.grey[100]!,
                textColor: Colors.grey[700]!,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                text: "Logout"),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}
