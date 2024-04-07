import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/available_times.dart';
import '../models/schedule_info.dart';

class ScheduleRepository {
  ScheduleRepository({required this.client});

  final http.Client client;

  static final int dummyUserId = 1;

  static final String baseUrl = "http://10.0.2.2:5000/schedules";

  Future<Set<String>> getScheduleByMonth(DateTime dateTime) async {
    final int year = dateTime.year;
    final int month = dateTime.month;

    var url = Uri.parse('$baseUrl/$dummyUserId/$year/$month');

    final response = await client.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body)["dates"];
        return body.map((item) => item.toString()).toSet();
      } catch (e) {
        throw Exception("Failed to load data");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<ScheduleInfo>> getScheduleByDay(DateTime datetime) async {
    var url = Uri.parse(
        '$baseUrl/$dummyUserId/${datetime.year}/${datetime.month}/${datetime.day}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body);
        final List<ScheduleInfo> result = [];
        for (Map<String, dynamic> item in body) {
          result.add(ScheduleInfo.fromJson(item));
        }
        return result;
      } catch (e) {
        throw Exception("Failed to load data");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<AvailableTimes> getAvailableTimeListByTrainerIdAndDate(
      String trainerId, int year, int month, int day) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/trainer/$trainerId/$year/$month/$day'));
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

  static Future<bool> updateSchedule(int scheduleId, String time) async {
    final response = await http.post(Uri.parse('$baseUrl/$scheduleId/change')
        .replace(queryParameters: {'request_time': time}));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cancelSchedule(int scheduleId) async {
    var url = Uri.parse('$baseUrl/$scheduleId/cancel');
    final response = await http.post(url);
    if (response.statusCode != 200) {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
    final dynamic body = json.decode(response.body);
    if (body["message"] == "Schedule cancel successfully") {
      return true;
    } else {
      return false;
    }
  }
}
