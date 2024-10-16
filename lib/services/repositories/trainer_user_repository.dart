import 'dart:convert';

import 'package:gymming_app/services/auth/api_service.dart';
import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/models/trainer_user.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../models/trainer_user_detail.dart';

class TrainerUserRepository extends ApiService {
  late final http.Client client;

  static final String baseUrl = "$SERVER_URL/trainer-user";

  void initClient() {
    client = http.Client();
  }

  Future<bool> connectTrainerUser(
      int trainerId, Map<String, Object> body) async {
    print("body");
    print(body);
    try {
      final response = await makeAuthenticatedRequest(
          'POST', Uri.parse('$baseUrl/trainer/$trainerId/users'),
          body: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("회원 등록 실패");
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
              'training_user_delete_flag': isPresent ? "true" : "false"
            }));

    // Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users')
    //     .replace(queryParameters: {
    //   'training_user_delete_flag': isPresent ? "true" : "false",
    // });
    // initClient();
    // final response = await client.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body)["results"];
        print("getTrainerUserList");
        print(body);
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

    // Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users/$userId');
    // initClient();
    // final response = await client.get(url);
    if (response.statusCode == 200) {
      try {
        final dynamic body = json.decode(response.body);
        return TrainerUserDetail.fromJson(body);
      } catch (e) {
        throw Exception("Failed to load data : ${e.toString()}");
      }
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
    Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users/$userId');
    final response = await http.put(
      url,
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
