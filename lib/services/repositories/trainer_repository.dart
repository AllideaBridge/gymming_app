import 'package:http/http.dart' as http;

import '../models/trainer_detail.dart';

class TrainerRepository {
  TrainerRepository({required this.client});

  final http.Client client;

  static final String baseUrl = "http://10.0.2.2:5000/trainers";

  final TrainerDetail _dummyDetail = TrainerDetail([
    'assets/images/trainerExample.png',
    'assets/images/trainerExample2.png',
    'assets/images/trainerExample3.png',
    'assets/images/trainerExample4.png',
    'assets/images/trainerExample5.png'
  ],
      '김헬스',
      '트레이너',
      '운동에 자신감을 심어드리겠습니다.',
      '방이동',
      'GYMGYM',
      '06:00 ~ 24:00',
      '09:00 ~ 20:00',
      '12',
      '243',
      '前) 포스코대우 사내 휘트니스센터 근무\n前) 알유휘트니스 중동점 근무\n前) 더힐스토리 근무\n19년 WNC 클래식피지크 Tall 2위\n18년 INBA 보디빌딩 -180cm 1위\n17년 NICA 클래식 보디빌딩 -85kg 1위\n17년 NICA 클래식피지크 Tall 2위\n16년 미스터수원 보디빌딩 -85kg 3위\n15년 미스터인천 클래식보디빌딩 -180cm 3위\n14년 미스터인천 보디빌딩 -80kg 3위',
      'NSCA CSCS 미국체력관리협회 체력관리사\nNSCA CPT 미국체력관리협회 퍼스널트레이너\nNSCA FCL (Foundation of Coaching Lifts)\n생활스포츠지도사 2급 (보디빌딩)\nNSCA KOREA 웨이트트레이닝 코치\nNSCA KOREA 재활운동전문가 레벨1\n대한보디빌딩협회 코치아카데미 100기 수료\n대한보디빌딩협회 보디빌딩지도자 자격증\nKAOSA 스포츠마사지 수료\n호텔신라 Assistant Trainer 교육과정 수료(우수상)\n태권도4단\n적십자 응급처치 일반과정 이수',
      '750,000',
      '1,200,000',
      '1,500,000');

  TrainerDetail getTrainerDetail() {
    return _dummyDetail;
  }

  Future<Map<String, dynamic>> getTrainerDetailReal(int trainerId) async {
    Uri url = Uri.parse('$baseUrl/$trainerId');
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   throw Exception(
    //       "api response error occurs: error code = ${response.statusCode}");
    // }
    return {
      'trainer_id': 1,
      'trainer_name': 'Test Trainer',
      'trainer_phone_number': '010-0000-0000',
      'trainer_gender': 'M',
      'trainer_birthday': '2024-08-13',
      'description': 'description',
      'lesson_name': 'lesson_name',
      'lesson_price': 10000,
      'lesson_minutes': 60,
      'lesson_change_range': 3,
      'trainer_email': 'test@example.com',
      'trainer_delete_flag': false,
      'center_name': 'Center',
      'center_location': 'center_location',
      'center_number': '02-555-5555',
      'center_type': '필라테스',
      'trainer_profile_img_url':
          'https://gymming.s3.amazonaws.com/trainer/1/profile?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=FOOBARKEY%2F20240813%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20240813T103649Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=1a0a6f0e2443c1d7f9d19964304cfef2ca10007a722ad95b413e11bf2a407958'
    };
  }
}
