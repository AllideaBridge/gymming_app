import 'package:flutter/material.dart';

class InfoState with ChangeNotifier {
  int? userId;
  int? trainerId;

  // 유저 ID 업데이트
  void setUserId(int id) {
    userId = id;
    notifyListeners();
  }

  // 트레이너 ID 업데이트
  void setTrainerId(int id) {
    trainerId = id;
    notifyListeners();
  }

  // 로그아웃 시 상태 초기화
  void clear() {
    userId = null;
    trainerId = null;
    notifyListeners();
  }
}
