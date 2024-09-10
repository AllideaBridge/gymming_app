class ChangeTicket {
  final int _changeTicketId;
  final String? _userName;
  final String? _trainerName;
  final String _changeTicketType;
  final DateTime _asIsDate;
  final DateTime? _toBeDate;
  final DateTime _createdAt;
  final String _changeTicketStatus;
  final String _userMessage;
  final String? _trainerMessage;

  ChangeTicket(
      this._changeTicketId,
      this._userName,
      this._trainerName,
      this._changeTicketType,
      this._asIsDate,
      this._toBeDate,
      this._createdAt,
      this._changeTicketStatus,
      this._userMessage,
      this._trainerMessage);

  int get changeTicketId => _changeTicketId;

  String? get userName => _userName;

  String? get trainerName => _trainerName;

  String get changeTicketType => _changeTicketType;

  DateTime get asIsDate => _asIsDate;

  DateTime get toBeDate => _toBeDate!;

  DateTime get createdAt => _createdAt;

  String get changeTicketStatus => _changeTicketStatus;

  String get userMessage => _userMessage;

  String get trainerMessage => _trainerMessage!;

  factory ChangeTicket.fromJson(Map<String, dynamic> json) {
    return ChangeTicket(
        json["id"],
        json["user_name"],
        json["trainer_name"],
        json["change_ticket_type"],
        DateTime.parse(json["as_is_date"]),
        json["to_be_date"] == '' ? null : DateTime.parse(json["to_be_date"]),
        DateTime.parse(json["created_at"]),
        json["change_ticket_status"],
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
