class MarketModel {
  final int _id;
  final String _name;
  final String _detailAddress;
  final double _latitude;
  final double _longitude;
  final String _imageURL;

  MarketModel(int id, String name, String detailAddress, dynamic location,
      String imageURL)
      : _id = id,
        _name = name,
        _detailAddress = detailAddress,
        _latitude = location['latitude'],
        _longitude = location['longitude'],
        _imageURL = imageURL;

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
        json['id'],
        json['name'],
        json['detailAddress'],
        json['location'],
        json['imageURL']);
  }

  int get id => _id;

  String get name => _name;

  String get detailAddress => _detailAddress;

  double get latitude => _latitude;

  double get longitude => _longitude;

  String get imageURL => _imageURL;
}
