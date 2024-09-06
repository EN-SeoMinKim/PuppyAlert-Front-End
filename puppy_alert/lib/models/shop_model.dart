class ShopModel {
  final String _name;
  final String _detailAddress;
  final String _productType;

  ShopModel(String name, String detailAddress, String productType)
      : _name = name,
        _detailAddress = detailAddress,
        _productType = productType;

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(json['shopName'], json['detailAddress'], json['productType']);
  }

  String get name => _name;

  String get detailAddress => _detailAddress;

  String get productType => _productType;
}
