import 'dart:convert';
import 'dart:io';

import '../auth/api_service.dart';
import '../models/change_ticket.dart';

class ChangeTicketRepository extends ApiService {
  // TODO 로컬 URL에서 변경 필요
  final String baseUrl = "http://10.0.2.2:5000/change-ticket";

  Future<List<ChangeTicket>> getTrainerChangeTicketList(
      int trainerId, String status, int page) async {
    var url = Uri.parse('$baseUrl/trainer/$trainerId')
        .replace(queryParameters: {'status': status, 'page': page.toString()});

    final response = await makeAuthenticatedRequest(
      'GET',
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

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

    final response = await makeAuthenticatedRequest(
      'GET',
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      try {
        return ChangeTicket.parseChangeTicketList(json.decode(response.body));
      } catch (e) {
        throw Exception("Error Occurs : ${e.toString()}");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<bool> createChangeTicket(Object body) async {
    final response = await makeAuthenticatedRequest(
      'POST',
      Uri.parse(baseUrl),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyChangeTicket(int changeTicketId, Object body) async {
    print(body);
    final response = await makeAuthenticatedRequest(
      'PUT',
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

  Future<bool> deleteChangeTicket(int changeTicketId) async {
    try {
      final response = await makeAuthenticatedRequest(
          'DELETE', Uri.parse('$baseUrl/$changeTicketId'),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        throw Exception('Failed to delete change ticket');
      }
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
