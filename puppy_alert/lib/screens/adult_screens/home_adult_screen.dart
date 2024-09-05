import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/adult_screens/food_input_form_adult_screen.dart';
import 'package:puppy_alert/screens/adult_screens/speech_recognition_adult_screen.dart';

class HomeAdultScreen extends StatelessWidget {
  final String _userId;

  const HomeAdultScreen({super.key, required userId}) : _userId = userId;

  void _showChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Center(
              child: Text(
            "등록 방법 선택",
            style: TextStyle(
                color: Color(0xff646464),
                fontWeight: FontWeight.w700,
                fontSize: 20),
          )),
          content: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return FoodInputFormAdultScreen();
                          // }));
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=>FoodInputFormAdultScreen())
                          );


                        },
                        label: const Icon(
                          Icons.sticky_note_2_outlined,
                          size: 50,
                          color: Color(0xffFF7700),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFEADB),
                            shape: const CircleBorder(),
                            minimumSize: const Size(75, 75))),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "수기 등록",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xffFF7700)),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SpeechRecognitionAdultScreen(
                                userId: _userId);
                          }));
                        },
                        label: const Icon(
                          Icons.keyboard_voice_outlined,
                          size: 50,
                          color: Color(0xffFF7700),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFEADB),
                            shape: const CircleBorder(),
                            minimumSize: const Size(75, 75))),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "음성 등록",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xffFF7700)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          children: [
            Stack(
              children: [
                Container(height: 350, width: 300),
                Positioned(
                  top: 50,
                  child: Container(
                    width: 300,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 50,
                          left: 60,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffCDE9FF),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 40,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffFFF1CE),
                          ),
                        ),
                        Positioned(
                          top: 200,
                          left: 30,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffFFCDCD),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          right: 50,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xffFFE0BE),
                          ),
                        ),
                        Positioned(
                            top: 80,
                            left: 90,
                            child: Text(
                              "   같이\n식사해요!",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        elevation: 5,
                        backgroundColor: const Color(0xffFFFAEA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "메뉴 등록",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff474747)),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.arrow_forward, color: Color(0xff474747)),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 35),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Stack(
                  children: [
                    SizedBox(height: 150, width: 150),
                    Positioned(
                      top: 20,
                      right: 10,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xffCEFFF8),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 10,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Color(0xffEACDFF),
                      ),
                    ),
                    Positioned(
                        top: 30,
                        left: 50,
                        child: Icon(Icons.menu_book_outlined,
                            size: 60, color: Color(0xff474747))),
                    Positioned(
                        top: 100,
                        left: 37,
                        child: Text(
                          "메뉴 추천",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff474747)),
                        ))
                  ],
                ))
          ],
        ))
      ],
    );
  }
}
