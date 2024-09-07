
class RecommendMenuModel {
  final String _imageUrl, _title, _description;
  final int _level;
  
RecommendMenuModel({required String imageUrl, required String title, required int level, required String description})
      : _imageUrl = imageUrl,
        _title = title,
        _level = level,
        _description = description;

factory RecommendMenuModel.fromJson(Map<String, dynamic> json) {
  return RecommendMenuModel(
    imageUrl: json['imageUrl'],
    title: json['title'],
    level: json['level'],
    description: json['description'],
  );
}

String get url => _imageUrl;

String get title => _title;

int get level => _level;

String get description => _description;
}