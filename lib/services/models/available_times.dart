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

  static List<AvailableTimes> getDummyAvailableTimesList() {
    return [
      AvailableTimes(time: "07:00", isPossible: true),
      AvailableTimes(time: "07:30", isPossible: true),
      AvailableTimes(time: "08:00", isPossible: false),
      AvailableTimes(time: "08:30", isPossible: false),
      AvailableTimes(time: "09:00", isPossible: true),
      AvailableTimes(time: "09:30", isPossible: true),
      AvailableTimes(time: "10:00", isPossible: false),
      AvailableTimes(time: "10:30", isPossible: false),
      AvailableTimes(time: "11:00", isPossible: false),
      AvailableTimes(time: "11:30", isPossible: false),
      AvailableTimes(time: "12:00", isPossible: true),
      AvailableTimes(time: "12:30", isPossible: true),
      AvailableTimes(time: "13:00", isPossible: true),
      AvailableTimes(time: "13:30", isPossible: false),
      AvailableTimes(time: "14:00", isPossible: false),
      AvailableTimes(time: "14:30", isPossible: true),
      AvailableTimes(time: "15:00", isPossible: true),
      AvailableTimes(time: "15:30", isPossible: true),
      AvailableTimes(time: "16:00", isPossible: true),
      AvailableTimes(time: "16:30", isPossible: false),
      AvailableTimes(time: "17:00", isPossible: false),
      AvailableTimes(time: "17:30", isPossible: true),
      AvailableTimes(time: "18:00", isPossible: false),
      AvailableTimes(time: "18:30", isPossible: false),
      AvailableTimes(time: "19:00", isPossible: true),
      AvailableTimes(time: "19:30", isPossible: true),
      AvailableTimes(time: "20:00", isPossible: false),
      AvailableTimes(time: "20:30", isPossible: false),
      AvailableTimes(time: "21:00", isPossible: true),
      AvailableTimes(time: "21:30", isPossible: true),
    ];
  }
}
