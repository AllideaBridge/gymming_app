class TrainerList {
  final int _trainerId;
  final String _trainerName;
  final String _trainerProfileImgUrl;
  final int _lessonTotalCount;
  final int _lessonCurrentCount;
  final String _centerName;
  final String _centerLocation;

  TrainerList(
    this._trainerId,
    this._trainerName,
    this._trainerProfileImgUrl,
    this._lessonTotalCount,
    this._lessonCurrentCount,
    this._centerName,
    this._centerLocation,
  );

  String get centerLocation => _centerLocation;

  String get centerName => _centerName;

  int get lessonCurrentCount => _lessonCurrentCount;

  int get lessonTotalCount => _lessonTotalCount;

  String get trainerProfileImgUrl => _trainerProfileImgUrl;

  String get trainerName => _trainerName;

  int get trainerId => _trainerId;

  factory TrainerList.fromJson(Map<String, dynamic> json) {
    return TrainerList(
        json["trainer_id"],
        json["trainer_name"],
        json["trainer_profile_img_url"],
        json["lesson_total_count"],
        json["lesson_current_count"],
        json["center_name"],
        json["center_location"]);
  }

  static List<TrainerList> parseTrainerListList(Map<String, dynamic> body) {
    final List<TrainerList> result = [];
    for (Map<String, dynamic> item in body["result"]) {
      result.add(TrainerList.fromJson(item));
    }
    return result;
  }
}
