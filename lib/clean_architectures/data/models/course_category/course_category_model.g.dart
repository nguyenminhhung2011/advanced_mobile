// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategoryModel _$CourseCategoryModelFromJson(Map<String, dynamic> json) =>
    CourseCategoryModel(
      json['id'] as String,
      json['title'] as String?,
      json['description'] as String?,
      json['key'] as String?,
      json['displayOrder'] as int?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseCategoryModelToJson(
        CourseCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'key': instance.key,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
