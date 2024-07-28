class UserDto {
  late String _userId,
      _password,
      _name,
      _nickName,
      _birth,
      _phoneNumber,
      _address;
  late Map<String, dynamic> _location;

  UserDto(
      String userId,
      String password,
      String name,
      String nickName,
      String birth,
      String phoneNumber,
      String address,
      Map<String, dynamic> location) {
    _userId = userId;
    _password = password;
    _name = name;
    _nickName = nickName;
    _birth = birth;
    _phoneNumber = phoneNumber;
    _address = address;
    _location = location;
  }

  Map<String, dynamic> get location => _location;

  String get address => _address;

  String get phoneNumber => _phoneNumber;

  String get birth => _birth;

  String get nickName => _nickName;

  String get name => _name;

  String get password => _password;

  String get userId => _userId;
}
