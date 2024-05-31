import '../models/trainee_detail.dart';

class TraineeRepository {
  final TraineeDetail _dummyTrainee = TraineeDetail(
      profileImg: 'assets/images/trainerExample3.png',
      name: '김헬스',
      birth: '1998.08.08',
      gender: '여',
      weekDay: '월, 수',
      usedDay: 3,
      totalDay: 10,
      registeredDay: '23.10.08',
      phoneNumber: '010 - 1234 - 1234',
      lessonDay: [
        DateTime(2024, 2, 1),
        DateTime(2024, 2, 5),
        DateTime(2024, 2, 8),
        DateTime(2024, 2, 11),
        DateTime(2024, 2, 12),
        DateTime(2024, 2, 14),
        DateTime(2024, 2, 19),
        DateTime(2024, 2, 21),
        DateTime(2024, 2, 22),
      ],
      specificDetail: "체중 증량이 목표");

  TraineeDetail getTraineeDetail() {
    return _dummyTrainee;
  }
}
