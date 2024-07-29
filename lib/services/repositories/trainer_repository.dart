import '../models/trainer_detail.dart';

class TrainerRepository {
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
}
