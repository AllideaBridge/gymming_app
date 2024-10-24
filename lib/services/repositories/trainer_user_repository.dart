import 'dart:convert';

import 'package:gymming_app/services/auth/api_service.dart';
import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/models/trainer_user.dart';

import '../../common/constants.dart';
import '../models/trainer_user_detail.dart';

class TrainerUserRepository extends ApiService {
  static final String baseUrl = "$SERVER_URL/trainer-user";

  Future<bool> connectTrainerUser(
      int trainerId, Map<String, Object> body) async {
    try {
      final response = await makeAuthenticatedRequest(
          'POST', Uri.parse('$baseUrl/trainer/$trainerId/users'),
          body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<TrainerUser>> getTrainerUserList(
      int trainerId, bool isPresent) async {
    final response = await makeAuthenticatedRequest(
        'GET',
        Uri.parse('$baseUrl/trainer/$trainerId/users').replace(
            queryParameters: {
              'trainer_user_delete_flag': isPresent ? "False" : "True"
            }));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body)["results"];
        return TrainerUser.parseTrainerUserList(body);
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  Future<TrainerUserDetail> getTrainerUserDetail(
      int trainerId, int userId) async {
    final response = await makeAuthenticatedRequest(
        'GET', Uri.parse('$baseUrl/trainer/$trainerId/users/$userId'));

    if (response.statusCode == 200) {
      final dynamic body = json.decode(response.body);
      return TrainerUserDetail.fromJson(body);
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  Future<List<TrainerList>> getTrainersListOfUser(int userId) async {
    final response = await makeAuthenticatedRequest(
        'GET', Uri.parse('$baseUrl/user/$userId/trainers'));

    if (response.statusCode == 200) {
      try {
        List<dynamic> result = json.decode(response.body)['results'];
        return TrainerList.parseTrainerListList(result);
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  Future<bool> updateTrainerUser(int trainerId, int userId, Object body) async {
    final response = await makeAuthenticatedRequest(
        'PUT', Uri.parse('$baseUrl/trainer/$trainerId/users/$userId'),
        body: body);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  void deleteTrainerUser(int trainerId, int userId) async {
    final response = await makeAuthenticatedRequest(
        'DELETE', Uri.parse('$baseUrl/trainer/$trainerId/users/$userId'));

    if (response.statusCode == 400) {
      throw Exception(response.body);
    }
  }
}
