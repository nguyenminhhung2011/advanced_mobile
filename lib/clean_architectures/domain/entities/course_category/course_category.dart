import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_category.freezed.dart';

@freezed
class CourseCategory with _$CourseCategory {
  const factory CourseCategory({
    required String id,
    @Default('') String title,
    @Default('') String description,
    String? key,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CourseCategory;
}
