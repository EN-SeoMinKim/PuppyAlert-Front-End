import 'package:flutter_naver_map/flutter_naver_map.dart';

class UserModel {
  late String _userId,
      _password,
      _name,
      _nickName,
      _birth,
      _phoneNumber,
      _address,
      _dongAddress,
  _userProfileImageURL;
  late NLatLng _userLatLng;

  UserModel(
      String userId,
      String password,
      String name,
      String nickName,
      String birth,
      String phoneNumber,
      String address,
      Map<String, dynamic> location,
      String userProfileImageURL) {
    _userId = userId;
    _password = password;
    _name = name;
    _nickName = nickName;
    _birth = birth;
    _phoneNumber = phoneNumber;
    _userLatLng = getLatLng(location);
    _address = address;
    _dongAddress = _parsingAddress(address);
    _userProfileImageURL = userProfileImageURL;
  }

  factory UserModel.fromJson(Map<String, dynamic> jsonData, String password) {
    return UserModel(
        jsonData['userId'],
        password,
        jsonData['name'],
        jsonData['nickName'],
        jsonData['birth'],
        jsonData['phoneNumber'],
        jsonData['address'],
        jsonData['location'],
        jsonData['userProfileImageURL']);
  }

  NLatLng getLatLng(Map<String, dynamic> location) {
    return NLatLng(location['latitude'], location['longitude']);
  }

  String _parsingAddress(String address) {
    List<String> splitString = address.split(' ');
    for (String s in splitString) {
      if (s[s.length - 1] == '동') {
        return s;
      }
    }

    if (splitString.length > 2) {
      return splitString[splitString.length - 2];
    }
    return 'NONE';
  }

  NLatLng get userLatLng => _userLatLng;

  String get address => _address;

  String get dongAddress => _dongAddress;

  String get phoneNumber => _phoneNumber;

  String get birth => _birth;

  String get nickName => _nickName;

  String get name => _name;

  String get password => _password;

  String get userId => _userId;

  String get userProfileImageURL => _userProfileImageURL;
}
