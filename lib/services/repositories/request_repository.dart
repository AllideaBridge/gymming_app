import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/request_list.dart';

class RequestRepository {
  RequestRepository({required this.client});

  final http.Client client;

  static final String baseUrl = "http://10.0.2.2:5000/request";

  Future<List<RequestList>> getRequestList(
      String trainerId, String status) async {
    var url = Uri.parse('$baseUrl/trainer').replace(
        queryParameters: {'trainer_id': trainerId, 'request_status': status});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        final List<dynamic> body = json.decode(response.body);
        final List<RequestList> result = [];
        for (Map<String, dynamic> item in body) {
          result.add(RequestList.fromJson(item));
        }
        return result;
      } catch (e) {
        throw Exception("Failed to load data");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<bool> createRequest(Object body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
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
