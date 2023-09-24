// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorUserDetailModel _$TutorUserDetailModelFromJson(
        Map<String, dynamic> json) =>
    TutorUserDetailModel(
      json['id'] as String,
      json['level'] as String?,
      json['avatar'] as String?,
      json['name'] as String?,
      json['country'] as String?,
      json['language'] as String?,
      json['isPublicRecord'] as bool?,
      json['caredByStaffId'] as String?,
      json['studentGroupId'] as String?,
      json['zaloUserId'] as String?,
      (json['courses'] as List<dynamic>)
          .map((e) => CoursePreviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorUserDetailModelToJson(
        TutorUserDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'avatar': instance.avatar,
      'name': instance.name,
      'country': instance.country,
      'language': instance.language,
      'isPublicRecord': instance.isPublicRecord,
      'caredByStaffId': instance.caredByStaffId,
      'studentGroupId': instance.studentGroupId,
      'zaloUserId': instance.zaloUserId,
      'courses': instance.courses,
    };
