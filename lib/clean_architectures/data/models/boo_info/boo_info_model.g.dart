// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boo_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooInfoModel _$BooInfoModelFromJson(Map<String, dynamic> json) => BooInfoModel(
      json['id'] as String,
      json['userId'] as String?,
      json['scheduleId'] as String?,
      json['cancelReasonId'] as String?,
      json['lessonPlanId'] as String?,
      json['calendarId'] as String?,
      json['cancelNote'] as String?,
      json['isDeleted'] as bool?,
      json['isTrial'] as bool?,
      json['convertedLesson'] as int?,
      json['tutorMeetingLink'] as String?,
      json['studentMeetingLink'] as String?,
      json['googleMeetLink'] as String?,
      json['studentRequest'] as String?,
      json['tutorReview'] as String?,
      json['scoreByTutor'] as String?,
      json['recordUrl'] as String?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['createdAtTimeStamp'] as int?,
      json['updatedAtTimeStamp'] as int?,
      json['scheduleDetailInfo'] == null
          ? null
          : ScheduleDetailModel.fromJson(
              json['scheduleDetailInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BooInfoModelToJson(BooInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'scheduleId': instance.scheduleId,
      'cancelReasonId': instance.cancelReasonId,
      'lessonPlanId': instance.lessonPlanId,
      'calendarId': instance.calendarId,
      'cancelNote': instance.cancelNote,
      'isDeleted': instance.isDeleted,
      'isTrial': instance.isTrial,
      'convertedLesson': instance.convertedLesson,
      'tutorMeetingLink': instance.tutorMeetingLink,
      'studentMeetingLink': instance.studentMeetingLink,
      'googleMeetLink': instance.googleMeetLink,
      'studentRequest': instance.studentRequest,
      'tutorReview': instance.tutorReview,
      'scoreByTutor': instance.scoreByTutor,
      'recordUrl': instance.recordUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'scheduleDetailInfo': instance.scheduleDetailInfo,
    };
