import 'package:gymming_app/models/trainer_list.dart';

class TrainerRepository {
  final List<TrainerList> _dummyTrainers = [
    TrainerList(
        name: '김헬스',
        position: '트레이너',
        profileImg: 'trainer_example.png',
        location: '방이동',
        centerName: 'GYMGYM',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: '09:00 ~ 20:00'),
    TrainerList(
        name: '이헬스',
        position: '트레이너',
        profileImg: 'trainer_example2.png',
        location: '흑석동',
        centerName: '무브짐',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: ''),
    TrainerList(
        name: '박헬스',
        position: '매니저',
        profileImg: 'trainer_example3.png',
        location: '상도동',
        centerName: '코리아짐',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: '09:00 ~ 20:00'),
    TrainerList(
        name: '최헬스',
        position: '수석트레이너',
        profileImg: 'trainer_example4.png',
        location: '이태원동',
        centerName: '세인트짐',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: ''),
    TrainerList(
        name: '고헬스',
        position: '매니저',
        profileImg: 'trainer_example5.png',
        location: '송파동',
        centerName: '바디소울짐',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: '09:00 ~ 20:00'),
    TrainerList(
        name: '신헬스',
        position: '지점장',
        profileImg: 'trainer_example6.png',
        location: '방이동',
        centerName: '더드림피트니스',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: ''),
    TrainerList(
        name: '한헬스',
        position: '트레이너',
        profileImg: 'trainer_example.png',
        location: '송현동',
        centerName: '에이블짐',
        weekdayTime: '06:00 ~ 24:00',
        weekendTime: '09:00 ~ 20:00'),
  ];

  List<TrainerList> getTrainerList() {
    return _dummyTrainers;
  }
}
