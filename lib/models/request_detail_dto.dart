class RequestDetailDTO {
  final String profileImg;
  final String name;
  final String originDay;
  final String changeDay;
  final String requestDay;
  final String requestStatus; //승인, 거절, 아직 미완 상태
  final String reason;

  RequestDetailDTO (
      {required this.profileImg,
      required this.name,
      required this.originDay,
      required this.changeDay,
      required this.requestDay,
      required this.requestStatus,
      required this.reason});
}
