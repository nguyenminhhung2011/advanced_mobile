// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseTopicModel _$CourseTopicModelFromJson(Map<String, dynamic> json) =>
    CourseTopicModel(
      json['id'] as String,
      json['courseId'] as String,
      json['orderCourse'] as int?,
      json['name'] as String,
      json['beforeTheClassNotes'] as String?,
      json['afterTheClassNotes'] as String?,
      json['nameFile'] as String?,
      json['numberOfPages'] as int?,
      json['description'] as String?,
      json['videoUrl'] as String?,
      json['type'] as String?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseTopicModelToJson(CourseTopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'orderCourse': instance.orderCourse,
      'name': instance.name,
      'beforeTheClassNotes': instance.beforeTheClassNotes,
      'afterTheClassNotes': instance.afterTheClassNotes,
      'nameFile': instance.nameFile,
      'numberOfPages': instance.numberOfPages,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
