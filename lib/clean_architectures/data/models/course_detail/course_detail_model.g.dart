// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) =>
    CourseDetailModel(
      json['id'] as String,
      json['name'] as String?,
      json['description'] as String?,
      json['imageUrl'] as String?,
      json['level'] as String?,
      json['reason'] as String?,
      json['purpose'] as String?,
      json['other_details'] as String?,
      json['default_price'] as int?,
      json['course_price'] as int?,
      json['courseType'] as String?,
      json['sectionType'] as String?,
      json['visible'] as bool?,
      json['displayOrder'] as int?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      (json['topics'] as List<dynamic>?)
          ?.map((e) => CourseTopicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'level': instance.level,
      'reason': instance.reason,
      'purpose': instance.purpose,
      'other_details': instance.otherDetails,
      'default_price': instance.defaultPrice,
      'course_price': instance.coursePrice,
      'courseType': instance.courseType,
      'sectionType': instance.sectionType,
      'visible': instance.visible,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'topics': instance.topics,
    };
