// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      json['id'] as String,
      json['tutorId'] as String,
      json['startTime'] as String,
      json['endTime'] as String,
      json['startTimestamp'] as int,
      json['endTimestamp'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['isBooked'] as bool,
      (json['scheduleDetails'] as List<dynamic>)
          .map((e) => ScheduleDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt.toIso8601String(),
      'isBooked': instance.isBooked,
      'scheduleDetails':
          instance.scheduleDetails.map((e) => e.toJson()).toList(),
    };
