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

    print(response.body);
    if (response.statusCode == 200) {
      try {
        return ChangeTicket.parseChangeTicketList(json.decode(response.body));
      } catch (e) {
        throw Exception("Error Occurs : ${e.toString()}");
      }
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<int> createChangeTicket(Object body) async {
    final response = await makeAuthenticatedRequest(
      'POST',
      Uri.parse(baseUrl),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['change_ticket_id'];
    } else {
      throw Exception("create change ticket failed.");
    }
  }

  Future<bool> modifyChangeTicket(int changeTicketId, Object body) async {
    final response = await makeAuthenticatedRequest(
      'PUT',
      Uri.parse('$baseUrl/$changeTicketId'),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      print("400 Exception occurs :  " + response.body);
      return false;
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
      rethrow;
    }
  }
}
