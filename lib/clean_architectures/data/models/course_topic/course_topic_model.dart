import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_topic/course_topic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_topic_model.g.dart';

@JsonSerializable()
class CourseTopicModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'courseId')
  final String courseId;

  @JsonKey(name: 'orderCourse')
  final int? orderCourse;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'beforeTheClassNotes')
  final String? beforeTheClassNotes;

  @JsonKey(name: 'afterTheClassNotes')
  final String? afterTheClassNotes;

  @JsonKey(name: 'nameFile')
  final String? nameFile;

  @JsonKey(name: 'numberOfPages')
  final int? numberOfPages;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'videoUrl')
  final String? videoUrl;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  CourseTopicModel(
    this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.beforeTheClassNotes,
    this.afterTheClassNotes,
    this.nameFile,
    this.numberOfPages,
    this.description,
    this.videoUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  );

  factory CourseTopicModel.fromJson(Map<String, dynamic> json) =>
      _$CourseTopicModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseTopicModelToJson(this);

  CourseTopic toEntity() => CourseTopic(
        id: id,
        courseId: courseId,
        name: name,
        description: description ?? '',
        orderCourse: orderCourse,
        nameFile: nameFile,
        videoUrl: videoUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
