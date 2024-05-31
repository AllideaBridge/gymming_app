import 'dart:convert';

import 'package:gymming_app/services/models/lesson_list.dart';
import 'package:gymming_app/services/models/schedule_detail.dart';
import 'package:gymming_app/services/models/schedule_training_user.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/utils/date_util.dart';
import 'package:http/http.dart' as http;

import '../models/available_times.dart';

class ScheduleRepository {
  ScheduleRepository({required this.client});

  final http.Client client;

  static final int dummyUserId = 1;
  static final int dummyTrainerId = 1;
  static final String typeMonth = 'month';
  static final String typeDay = 'day';
  static final String typeWeek = 'week';
  static final String baseUrl = "http://10.0.2.2:5000/schedules";

  /*
    스케쥴 상세조회
    URL: schedules/<schedule_id>
   */
  Future<ScheduleDetail> getScheduleDetail(int scheduleId) async {
    Uri url = Uri.parse('$baseUrl/$scheduleId');
    return ScheduleDetail.getDummyScheduleDetail();
    // final response = await client.get(url);
    // if (response.statusCode == 200) {
    //   try {
    //     return ScheduleDetail.fromJson(json.decode(response.body)["result"]);
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
  }

  /*
    회원의 한달 별 스케쥴 조회
    URL: schedules/<user_id>?day=date&type=month
   */
  Future<Set<String>> getScheduleByMonth(DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/user/$dummyUserId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeMonth
    });
    return ScheduleUser.getDummyMonthlyScheduleList();
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

  /*
    회원의 하루 중 스케쥴 조회
    URL: schedules/<user_id>?day=date&type=day
   */
  Future<List<ScheduleUser>> getScheduleByDay(DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/user/$dummyUserId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeDay
    });

    return ScheduleUser.getDummyScheduleDetailList();
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

  /*
    회원의 하루 중 트레이너 별 예약 가능한 시간 조회
    URL: schedules/trainer/<trainer_id>?date=date&type=day
   */
  static Future<List<AvailableTimes>> getAvailableTimeListByTrainerIdAndDate(
      int trainerId, DateTime datetime) async {
    Uri url =
        Uri.parse('$baseUrl/trainer/$trainerId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeDay,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        List<dynamic> result = json.decode(response.body)['result'];
        return AvailableTimes.getAvailableTimesList(result);
      } catch (e) {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  /*
    트레이너의 일주일 스케줄 조회
    URL: schedules/trainer/<trainer_id>?date=date&type=week
   */
  Future<List<LessonList>> getTrainerScheduleByWeek(DateTime datetime) async {
    Uri url =
        Uri.parse('$baseUrl/trainer/$dummyTrainerId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeWeek,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        return LessonList.parseLessonListList(json.decode(response.body));
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  /*
    스케줄 수정
    URL: schedules/<schedule_id>
    body: {
      id: String,
      start_time: String(YYYY-MM-DDTHH:MM:SS)
      status: String (MODIFIED/CANCELED)
    }
   */
  static Future<bool> updateSchedule(int scheduleId, String time) async {
    var url = Uri.parse('$baseUrl/$scheduleId');
    return true;
    // final response = await http.put(
    //   url,
    //   body: json.encode({
    //     'id': scheduleId,
    //     'start_time': time,
    //     'status': 'MODIFIED',
    //   }),
    //   headers: {
    //     'Content-Type': 'application/json', // Content-Type 설정
    //   },
    // );
    //
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  /*
    스케줄 삭제
    URL: schedules/<schedule_id>
   */
  Future<bool> cancelSchedule(int scheduleId) async {
    var url = Uri.parse('$baseUrl/$scheduleId');
    return true;
    // final response = await http.delete(url);
    // if (response.statusCode != 200) {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    // final dynamic body = json.decode(response.body);
    // if (body["message"] == "Schedule cancel successfully") {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  /*
    트레이너의 회원관리 상세에서 한달 스케쥴 조회
    URL: schedules/trainer/<trainer_id>/users/<user_id>?date=date&type=month
   */
  Future<List<ScheduleTrainingUser>> getTrainingUserScheduleByMonth(
      DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/trainer/$dummyTrainerId/users/$dummyUserId')
        .replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeMonth
    });
    return ScheduleTrainingUser.getDummyTrainingUserMonthlyScheduleList();
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
}
