import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// import 'package:remedi_kopo/remedi_kopo.dart';
import '../../utils/constants.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';
import '../../widgets/common_widgets/user_date_picker_common_widget.dart';
import '../../widgets/common_widgets/user_text_form_field_common_widget.dart';
import '../../widgets/common_widgets/white_background_button_common_widget.dart';

class SignupScreen extends StatefulWidget {
  final int _id = 0,
      _password = 1,
      _passwordConfirmation = 2,
      _nickName = 3,
      _name = 4,
      _address = 5,
      _addressDetail = 6,
      _phoneNumber = 7,
      _phoneNumberConfirmation = 8;

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final GlobalKey<FormState> _allFormKey, _idFormKey, _nickNameFormKey;
  late final List<TextEditingController> _textEditingController;
  DateTime? _birth;

  @override
  void initState() {
    super.initState();
    _allFormKey = GlobalKey<FormState>();
    _idFormKey = GlobalKey<FormState>();
    _nickNameFormKey = GlobalKey<FormState>();
    _textEditingController = List.generate(9, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (TextEditingController t in _textEditingController) {
      t.dispose();
    }
    super.dispose();
  }

  void _clickDuplicationButton(bool isId) async {
    GlobalKey<FormState> key;
    Uri uri;
    if (isId) {
      key = _idFormKey;
      String inputString = _textEditingController[widget._id].text.trim();
      uri =
          Uri.parse('${dotenv.get('BASE_URL')}/common/checkId?id=$inputString');
    } else {
      key = _nickNameFormKey;
      String inputString = _textEditingController[widget._nickName].text.trim();
      uri = Uri.parse(
          '${dotenv.get('BASE_URL')}/common/checkNickName?nickName=$inputString');
    }

    if (!_isKeyValid(key)) return;

    // 중복이 없디면 수정 안되게 해주고 중복이 있다면 다른 입력 하라고 스낵바 띄워주삼
    // 중복이 없는 입력이라면
    if (!jsonDecode((await http.get(uri)).body)['isExists']) {
    } else {
      // 중복이 있다면
    }
  }

  void _submitSignUpForm(Object arguments) async {
    if (!_isKeyValid(_idFormKey) ||
        !_isKeyValid(_nickNameFormKey) ||
        !_isKeyValid(_allFormKey)) return;

    Uri uri = getUri(arguments);
    List<String> inputString =
        List.generate(9, (index) => _textEditingController[index].text.trim());
    List<String> coordinate =
        await _getCoordinate(inputString[widget._address]);

    http.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': inputString[widget._id],
          'password': inputString[widget._password],
          'name': inputString[widget._name],
          'birth': _birth,
          'phoneNumber': inputString[widget._phoneNumber],
          'address': inputString[widget._address],
          'location': {
            'latitude': coordinate[1],
            'longitude': coordinate[0],
          },
        }));

    Navigator.of(context).pushNamedAndRemoveUntil('/login_screen', (route) => false,);
  }

  bool _isKeyValid(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  Uri getUri(Object arguments) {
    if (arguments == User.adult) {
      return Uri.parse('${dotenv.get('BASE_URL')}/host/signup');
    }
    return Uri.parse('${dotenv.get('BASE_URL')}/puppy/signup');
  }

  Future<List<String>> _getCoordinate(String address) async {
    Map<String, String> header = {
      'X-NCP-APIGW-API-KEY-ID': dotenv.get('NAVER_API_ID'),
      'X-NCP-APIGW-API-KEY': dotenv.get('NAVER_API_SECRET')
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=$address'),
        headers: header);

    var jsonData = jsonDecode(response.body);
    String longitude = jsonData['addresses'][0]['y'];
    String latitude = jsonData['addresses'][0]['x'];
    return [longitude, latitude];
  }

  @override
  Widget build(BuildContext context) {
    final Object arguments = ModalRoute.of(context)!.settings.arguments!;

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _allFormKey,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Center(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Form(
                              key: _idFormKey,
                              child: idInputWidget(
                                  _textEditingController[widget._id], 230),
                            ),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: () {
                                _clickDuplicationButton(true);
                              },
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      passwordInputWidget(
                          _textEditingController[widget._password]),
                      passwordConfirmationInputWidget(
                          _textEditingController[widget._passwordConfirmation],
                          _textEditingController[widget._password]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Form(
                              key: _nickNameFormKey,
                              child: nicknameInputWidget(
                                  _textEditingController[widget._nickName]),
                            ),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: () {
                                _clickDuplicationButton(false);
                              },
                              text: "중복확인",
                            ),
                          ],
                        ),
                      ),
                      nameInputWidget(_textEditingController[widget._name]),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 10),
                                Icon(Icons.date_range, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  '생년월일',
                                  style: TextStyle(
                                    color: Color(0xff424856),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            UserDatePickerCommonWidget(onDateSelected: (date) {
                              setState(() {
                                if (date != null) {
                                  _birth = date;
                                }
                              });
                            }),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            addressInputWidget(
                                _textEditingController[widget._address]),
                            WhiteBackgroundButtonCommonWidget(
                              // ========== remedi_kopo api ========== //
                              // onPressed: () async {
                              //   KopoModel model = await Navigator.push(
                              //     context,
                              //     CupertinoPageRoute(
                              //       builder: (context) => RemediKopo(),
                              //     ),
                              //   );
                              // },
                              onPressed: () {},
                              text: "우편번호 검색",
                            ),
                          ],
                        ),
                      ),
                      addressDetailInputWidget(
                          _textEditingController[widget._addressDetail]),
                      phoneNumberInputWidget(
                          _textEditingController[widget._phoneNumber]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phoneNumberConfirmationInputWidget(
                                _textEditingController[
                                    widget._phoneNumberConfirmation]),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: () {},
                              text: "인증번호확인",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      LongRectangleButtonCommonWidget(
                        onPressed: () {
                          _submitSignUpForm(arguments);
                        },
                        text: "회원가입",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 있으신가요?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login_screen', (route) => false);
                      },
                      child: const Text(
                        "로그인하기",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffFF7700),
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
