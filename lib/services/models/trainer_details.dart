import 'package:gymming_app/services/models/trainer_availability.dart';

class TrainerDetails {
  String trainerName;
  String trainerPhoneNumber;
  String trainerGender;
  String trainerBirthday;
  String description;
  String lessonName;
  int lessonPrice;
  int lessonChangeRange;
  String centerName;
  String centerLocation;
  String centerNumber;
  String centerType;
  List<TrainerAvailability> trainerAvailability;

  TrainerDetails({
    required this.trainerName,
    required this.trainerPhoneNumber,
    required this.trainerGender,
    required this.trainerBirthday,
    required this.description,
    required this.lessonName,
    required this.lessonPrice,
    required this.lessonChangeRange,
    required this.centerName,
    required this.centerLocation,
    required this.centerNumber,
    required this.centerType,
    required this.trainerAvailability,
  });

  // 빈 생성자: 초기값 설정
  TrainerDetails.empty()
      : trainerName = '',
        trainerPhoneNumber = '',
        trainerGender = '',
        trainerBirthday = '',
        description = '',
        lessonName = '',
        lessonPrice = 0,
        lessonChangeRange = 3,
        centerName = '',
        centerLocation = '',
        centerNumber = '',
        centerType = '',
        trainerAvailability = [];

  // 스텝 1 데이터 세터 메서드
  void setStep1Data(Map<String, dynamic> modelStep1) {
    trainerName = modelStep1['name'] ?? '';
    trainerPhoneNumber = modelStep1['phoneNumber'] ?? '';
    trainerGender = modelStep1['gender'] ?? '';
    trainerBirthday = modelStep1['birth'].toIso8601String() ?? '';
    description = modelStep1['history'] ?? '';
  }

  // 스텝 2 데이터 세터 메서드
  void setStep2Data(Map<String, dynamic> modelStep2) {
    lessonName = modelStep2['lessonName'] ?? '';
    lessonPrice = int.tryParse(modelStep2['lessonCost'] ?? '0') ?? 0;
    lessonChangeRange = int.tryParse(modelStep2['lessonChangeRange'] ?? '0') ?? 0;
    trainerAvailability =
        _parseAvailabilityList(modelStep2['availableTimeList']);
  }

  // 스텝 3 데이터 세터 메서드
  void setStep3Data(Map<String, dynamic> modelStep3) {
    centerName = modelStep3['centerName'] ?? '';
    centerLocation = modelStep3['centerAddress'] ?? '';
    centerNumber = modelStep3['centerContact'] ?? '';
    centerType = modelStep3['centerType'] ?? '';
  }

  // 헬퍼 메서드: 가능한 시간 리스트 파싱
  List<TrainerAvailability> _parseAvailabilityList(
      List<dynamic>? availabilityList) {
    if (availabilityList == null) return [];
    List<TrainerAvailability> list = [];
    int index = 0;
    for (var item in availabilityList) {
      if (item['isChecked']) {
        String startTime = item['start'];
        String endTime = item['end'];
        if (item['title'] == '매일') {
          list.addAll(List.generate(7,
              (weekDay) => TrainerAvailability(weekDay, startTime, endTime)));
          continue;
        }

        if (item['title'] == '평일') {
          list.addAll(List.generate(5,
              (weekDay) => TrainerAvailability(weekDay, startTime, endTime)));
          continue;
        }
        if (item['title'] == '주말') {
          list.addAll(List.generate(
              2,
              (weekDay) =>
                  TrainerAvailability(weekDay + 5, startTime, endTime)));
          continue;
        }
        list.add(TrainerAvailability(index, startTime, endTime));
      }
      index++;
    }
    print("trainer_availability");
    print(list);
    return list;
  }

  Map<String, Object> toJson(){
    return {
      'trainer_name': trainerName,
      'trainer_phone_number': trainerPhoneNumber,
      'trainer_gender': trainerGender,
      'trainer_birthday': trainerBirthday,
      'description': description,
      'lesson_name': lessonName,
      'lesson_price': lessonPrice,
      'lesson_change_range': lessonChangeRange,
      'center_name': centerName,
      'center_location': centerLocation,
      'center_number': centerNumber,
      'center_type': centerType,
      'trainer_availability': trainerAvailability.map((e) => e.toJson()).toList(),
    };
  }
}
