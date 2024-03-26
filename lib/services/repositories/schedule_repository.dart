import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/available_times.dart';

class ScheduleRepository {
  static Future<AvailableTimes> getAvailableTimeListByTrainerIdAndDate(
      String trainerId, int year, int month, int day) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:5000/schedules/trainer/$trainerId/$year/$month/$day'));
    if (response.statusCode == 200) {
      try {
        return AvailableTimes.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
