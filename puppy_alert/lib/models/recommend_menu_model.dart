class RecommendMenuModel {
  final String _imageUrl, _title, _description;
  final int _difficulty;

  RecommendMenuModel(
      {required String imageUrl,
      required String title,
      required int difficulty,
      required String description})
      : _imageUrl = imageUrl,
        _title = title,
        _difficulty = difficulty,
        _description = description;

  factory RecommendMenuModel.fromJson(Map<String, dynamic> json) {
    return RecommendMenuModel(
      imageUrl: json['imageURL'],
      title: json['menuName'],
      difficulty: int.parse(json['difficulty'].toString()),
      description: json['description'],
    );
  }

  String get url => _imageUrl;

  String get title => _title;

  int get difficulty => _difficulty;

  String get description => _description;
}
