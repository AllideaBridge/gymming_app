class ChangeTicket {
  final int _requestId;
  final String _userName;
  final String _requestType;
  final DateTime _asIsDate;
  final DateTime? _toBeDate;
  final DateTime _createdAt;
  final String _requestStatus;
  final String _userProfileImage;
  final String _userMessage;
  final String? _trainerMessage;

  ChangeTicket(
    this._requestId,
    this._userName,
    this._requestType,
    this._asIsDate,
    this._toBeDate,
    this._createdAt,
    this._requestStatus,
    this._userProfileImage,
    this._userMessage,
    this._trainerMessage,
  );

  int get requestId => _requestId;

  String get userName => _userName;

  String get requestType => _requestType;

  DateTime get asIsDate => _asIsDate;

  DateTime get toBeDate => _toBeDate!;

  DateTime get createdAt => _createdAt;

  String get requestStatus => _requestStatus;

  String get userProfileImage => _userProfileImage;

  String get userMessage => _userMessage;

  String get trainerMessage => _trainerMessage!;

  factory ChangeTicket.fromJson(Map<String, dynamic> json) {
    return ChangeTicket(
        json["request_id"],
        json["user_name"],
        json["request_type"],
        DateTime.parse(json["as_is_date"]),
        json["to_be_date"] == '' ? null : DateTime.parse(json["to_be_date"]),
        DateTime.parse(json["created_at"]),
        json["request_status"],
        json["user_profile_image"],
        json["user_message"],
        json["trainer_message"] == '' ? null : json["trainer_message"]);
  }

  static List<ChangeTicket> parseChangeTicketList(List<dynamic> body) {
    final List<ChangeTicket> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(ChangeTicket.fromJson(item));
    }
    return result;
  }
}
