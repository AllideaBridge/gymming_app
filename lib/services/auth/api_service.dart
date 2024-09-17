import 'dart:convert';
import 'dart:io';

import 'package:gymming_app/services/auth/token_manager_service.dart';
import 'package:http/http.dart' as http;

import '../../common/exceptions.dart';

class ApiService {
  final TokenManagerService _tokenManager = TokenManagerService.instance;

  Future<http.Response> makeAuthenticatedRequest(
    String method,
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    int retryCount = 0,
  }) async {
    // 액세스 토큰의 유효성 확인 및 갱신
    if (!await _tokenManager.isAccessTokenValid()) {
      bool isRefreshed = await _tokenManager.refreshAccessToken();
      if (!isRefreshed) {
        print('토큰 갱신 실패. 재로그인이 필요합니다.');
        throw TokenRefreshFailedException();
      }
    }

    final accessToken = await _tokenManager.getAccessToken();

    final defaultHeaders = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final mergedHeaders = {...defaultHeaders, if (headers != null) ...headers};

    final response = http.Request(method, url)
      ..headers.addAll(mergedHeaders)
      ..body = jsonEncode(body);

    final streamedResponse = await response.send();
    final httpResponse = await http.Response.fromStream(streamedResponse);

    if (httpResponse.statusCode == HttpStatus.unauthorized && retryCount < 3) {
      print('401 응답을 받았습니다. 토큰 갱신을 시도합니다.');
      bool isRefreshed = await _tokenManager.refreshAccessToken();
      if (isRefreshed) {
        return await makeAuthenticatedRequest(
          method,
          url,
          headers: headers,
          body: body,
          retryCount: retryCount + 1,
        );
      }
    }

    return httpResponse;
  }
}
