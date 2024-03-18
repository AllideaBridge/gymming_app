import '../models/trainee_detail.dart';
import '../models/trainee_list.dart';

class TraineeRepository {
  final List<TraineeList> _dummyTrainees = [
    TraineeList(
      name: '김헬스',
      profileImg: 'assets/images/trainerExample.png',
      weekday: '월, 수, 금',
      usedDay: 3,
      totalDay: 10,
      registeredDay: '23.10.20',
      lastDay: '23.10.20',
    ),
    TraineeList(
      name: '조헬스',
      profileImg: 'assets/images/trainerExample2.png',
      weekday: '월, 수',
      usedDay: 6,
      totalDay: 10,
      registeredDay: '23.11.10',
      lastDay: '23.11.10',
    ),
    TraineeList(
      name: '이헬스',
      profileImg: 'assets/images/trainerExample3.png',
      weekday: '금',
      usedDay: 0,
      totalDay: 10,
      registeredDay: '23.04.08',
      lastDay: '23.04.08',
    ),
    TraineeList(
      name: '박헬스',
      profileImg: 'assets/images/trainerExample.png',
      weekday: '월, 수, 금',
      usedDay: 3,
      totalDay: 10,
      registeredDay: '23.10.20',
      lastDay: '23.10.20',
    ),
    TraineeList(
      name: '임헬스',
      profileImg: 'assets/images/trainerExample2.png',
      weekday: '월, 수',
      usedDay: 6,
      totalDay: 10,
      registeredDay: '23.11.10',
      lastDay: '23.11.10',
    ),
    TraineeList(
      name: '최헬스',
      profileImg: 'assets/images/trainerExample3.png',
      weekday: '금',
      usedDay: 0,
      totalDay: 10,
      registeredDay: '23.04.08',
      lastDay: '23.04.08',
    ),
  ];

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

  List<TraineeList> getTraineeList() {
    return _dummyTrainees;
  }

  TraineeDetail getTraineeDetail() {
    return _dummyTrainee;
  }
}
