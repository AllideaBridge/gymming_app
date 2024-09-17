import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/exceptions.dart';
import '../../services/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

import '../../state/info_state.dart';
import '../gymbie/gymbie_home/gymbie_home.dart';
import '../gympro/gympro_home/gympro_home.dart';
import '../login/login_select_type.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository authRepository = AuthRepository(client: http.Client());

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    try {
      final Map<String, dynamic> responseData =
          await authRepository.getTokenType();
      // user_id가 있는지 확인
      if (responseData.containsKey('user_id')) {
        int userId = responseData['user_id'];
        Provider.of<InfoState>(context, listen: false).setUserId(userId);
        print('User ID: $userId');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GymbieHome()));
      }
      // trainer_id가 있는지 확인
      else if (responseData.containsKey('trainer_id')) {
        int trainerId = responseData['trainer_id'];
        Provider.of<InfoState>(context, listen: false).setTrainerId(trainerId);
        print('Trainer ID: $trainerId');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => GymproHome()));
      }
      // 둘 다 없을 경우 처리
      else {
        print('Unknown response');
        throw Exception('getTokenType이 다른 응답을 주고 있음.');
      }
    } catch (e) {
      if (e is TokenRefreshFailedException) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginSelectType()));
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 로딩 인디케이터 표시
      ),
    );
  }
}
