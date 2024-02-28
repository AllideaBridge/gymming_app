class TraineeDetail {
  final String profileImg;
  final String name;
  final String birth;
  final String gender;
  final String weekDay;
  final int usedDay;
  final int totalDay;
  final String registeredDay;
  final String phoneNumber;
  final List<DateTime> lessonDay;

  TraineeDetail({
    required this.profileImg,
    required this.name,
    required this.birth,
    required this.gender,
    required this.usedDay,
    required this.weekDay,
    required this.totalDay,
    required this.registeredDay,
    required this.phoneNumber,
    required this.lessonDay,
  });
}
