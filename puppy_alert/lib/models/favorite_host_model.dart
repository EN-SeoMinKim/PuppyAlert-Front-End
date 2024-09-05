class FavoriteHostModel {
  final String _hostNickName;
  final String _recentFoodTime;
  final String _hostProfileImageURL;
  final String _hostId;

  FavoriteHostModel(
      {required String hostNickName,
      required String recentFoodTime,
      required String hostProfileImageURL,
      required String hostId})
      : _hostNickName = hostNickName,
        _recentFoodTime = recentFoodTime,
        _hostProfileImageURL = hostProfileImageURL,
        _hostId = hostId;

  factory FavoriteHostModel.fromJson(Map<String, dynamic> json) {
    if (json['recentFoodTime'] == null) {
      return FavoriteHostModel(
          hostNickName: json['hostNickName'],
          recentFoodTime: '함꼐 식사한 기록이 없습니다',
          hostProfileImageURL: json['hostProfileImageURL'],
          hostId: json['hostId']);
    }

    List<String> timeSplit = json['recentFoodTime'].split('T');
    String monthDay =
        '${timeSplit[0].split('-')[1]}/${timeSplit[0].split('-')[2]}';
    String hourMinute =
        '${timeSplit[1].split(':')[0]}:${timeSplit[1].split(':')[1]}';

    json['recentFoodTime'] = '$monthDay $hourMinute';

    return FavoriteHostModel(
        hostNickName: json['hostNickName'],
        recentFoodTime: json['recentFoodTime'],
        hostProfileImageURL: json['hostProfileImageURL'],
        hostId: json['hostId']);
  }

  String get hostNickName => _hostNickName;

  String get recentFoodTime => _recentFoodTime;

  String get hostProfileImageURL => _hostProfileImageURL;

  String get hostId => _hostId;
}
