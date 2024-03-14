import '../../common/colors.dart';
import '../models/lesson_list.dart';

class LessonRepository {
  final List<LessonList> _dummyLessons = [
    LessonList(
      name: '조성민',
      from: DateTime(2024, 02, 12, 11, 00, 00),
      to: DateTime(2024, 02, 12, 13, 00, 00),
      background: PRIMARY_COLOR,
    ),
    LessonList(
      name: '김성관',
      from: DateTime(2024, 02, 13, 09, 00, 00),
      to: DateTime(2024, 02, 13, 16, 00, 00),
      background: PRIMARY_COLOR,
    ),
    LessonList(
      name: '조성민',
      from: DateTime(2024, 02, 12, 10, 00, 00),
      to: DateTime(2024, 02, 12, 10, 30, 00),
      background: PRIMARY_COLOR,
    ),
    LessonList(
      name: '김성관',
      from: DateTime(2024, 02, 12, 21, 30, 00),
      to: DateTime(2024, 02, 12, 23, 30, 00),
      background: PRIMARY_COLOR,
    ),
  ];

  List<LessonList> getLessonList() {
    return _dummyLessons;
  }
}
