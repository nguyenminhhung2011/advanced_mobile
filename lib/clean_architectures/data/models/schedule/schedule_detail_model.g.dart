// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetailModel _$ScheduleDetailModelFromJson(Map<String, dynamic> json) =>
    ScheduleDetailModel(
      json['id'] as String,
      json['scheduleId'] as String,
      json['startPeriod'] as String,
      json['endPeriod'] as String,
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      json['startPeriodTimestamp'] as int,
      json['endPeriodTimestamp'] as int,
      json['scheduleInfo'] == null
          ? null
          : ScheduleInfoModel.fromJson(
              json['scheduleInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleDetailModelToJson(
        ScheduleDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'scheduleInfo': instance.scheduleInfo?.toJson(),
    };
