import '../models/trainee_list.dart';

class TraineeRepository {
  final List<TraineeList> _dummyTrainees = [
    TraineeList(
      name: '김헬스',
      profileImg: 'assets/trainerExample.png',
      weekday: '월, 수, 금',
      usedDay: 3,
      totalDay: 10,
      registeredDay: '23.10.20',
      lastDay: '23.10.20',
    ),
    TraineeList(
      name: '조헬스',
      profileImg: 'assets/trainerExample2.png',
      weekday: '월, 수',
      usedDay: 6,
      totalDay: 10,
      registeredDay: '23.11.10',
      lastDay: '23.11.10',
    ),
    TraineeList(
      name: '이헬스',
      profileImg: 'assets/trainerExample3.png',
      weekday: '금',
      usedDay: 0,
      totalDay: 10,
      registeredDay: '23.04.08',
      lastDay: '23.04.08',
    ),
    TraineeList(
      name: '박헬스',
      profileImg: 'assets/trainerExample.png',
      weekday: '월, 수, 금',
      usedDay: 3,
      totalDay: 10,
      registeredDay: '23.10.20',
      lastDay: '23.10.20',
    ),
    TraineeList(
      name: '임헬스',
      profileImg: 'assets/trainerExample2.png',
      weekday: '월, 수',
      usedDay: 6,
      totalDay: 10,
      registeredDay: '23.11.10',
      lastDay: '23.11.10',
    ),
    TraineeList(
      name: '최헬스',
      profileImg: 'assets/trainerExample3.png',
      weekday: '금',
      usedDay: 0,
      totalDay: 10,
      registeredDay: '23.04.08',
      lastDay: '23.04.08',
    ),
  ];

  List<TraineeList> getTraineeList() {
    return _dummyTrainees;
  }
}
