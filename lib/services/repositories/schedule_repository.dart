import 'dart:convert';

import '../models/schedule_info.dart';
import 'package:http/http.dart' as http;


class ScheduleRepository {
  ScheduleRepository({required this.client});

  final http.Client client;

  static final int dummyUserId = 1;

  final String baseUrl = "http://10.0.2.2:5000/schedules/$dummyUserId";

  Future<Set<String>> fetchScheduleByMonth(DateTime dateTime) async {
    final int year = dateTime.year;
    final int month = dateTime.month;
    var url = Uri.parse('$baseUrl/$year/$month');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final List body = json.decode(response.body);
      return body.map((item) => item.toString()).toSet();
    } else {
      throw Exception("failed to load schedule by month");
    }
  }

  Future<List<ScheduleInfo>> fetchScheduleByDay(DateTime datetime) async {
    var url = Uri.parse(
        '$baseUrl/${datetime.year}/${datetime.month}/${datetime.day}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      final List<ScheduleInfo> result = [];
      for (Map<String, dynamic> item in body) {
        ScheduleInfo schedule = ScheduleInfo(
            DateTime.parse(item["schedule_start_time"]),
            DateTime.parse(item["schedule_start_time"]), //todo endTime
            item["lesson_name"],
            item["trainer_name"],
            item["center_name"],
            item["center_location"],
            5); //todo remain time 계산하기
        result.add(schedule);
      }
      return result;
    } else {
      throw Exception("api response error occurs");
    }
  }
}
