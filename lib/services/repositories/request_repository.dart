import '../models/request_list.dart';

class RequestRepository {
  final List<RequestList> _dummyRequests = [
    RequestList(
        type: '변경',
        status: '승인',
        profileImg: 'assets/images/trainerExample.png',
        name: '김헬스',
        originDay: '8월 6일 09:00',
        changeDay: '8월 7일 20:00',
        requestDay: '24.01.17. 20:32'),
    RequestList(
        type: '취소',
        status: '승인',
        profileImg: 'assets/images/trainerExample2.png',
        name: '이헬스',
        originDay: '8월 8일 09:00',
        changeDay: '',
        requestDay: '24.01.18. 12:01'),
    RequestList(
        type: '취소',
        status: '거절',
        profileImg: 'assets/images/trainerExample3.png',
        name: '박헬스',
        originDay: '8월 12일 09:00',
        changeDay: '',
        requestDay: '24.01.12. 06:18'),
    RequestList(
        type: '변경',
        status: '승인',
        profileImg: 'assets/images/trainerExample4.png',
        name: '최헬스',
        originDay: '8월 13일 09:00',
        changeDay: '8월 14일 10:00',
        requestDay: '24.01.20. 14:48'),
    RequestList(
        type: '변경',
        status: '거절',
        profileImg: 'assets/images/trainerExample5.png',
        name: '고헬스',
        originDay: '8월 19일 09:00',
        changeDay: '8월 19일 13:00',
        requestDay: '24.01.30. 20:23'),
    RequestList(
        type: '변경',
        status: '승인',
        profileImg: 'assets/images/trainerExample6.png',
        name: '고헬스',
        originDay: '8월 21일 08:30',
        changeDay: '8월 26일 18:00',
        requestDay: '24.01.11. 17:41'),
    RequestList(
        type: '변경',
        status: '거절',
        profileImg: 'assets/images/trainerExample.png',
        name: '한헬스',
        originDay: '8월 21일 07:00',
        changeDay: '8월 23일 06:00',
        requestDay: '24.01.13. 09:59'),
  ];

  List<RequestList> getPendingRequestList() {
    return _dummyRequests;
  }

  List<RequestList> getCompletedRequestList() {
    return _dummyRequests;
  }
}
