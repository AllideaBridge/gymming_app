const leapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
const notLeapYear = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
const changeTitle = "변경 사유를 알려주세요";
const cancelTitle = "취소 사유를 알려주세요";
const changeSubTitle = """이 운동 일정을 변경하시려면 사유를 
알려주셔야 합니다.""";
const cancelSubTitle = """이 운동 일정을 취소하시려면 사유를 
알려주셔야 합니다.""";
const changeReasons = [
  "직접 입력",
  "잘못된 스케줄을 선택하였습니다.",
  "몸이 좋지 않습니다.",
  "조정하기 어려운 일정이 생겼습니다.",
  "경조사에 참석해야 합니다"
];
const CHANGE = "변경";
const CANCEL = "취소";
const WAITING_LIST = 'waiting_list';
const COMPLETED_LIST = 'completed_list';
const SIZE20 = 20.0;
const SIZE45 = 45.0;