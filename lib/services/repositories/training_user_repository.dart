import 'package:gymming_app/services/models/training_user.dart';
import 'package:http/http.dart' as http;

class TrainingUserRepository {
  late final http.Client client;

  static final String baseUrl = "http://10.0.2.2:5000/trainer-user";

  void initClient() {
    client = http.Client();
  }

  Future<List<TrainingUser>> getTrainingUserList(
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
    //     return TrainingUser.parseTrainingUserList(body);
    //   } catch (e) {
    //     throw Exception("Failed to load data : ${e.toString()}");
    //   }
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    return TrainingUser.getDummyTrainingUserList(isPresent);
  }
}
