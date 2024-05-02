

class AvailableTimes {
  final String time;
  final bool isPossible;

  AvailableTimes({required this.time, required this.isPossible});

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(
      time: json['time'],
      isPossible: json['isPossible'],
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
