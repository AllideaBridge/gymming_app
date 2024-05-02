import 'dart:convert';

import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;

import '../models/available_times.dart';
import '../models/schedule_detail.dart';

class ScheduleRepository {
  ScheduleRepository({required this.client});

  final http.Client client;

  static final int dummyUserId = 1;
  static final String typeMonth = 'month';
  static final String typeDay = 'day';
  static final String baseUrl = "http://10.0.2.2:5000/schedules";

  Future<Set<String>> getScheduleByMonth(DateTime dateTime) async {
    Uri url = Uri.parse('$baseUrl/$dummyUserId').replace(queryParameters: {
      'datetime': DateUtil.convertDateTimeWithDash(dateTime),
      'type': typeMonth
    });

    final response = await client.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body)["dates"];
        return body.map((item) => item.toString()).toSet();
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "Failed to load data : status code is ${response.statusCode}");
    }
  }

  Future<List<ScheduleDetail>> getScheduleByDay(DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/$dummyUserId').replace(queryParameters: {
      'datetime': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeDay
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        return ScheduleDetail.parseScheduleDetailList(
            json.decode(response.body));
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "Failed to load data : status code is ${response.statusCode}");
    }
  }

  static Future<AvailableTimes> getAvailableTimeListByTrainerIdAndDate(
      String trainerId, int year, int month, int day) async {
    final response = await http
        .get(Uri.parse('$baseUrl/trainer/$trainerId/$year/$month/$day'));
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
    final response = await http.post(
      Uri.parse('$baseUrl/$scheduleId/change'),
      body: json.encode({'start_time': time}),
      headers: {
        'Content-Type': 'application/json', // Content-Type 설정
      },
    );

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
