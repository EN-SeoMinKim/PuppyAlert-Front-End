class Zipbob {
  final String imagePath;
  final String zipbobName;
  final String hostName;
  final String time;
  final String recruitmentStatus;
  final bool isFavorite; // 이거는 다른 table에 있는 정보임

  Zipbob({
    required this.imagePath,
    required this.zipbobName,
    required this.hostName,
    required this.time,
    required this.recruitmentStatus,
    required this.isFavorite,
  });

  factory Zipbob.fromJson(Map<String, dynamic> json) {
    return Zipbob(
      imagePath: json['imagePath'],
      zipbobName: json['zipbobName'],
      hostName: json['hostName'],
      time: json['time'],
      recruitmentStatus: json['recruitmentStatus'],
      isFavorite: json['isFavorite'],
    );
  }
}
