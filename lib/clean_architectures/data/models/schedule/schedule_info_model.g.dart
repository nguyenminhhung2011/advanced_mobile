// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleInfoModel _$ScheduleInfoModelFromJson(Map<String, dynamic> json) =>
    ScheduleInfoModel(
      json['id'] as String,
      json['tutorId'] as String,
      json['date'] as String,
      json['startTime'] as String,
      json['endTime'] as String,
      json['startTimestamp'] as int,
      json['endTimestamp'] as int,
      json['isDeleted'] as bool,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      TutorModel.fromJson(json['tutorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleInfoModelToJson(ScheduleInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'tutorInfo': instance.tutorInfo.toJson(),
    };
