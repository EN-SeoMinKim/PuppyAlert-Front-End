class FoodModel {
  late final int _foodId;
  late final String _hostId,
      _hostNickName,
      _menuName,
      _time,
      _imageURL,
      _address,
      _addressDetail,
      _status;
  var _locationMap;

  FoodModel(
      {required int foodId,
      required String hostNickName,
      required String hostId,
      required String menu,
      required String time,
      required String imageURL,
      required String address,
      required String addressDetail,
      required String status,
      required var locationMap}) {
    _foodId = foodId;
    _hostId = hostId;
    _hostNickName = hostNickName;
    _menuName = menu;
    _time = _parsingTime(time);
    _imageURL = imageURL;
    _address = address;
    _addressDetail = addressDetail;
    _status = status;
    _locationMap = locationMap;
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    String status = json['status'] == null ? 'MATCHED' : 'READY';
    String partnerId = json['partnerId'] ?? json['hostId'];
    String partnerNickName = json['partnerNickName'] ?? json['hostNickName'];
    String time = json['localDateTime'] ?? json['time'];

    return FoodModel(
        foodId: json['foodId'],
        hostId: partnerId,
        hostNickName: partnerNickName,
        menu: json['menuName'],
        time: time,
        imageURL: json['imageURL'],
        address: json['address'],
        addressDetail: json['detailAddress'],
        status: status,
        locationMap: json['location']);
  }

  String _parsingTime(String time) {
    List<String> timeSplit = time.split('T');
    String monthDay =
        '${timeSplit[0].split('-')[1]}/${timeSplit[0].split('-')[2]}';
    String hourMinute =
        '${timeSplit[1].split(':')[0]}:${timeSplit[1].split(':')[1]}';
    return '$monthDay $hourMinute';
  }

  int get foodId => _foodId;

  String get hostId => _hostId;

  String get hostNickName => _hostNickName;

  String get menuName => _menuName;

  String get time => _time;

  String get imageURL => _imageURL;

  String get address => _address;

  String get addressDetail => _addressDetail;

  String get status => _status;

  get locationMap => _locationMap;
}
