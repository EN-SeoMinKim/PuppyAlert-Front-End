class FoodModel {
  late int _foodId;
  late String _hostId,
      _menu,
      _time,
      _imageURL,
      _address,
      _addressDetail,
      _status;
  late Map<String, Map<String, String>> _locationMap;

  FoodModel(
      {required int foodId,
      required String hostId,
      required String menu,
      required String time,
      required String imageURL,
      required String address,
      required String addressDetail,
      required String status,
      required Map<String, Map<String, String>> locationMap})
      : _foodId = foodId,
        _hostId = hostId,
        _menu = menu,
        _time = time,
        _imageURL = imageURL,
        _address = address,
        _addressDetail = addressDetail,
        _status = status,
        _locationMap = locationMap;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        foodId: json['foodId'],
        hostId: json['hostId'],
        menu: json['menu'],
        time: json['time'],
        imageURL: json['imageURL'],
        address: json['address'],
        addressDetail: json['addressDetail'],
        status: json['status'],
        locationMap: json['locationMap']);
  }

  int get foodId => _foodId;

  String get hostId => _hostId;

  String get menu => _menu;

  String get time => _time;

  String get imageURL => _imageURL;

  String get address => _address;

  String get addressDetail => _addressDetail;

  String get status => _status;

  Map<String, Map<String, String>> get locationMap => _locationMap;
}
