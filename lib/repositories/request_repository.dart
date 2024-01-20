import '../models/request_list.dart';

class RequestRepository {
  final List<RequestList> _dummyRequests = [
    RequestList(
        profileImg: 'assets/trainerExample.png',
        name: '김헬스',
        originDay: '8월 6일 09:00',
        changeDay: '8월 7일 20:00',
        requestDay: '24.01.17. 20:32'),
    RequestList(
        profileImg: 'assets/trainerExample2.png',
        name: '이헬스',
        originDay: '8월 8일 09:00',
        changeDay: '8월 10일 02:00',
        requestDay: '24.01.18. 12:01'),
    RequestList(
        profileImg: 'assets/trainerExample3.png',
        name: '박헬스',
        originDay: '8월 12일 09:00',
        changeDay: '8월 16일 21:00',
        requestDay: '24.01.12. 06:18'),
    RequestList(
        profileImg: 'assets/trainerExample4.png',
        name: '최헬스',
        originDay: '8월 13일 09:00',
        changeDay: '8월 14일 10:00',
        requestDay: '24.01.20. 14:48'),
    RequestList(
        profileImg: 'assets/trainerExample5.png',
        name: '고헬스',
        originDay: '8월 19일 09:00',
        changeDay: '8월 19일 13:00',
        requestDay: '24.01.30. 20:23'),
    RequestList(
        profileImg: 'assets/trainerExample6.png',
        name: '고헬스',
        originDay: '8월 21일 08:30',
        changeDay: '8월 26일 18:00',
        requestDay: '24.01.11. 17:41'),
    RequestList(
        profileImg: 'assets/trainerExample.png',
        name: '한헬스',
        originDay: '8월 21일 07:00',
        changeDay: '8월 23일 06:00',
        requestDay: '24.01.13. 09:59'),
  ];

  List<RequestList> getRequestList() {
    return _dummyRequests;
  }
}