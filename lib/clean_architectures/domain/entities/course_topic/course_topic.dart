import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_topic.freezed.dart';

@freezed
class CourseTopic with _$CourseTopic {
  const factory CourseTopic({
    required String id,
    required String courseId,
    @Default('') String name,
    @Default('') String description,
    int? orderCourse,
    String? nameFile,
    String? videoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CourseTopic;
}
