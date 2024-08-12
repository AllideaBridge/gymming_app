import 'package:http/http.dart' as http;

class UserRepository {
  UserRepository({required this.client});

  final http.Client client;

  static final String baseUrl = "http://10.0.2.2:5000/users";

  Future<Map<String, dynamic>> checkUserExist(
      String userName, String userPhoneNumber) async {
    Uri url = Uri.parse('$baseUrl/check').replace(queryParameters: {
      'user_name': userName,
      'user_phone_number': userPhoneNumber
    });

    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   return json.decode(response.body)['result'];
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    return {'exists': true, 'user_id': 1};
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
}
