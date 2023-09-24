import 'package:freezed_annotation/freezed_annotation.dart';
part 'course_preview.freezed.dart';

@freezed
class CoursePreview with _$CoursePreview {
  const factory CoursePreview({
    required String courseId,
    required String name,
  }) = _CoursePreview;
}
