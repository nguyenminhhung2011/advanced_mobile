import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_preview/course_preview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'course_preview_model.g.dart';

@JsonSerializable()
class CoursePreviewModel {
  @JsonKey(name: 'id')
  final String courseId;

  @JsonKey(name: 'name')
  final String name;
  // final String tutorId;
  // final DateTime? createdAt;

  // final DateTime? updatedAt;

  CoursePreviewModel(this.courseId, this.name
      // this.tutorId, this.createdAt, this.updatedAt
      );

  factory CoursePreviewModel.fromJson(Map<String, dynamic> json) =>
      _$CoursePreviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePreviewModelToJson(this);

  CoursePreview toEntity() => CoursePreview(courseId: courseId, name: name);
}
