import 'dart:convert';

import 'package:gymming_app/common/constants.dart';
import 'package:gymming_app/services/auth/api_service.dart';
import 'package:gymming_app/services/models/available_times.dart';
import 'package:gymming_app/services/models/lesson_list.dart';
import 'package:gymming_app/services/models/schedule_detail.dart';
import 'package:gymming_app/services/models/schedule_trainer_user.dart';
import 'package:gymming_app/services/models/schedule_user.dart';
import 'package:gymming_app/services/utils/date_util.dart';

class ScheduleRepository extends ApiService {
  static final String typeMonth = 'month';
  static final String typeDay = 'day';
  static final String typeWeek = 'week';
  static final String baseUrl = "$SERVER_URL/schedules";

  /*
    스케줄 생성
    URL: schedules
    body: {
      user_id: String,
      trainer_id: String,
      start_time: String(YYYY-MM-DDTHH:MM:SS)
   */
  Future<String> createSchedule(
      int userId, int trainerId, String startTime) async {
    var url = Uri.parse(baseUrl);

    final response = await makeAuthenticatedRequest('POST', url, headers: {
      "Content-Type": "application/json",
    }, body: {
      'user_id': userId,
      'trainer_id': trainerId,
      'schedule_start_time': startTime
    });

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  /*
    스케쥴 상세 조회
    URL: schedules/<schedule_id>
   */
  Future<ScheduleDetail> getScheduleDetail(int scheduleId) async {
    Uri url = Uri.parse('$baseUrl/$scheduleId');

    final response = await makeAuthenticatedRequest('GET', url);

    if (response.statusCode == 200) {
      try {
        return ScheduleDetail.fromJson(json.decode(response.body)["result"]);
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
      status: String (MODIFIED)
    }
   */
  Future<String> updateSchedule(int scheduleId, String time) async {
    var url = Uri.parse('$baseUrl/$scheduleId');
    final response = await makeAuthenticatedRequest(
      'PUT',
      url,
      body: {
        'id': scheduleId,
        'start_time': time,
        'status': 'MODIFIED',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  /*
    스케줄 삭제
    URL: schedules/<schedule_id>
   */
  Future<String> cancelSchedule(int scheduleId) async {
    var url = Uri.parse('$baseUrl/$scheduleId');
    final response = await makeAuthenticatedRequest('DELETE', url);
    if (response.statusCode == 200) {
      return (json.decode(response.body)["message"]);
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  /*
    회원의 한달 별 스케쥴 조회
    URL: schedules/users/<user_id>?day=date&type=month
   */
  Future<Set<String>> getScheduleByMonth(int userId, DateTime datetime) async {
    var url = Uri.parse('$baseUrl/user/$userId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeMonth
    });

    final response = await makeAuthenticatedRequest('GET', url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> result = json.decode(response.body)["result"];
        return result.map((item) => item.toString()).toSet();
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  /*
    회원의 하루 중 스케쥴 조회
    URL: schedules/users/<user_id>?day=date&type=day
   */
  Future<List<ScheduleUser>> getScheduleByDay(
      int userId, DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/user/$userId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeDay
    });

    final response = await makeAuthenticatedRequest('GET', url);

    if (response.statusCode == 200) {
      try {
        List<dynamic> result = json.decode(response.body)['result'];
        return ScheduleUser.parseScheduleDetailList(result);
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  /*
    회원의 하루 중 트레이너 별 예약 가능한 시간 조회
    URL: schedules/trainer/<trainer_id>?date=date&type=day
   */
  Future<List<AvailableTimes>> getAvailableTimeListByTrainerIdAndDate(
      int trainerId, DateTime datetime) async {
    var url =
        Uri.parse('$baseUrl/trainer/$trainerId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeDay,
    });

    final response = await makeAuthenticatedRequest('GET', url);

    if (response.statusCode == 200) {
      try {
        List<dynamic> result = json.decode(response.body)['result'];
        return AvailableTimes.getAvailableTimesList(result);
      } catch (e) {
        throw Exception('Failed to load data');
      }
    } else {
      throw "api response error occurs: error code = ${response.statusCode}";
    }
  }

  /*
    트레이너의 일주일 스케줄 조회
    URL: schedules/trainer/<trainer_id>?date=date&type=week
   */
  Future<List<LessonList>> getTrainerScheduleByWeek(
      DateTime datetime, int trainerId) async {
    var url =
        Uri.parse('$baseUrl/trainer/$trainerId').replace(queryParameters: {
      'date': DateUtil.convertDateTimeWithDash(datetime),
      'type': typeWeek,
    });

    final response = await makeAuthenticatedRequest("GET", url);

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
    트레이너의 회원관리 상세에서 한달 스케쥴 조회
    URL: schedules/trainer/<trainer_id>/users/<user_id>?date=date&type=month
   */
  Future<Set<ScheduleTrainerUser>> getTrainerUserScheduleByMonth(
      int trainerId, int userId, DateTime datetime) async {
    Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users/$userId').replace(
        queryParameters: {
          'date': DateUtil.convertDateTimeWithDash(datetime),
          'type': typeMonth
        });

    final response = await makeAuthenticatedRequest('GET', url);

    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body)["result"];
        return ScheduleTrainerUser.parseScheduleTrainingUserList(body);
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }
}
