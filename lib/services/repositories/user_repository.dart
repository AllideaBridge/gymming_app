import 'dart:convert';
import 'dart:io';

import 'package:gymming_app/services/auth/api_service.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../models/user_detail.dart';

class UserRepository extends ApiService {
  UserRepository({required this.client});

  final http.Client client;

  static final String baseUrl = "$SERVER_URL/users";

  Future<Map<String, dynamic>?> checkUserExist(
      String userName, String userPhoneNumber) async {
    final response = await makeAuthenticatedRequest(
        "GET",
        Uri.parse('$baseUrl/check').replace(queryParameters: {
          'user_name': userName,
          'user_phone_number': userPhoneNumber
        }));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          "api response error occurs: error code = ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> getUserDetail(int userId) async {
    Uri url = Uri.parse('$baseUrl/$userId');

    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }

    return {
      "user_id": 1,
      "user_email": null,
      "user_name": "김운동",
      "user_gender": "F",
      "user_phone_number": "010-1234-1234",
      "user_profile_img_url": null,
      "user_delete_flag": false,
      "user_birthday": "1993-07-10"
    };
  }

  Future<UserDetail> updateUser(UserDetail userInfo) async {
    try {
      final response = await makeAuthenticatedRequest(
          'PUT', Uri.parse('$baseUrl/${userInfo.userId}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "user_name": userInfo.userName,
            "user_phone_number": userInfo.userPhoneNumber,
            "user_birthday": userInfo.userBirthday,
            "user_gender": userInfo.userGender
          }));

      if (response.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        UserDetail userDetail = UserDetail.fromJson(responseData);
        return userDetail;
      } else {
        throw Exception('Failed to update user info');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
