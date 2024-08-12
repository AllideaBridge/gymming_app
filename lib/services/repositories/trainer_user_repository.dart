import 'dart:convert';

import 'package:gymming_app/services/models/trainer_list.dart';
import 'package:gymming_app/services/models/trainer_user.dart';
import 'package:http/http.dart' as http;

import '../models/trainer_user_detail.dart';

class TrainerUserRepository {
  late final http.Client client;

  static final String baseUrl = "http://10.0.2.2:5000/trainer-user";

  void initClient() {
    client = http.Client();
  }

  Future<bool> connectTrainerUser(int trainerId, Object body) async {
    Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users');
    final response = await http.post(
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

  Future<List<TrainerUser>> getTrainerUserList(
      int trainerId, bool isPresent) async {
    Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users')
        .replace(queryParameters: {
      'training_user_delete_flag': isPresent ? "true" : "false",
    });
    // initClient();
    // final response = await client.get(url);
    // if (response.statusCode == 200) {
    //   try {
    //     final List<dynamic> body = json.decode(response.body)["result"];
    //     return TrainerUser.parseTrainerUserList(body);
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    return TrainerUser.getDummyTrainerUserList(isPresent);
  }

  Future<TrainerUserDetail> getTrainerUserDetail(
      int trainerId, int userId) async {
    // Uri url = Uri.parse('$baseUrl/trainer/$trainerId/users/$userId');
    // initClient();
    // final response = await client.get(url);
    // if (response.statusCode == 200) {
    //   try {
    //     final dynamic body = json.decode(response.body);
    //     return TrainerUserDetail.fromJson(body);
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    return TrainerUserDetail.getDummyTrainerUserDetail();
  }

  Future<List<TrainerList>> getTrainersListOfUser(int userId) async {
    Uri uri = Uri.parse('$baseUrl/user/$userId/trainers');
    initClient();
    final response = await client.get(uri);
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
}
