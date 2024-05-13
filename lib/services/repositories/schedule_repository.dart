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
      'dateTime': DateUtil.convertDateTimeWithDash(dateTime),
      'type': typeMonth
    });
    return ScheduleDetail.getDummyMonthlyScheduleList();
    // final response = await client.get(url);
    // if (response.statusCode == 200) {
    //   try {
    //     final List<dynamic> body = json.decode(response.body)["result"];
    //     return body.map((item) => item.toString()).toSet();
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
  }

  Future<List<ScheduleDetail>> getScheduleByDay(DateTime dateTime) async {
    Uri url = Uri.parse('$baseUrl/$dummyUserId').replace(queryParameters: {
      'dateTime': DateUtil.convertDateTimeWithDash(dateTime),
      'type': typeDay
    });

    return ScheduleDetail.getDummyScheduleDetailList();
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   try {
    //     List<dynamic> body = json.decode(response.body)['result'];
    //     return ScheduleDetail.parseScheduleDetailList(body);
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
  }

  static Future<List<AvailableTimes>> getAvailableTimeListByTrainerIdAndDate(
      String trainerId, DateTime dateTime) async {
    Uri uri =
        Uri.parse('$baseUrl/trainer/$trainerId').replace(queryParameters: {
      'datetime': DateUtil.convertDateTimeWithDash(dateTime),
      'type': typeDay,
    });

    return AvailableTimes.getDummyAvailableTimesList();
    // final response = await http.get(uri);
    // if (response.statusCode == 200) {
    //   try {
    //     return AvailableTimes.getAvailableTimesList(json.decode(response.body));
    //   } catch (e) {
    //     throw Exception('Failed to load data');
    //   }
    // } else {
    //   throw Exception('Failed to load data');
    // }
  }

  static Future<bool> updateSchedule(int scheduleId, String time) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$scheduleId'),
      body: json.encode({
        'id': scheduleId,
        'start_time': time,
        'status': 'MODIFIED', //todo 변경 필요함
      }),
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
    var url = Uri.parse('$baseUrl/$scheduleId');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
    final dynamic body = json.decode(response.body);
    if (body["message"] == "Schedule cancel successfully") {
      //todo 변경 필요함
      return true;
    } else {
      return false;
    }
  }
}
