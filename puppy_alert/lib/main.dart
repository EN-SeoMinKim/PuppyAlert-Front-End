// import 'package:flutter/material.dart';
// import 'package:puppy_alert/screens/adult_screens/zipbob_record_adult_screen.dart';
// import 'package:puppy_alert/screens/child_screens/zipbob_child_screen.dart';
// import 'package:puppy_alert/screens/child_screens/signup_child_screen.dart';
// import 'package:puppy_alert/screens/child_screens/today_zipbob_child_screen.dart';
// import 'package:puppy_alert/screens/common_screens/login.dart';
// import 'package:puppy_alert/screens/adult_screens/signup_adult_screen.dart';
// import 'package:puppy_alert/screens/speech_screen.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'PuppyAlert',
//         theme: ThemeData(
//           primarySwatch: Colors.orange,
//           appBarTheme: AppBarTheme(
//             backgroundColor: Color(0xffFF7700),
//           )
//         ),
//         home: LoginScreen(),
//         // home:ZipbobChildScreen(),
//         routes:
//         {
//           '/login': (context) => LoginScreen(),
//           '/signup_adult_screen': (context) => SignupAdultScreen(),
//           '/signup_child_screen': (context) => SignupChildScreen(),
//           'record_adult_screen' : (context) => ZipbobRecordAdultScreen(),
//         },
//       );
//     }
//   }
// }
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

void main() {
  runApp(KakaoAddressScreen());
}

class KakaoAddressScreen extends StatelessWidget {
  KakaoAddressScreen({super.key});

  /// Form State
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  /// Controller
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _addressDetailController =
  TextEditingController();

  Widget _gap() {
    return const SizedBox(
      height: 10,
    );
  }

  void _searchAddress(BuildContext context) async {
    KopoModel? model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    if (model != null) {
      final postcode = model.zonecode ?? '';
      _postcodeController.value = TextEditingValue(
        text: postcode,
      );
      formData['postcode'] = postcode;

      final address = model.address ?? '';
      _addressController.value = TextEditingValue(
        text: address,
      );
      formData['address'] = address;

      final buildingName = model.buildingName ?? '';
      _addressDetailController.value = TextEditingValue(
        text: buildingName,
      );
      formData['address_detail'] = buildingName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kakao 주소검색 API'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _postcodeController,
                    decoration: const InputDecoration(
                      hintText: '우편번호',
                    ),
                    readOnly: true,
                  ),
                  _gap(),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: '기본주소',
                    ),
                    readOnly: true,
                  ),
                  _gap(),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _addressDetailController,
                    decoration: const InputDecoration(
                      hintText: '상세주소 입력',
                    ),
                  ),
                  _gap(),
                  CupertinoButton(
                    onPressed: () => _searchAddress(context),
                    child: const Text('주소검색'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}