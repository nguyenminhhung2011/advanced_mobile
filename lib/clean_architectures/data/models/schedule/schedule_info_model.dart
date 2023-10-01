import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor/tutor_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleInfoModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'tutorId')
  final String tutorId;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'startTime')
  final String startTime;

  @JsonKey(name: 'endTime')
  final String endTime;

  @JsonKey(name: 'startTimestamp')
  final int startTimestamp;

  @JsonKey(name: 'endTimestamp')
  final int endTimestamp;

  @JsonKey(name: 'isDeleted')
  final bool isDeleted;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'tutorInfo')
  final TutorModel tutorInfo;

  ScheduleInfoModel(
    this.id,
    this.tutorId,
    this.date,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.tutorInfo,
  );

  Map<String, dynamic> toJson() => _$ScheduleInfoModelToJson(this);

  factory ScheduleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleInfoModelFromJson(json);

  ScheduleInfo toEntity() => ScheduleInfo(
        id: id,
        tutorId: tutorId,
        date: date,
        startTime: startTime,
        endTime: endTime,
        startTimestamp: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
        endTimestamp: DateTime.fromMillisecondsSinceEpoch(endTimestamp),
        isDeleted: isDeleted,
        createdAt: createdAt,
        updatedAt: updatedAt,
        tutorInfo: tutorInfo.toEntity(),
      );
}
