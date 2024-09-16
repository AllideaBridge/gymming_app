import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/change_ticket.dart';

class ChangeTicketRepository {
  ChangeTicketRepository({required this.client});

  final http.Client client;

  // TODO 로컬 URL에서 변경 필요
  final String baseUrl = "http://10.0.2.2:5000/change-ticket";

  Future<List<ChangeTicket>> getTrainerChangeTicketList(
      int trainerId, String status, int page) async {
    var url = Uri.parse('$baseUrl/trainer/$trainerId')
        .replace(queryParameters: {'status': status, 'page': page.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        return ChangeTicket.parseChangeTicketList(json.decode(response.body));
      } catch (e) {
        throw Exception("Failed to load data");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<ChangeTicket>> getUserChangeTicketList(
      int userId, String status, int page) async {
    var url = Uri.parse('$baseUrl/user/$userId')
        .replace(queryParameters: {'status': status, 'page': page.toString()});

    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        return ChangeTicket.parseChangeTicketList(json.decode(response.body));
      } catch (e) {
        throw Exception("Failed to load data");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<bool> createChangeTicket(Object body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyChangeTicket(int changeTicketId, Object body) async {
    print(body);
    final response = await http.put(
      Uri.parse('$baseUrl/$changeTicketId'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    //400 예외가 나오는 경우 메세지
    // "Schedule is not changeable.Lesson change range overflow. schedule_id : *"

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
