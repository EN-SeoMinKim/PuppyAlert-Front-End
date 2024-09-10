import 'package:flutter/material.dart';
import 'package:puppy_alert/screens/common_screens/login_common_screen.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../../widgets/common_widgets/long_rectangle_button_common_widget.dart';
import '../../widgets/common_widgets/user_date_picker_common_widget.dart';
import '../../widgets/common_widgets/user_text_form_field_common_widget.dart';
import '../../widgets/common_widgets/white_background_button_common_widget.dart';

class SignupCommonScreen extends StatefulWidget {
  final UserType _userType;
  final int _id = 0,
      _password = 1,
      _passwordConfirmation = 2,
      _nickName = 3,
      _name = 4,
      _address = 5,
      _addressDetail = 6,
      _phoneNumber = 7,
      _phoneNumberConfirmation = 8,
      _postcode = 9;

  const SignupCommonScreen({super.key, required userType})
      : _userType = userType;

  @override
  State<SignupCommonScreen> createState() => _SignupCommonScreenState();
}

class _SignupCommonScreenState extends State<SignupCommonScreen> {
  late final GlobalKey<FormState> _allFormKey, _idFormKey, _nickNameFormKey;
  late final List<TextEditingController> _textEditingControllerList;
  DateTime? _birth;

  @override
  void initState() {
    super.initState();
    _allFormKey = GlobalKey<FormState>();
    _idFormKey = GlobalKey<FormState>();
    _nickNameFormKey = GlobalKey<FormState>();
    _textEditingControllerList =
        List.generate(10, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (TextEditingController t in _textEditingControllerList) {
      t.dispose();
    }
    super.dispose();
  }

  void _searchAddress(BuildContext context) async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    _textEditingControllerList[widget._postcode].value = TextEditingValue(
      text: model.zonecode ?? '',
    );
    _textEditingControllerList[widget._address].value = TextEditingValue(
      text: model.address ?? '',
    );
    _textEditingControllerList[widget._addressDetail].value = TextEditingValue(
      text: model.buildingName ?? '',
    );
  }

  void _clickDuplicationButton(bool isId) async {
    GlobalKey<FormState> key;
    Uri uri;
    if (isId) {
      String inputString = _textEditingControllerList[widget._id].text.trim();
      key = _idFormKey;
      uri = Uri.parse('${dotenv.get('BASE_URL')}/user/checkId?id=$inputString');
    } else {
      String inputString =
          _textEditingControllerList[widget._nickName].text.trim();
      key = _nickNameFormKey;
      uri = Uri.parse(
          '${dotenv.get('BASE_URL')}/user/checkNickName?nickName=$inputString');
    }

    if (!_isKeyValid(key)) return;

    // 중복이 없디면 수정 안되게 해주고 중복이 있다면 다른 입력 하라고 스낵바 띄워주삼
    if (jsonDecode((await http.get(uri)).body)['isExists']) {
      // 중복이 있다면
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미 존재하는 ID입니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // 중복이 없는 입력이라면
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사용가능한 ID입니다'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _submitSignUpForm(UserType userType) async {
    if (!_isKeyValid(_idFormKey) ||
        !_isKeyValid(_nickNameFormKey) ||
        !_isKeyValid(_allFormKey)) return;

    List<String> inputTextList = List.generate(
        10, (index) => _textEditingControllerList[index].text.trim());
    List<String> coordinate =
        await _getCoordinate(inputTextList[widget._address]);

    http.post(getUri(userType),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': inputTextList[widget._id],
          'password': inputTextList[widget._password],
          'nickname': inputTextList[widget._nickName],
          'name': inputTextList[widget._name],
          'birth': _birth,
          'address': inputTextList[widget._address],
          'addressDetail': inputTextList[widget._addressDetail],
          'location': {
            'latitude': coordinate[1],
            'longitude': coordinate[0],
          },
          'phoneNumber': inputTextList[widget._phoneNumber],
          'userType': _getUserTypeString(userType),
        }));

    _goLoginScreen();
  }

  bool _isKeyValid(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  Uri getUri(UserType userType) {
    if (userType == UserType.adult) {
      return Uri.parse('${dotenv.get('BASE_URL')}/user/signup');
    }
    return Uri.parse('${dotenv.get('BASE_URL')}/user/signup');
  }

  String _getUserTypeString(UserType userType) {
    if (userType == UserType.adult) {
      return 'HOST';
    }
    return 'PUPPY';
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

  void _goLoginScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return const LoginCommonScreen();
      }),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showIcon = _textEditingControllerList[widget._postcode].text.isEmpty;

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
                                  _textEditingControllerList[widget._id], 230),
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
                          _textEditingControllerList[widget._password]),
                      passwordConfirmationInputWidget(
                          _textEditingControllerList[
                              widget._passwordConfirmation],
                          _textEditingControllerList[widget._password]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Form(
                              key: _nickNameFormKey,
                              child: nicknameInputWidget(
                                  _textEditingControllerList[widget._nickName]),
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
                      nameInputWidget(_textEditingControllerList[widget._name]),
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
                            const SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: _textEditingControllerList[
                                    widget._postcode],
                                decoration: InputDecoration(
                                  hintText: '우편번호',
                                  prefixIcon: showIcon
                                      ? Icon(Icons.location_on_outlined)
                                      : null,
                                ),
                                readOnly: true,
                              ),
                            ),
                            WhiteBackgroundButtonCommonWidget(
                              onPressed: () => _searchAddress(context),
                              text: "우편번호 검색",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller:
                              _textEditingControllerList[widget._address],
                          decoration: const InputDecoration(
                            hintText: '           주소',
                          ),
                          readOnly: true,
                        ),
                      ),
                      addressDetailInputWidget(
                          _textEditingControllerList[widget._addressDetail]),
                      phoneNumberInputWidget(
                          _textEditingControllerList[widget._phoneNumber]),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            phoneNumberConfirmationInputWidget(
                                _textEditingControllerList[
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
                          _submitSignUpForm(widget._userType);
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
                        _goLoginScreen();
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
