class FoodModel {
  late int _foodId;
  late String _hostId,
      _menuName,
      _time,
      _imageURL,
      _address,
      _addressDetail,
      _status;
  late var _locationMap;

  FoodModel(
      {required int foodId,
      required String hostId,
      required String menu,
      required String time,
      required String imageURL,
      required String address,
      required String addressDetail,
      required String status,
      required var locationMap})
      : _foodId = foodId,
        _hostId = hostId,
        _menuName = menu,
        _time = time,
        _imageURL = imageURL,
        _address = address,
        _addressDetail = addressDetail,
        _status = status,
        _locationMap = locationMap;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    List<String> timeSplit = json['time'].split('T');
    String monthDay =
        '${timeSplit[0].split('-')[1]}/${timeSplit[0].split('-')[2]}';
    String hourMinute =
        '${timeSplit[1].split(':')[0]}:${timeSplit[1].split(':')[1]}';

    json['time'] = '$monthDay $hourMinute';
    return FoodModel(
        foodId: json['foodId'],
        hostId: json['hostId'],
        menu: json['menuName'],
        time: json['time'],
        imageURL: json['imageURL'],
        address: json['address'],
        addressDetail: json['detailAddress'],
        status: json['status'],
        locationMap: json['locationMap']);
  }

  int get foodId => _foodId;

  String get hostId => _hostId;

  String get menu => _menuName;

  String get time => _time;

  String get imageURL => _imageURL;

  String get address => _address;

  String get addressDetail => _addressDetail;

  String get status => _status;

  get locationMap => _locationMap;
}
