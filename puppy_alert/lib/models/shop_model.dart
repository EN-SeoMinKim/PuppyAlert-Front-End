class ShopModel {
  final String _name;
  final String _detailAddress;
  final String _productType;
  final String _imageURL;

  const ShopModel(
      String name, String detailAddress, String productType, String imageURL)
      : _name = name,
        _detailAddress = detailAddress,
        _productType = productType,
        _imageURL = imageURL;

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    String name = json['shopName'];
    String detailAddress = json['detailAddress'];
    String productType = json['productType'];
    String imageURL = '';

    switch (productType) {
      case '정육':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/15537/15537281.png';
        break;
      case '슈퍼':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/5432/5432814.png';
        break;
      case '떡':
        imageURL =
            'https://icons.veryicon.com/png/o/culture/chinese-new-year-of-dog/rice-cake.png';
        break;
      case '야채':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/2153/2153786.png';
        break;
      case '반찬':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/14451/14451393.png';
        break;
      case '농산물':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/4344/4344464.png';
        break;
      case '과일':
        imageURL = 'https://cdn-icons-png.flaticon.com/128/415/415682.png';
        break;
      case '수산물':
        imageURL = 'https://cdn-icons-png.flaticon.com/512/4293/4293130.png';
        break;
    }
    return ShopModel(name, detailAddress, productType, imageURL);
  }

  String get name => _name;

  String get detailAddress => _detailAddress;

  String get productType => _productType;

  String get imageURL => _imageURL;
}
