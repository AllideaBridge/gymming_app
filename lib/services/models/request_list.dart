class RequestList {
  final String _userName;
  final String _requestType;
  final DateTime? _requestTime;
  final DateTime _createdAt;
  final DateTime _scheduleStartTime;
  final int _requestId;
  final String _requestStatus;
  final String _userProfileImg;

  RequestList(
    this._userName,
    this._requestType,
    this._requestTime,
    this._createdAt,
    this._scheduleStartTime,
    this._requestId,
    this._requestStatus,
    this._userProfileImg,
  );

  String get userName => _userName;

  String get requestType => _requestType;

  DateTime get requestTime => _requestTime!;

  DateTime get createdAt => _createdAt;

  DateTime get scheduleStartTime => _scheduleStartTime;

  int get requestId => _requestId;

  String get requestStatus => _requestStatus;

  String get userProfileImg => _userProfileImg;

  factory RequestList.fromJson(Map<String, dynamic> json) {
    return RequestList(
      json["user_name"],
      json["request_type"],
      json["request_time"] == '' ? null : DateTime.parse(json["request_time"]),
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["schedule_start_time"]),
      json["request_id"],
      json["request_status"],
      'assets/images/trainerExample.png',
    );
  }
}
