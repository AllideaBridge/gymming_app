class TrainerAvailability {
  late int weekDay; // 0: 월요일, 1: 화요일, ..., 6: 일요일
  late String startTime;
  late String endTime;

  TrainerAvailability(this.weekDay, this.startTime, this.endTime);

  Map<String, Object> toJson() {
    return {
      'week_day': weekDay,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
