class AvailableTimes {
  final String _time;
  final bool _isPossible;

  AvailableTimes(this._time, this._isPossible);

  String get time => _time;

  bool get isPossible => _isPossible;

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(
      json['time'],
      json['possible'],
    );
  }

  static List<AvailableTimes> getAvailableTimesList(List<dynamic> body) {
    final List<AvailableTimes> result = [];
    for (Map<String, dynamic> item in body) {
      result.add(AvailableTimes.fromJson(item));
    }
    return result;
  }
}
