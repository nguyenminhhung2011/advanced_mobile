import 'package:flutter_base_clean_architecture/clean_architectures/data/models/schedule/schedule_detail_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'tutorId')
  final String tutorId;

  @JsonKey(name: 'startTime')
  final String startTime;

  @JsonKey(name: 'endTime')
  final String endTime;

  @JsonKey(name: 'startTimestamp')
  final int startTimestamp;

  @JsonKey(name: 'endTimestamp')
  final int endTimestamp;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'isBooked')
  final bool isBooked;

  @JsonKey(name: 'scheduleDetails')
  final List<ScheduleDetailModel> scheduleDetails;

  ScheduleModel(
    this.id,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.scheduleDetails,
  );

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Schedule toEntity() => Schedule(
        id: id,
        tutorId: tutorId,
        startTime: startTime,
        endTime: endTime,
        startTimestamp: DateTime.fromMillisecondsSinceEpoch(startTimestamp),
        endTimestamp: DateTime.fromMillisecondsSinceEpoch(endTimestamp),
        createdAt: createdAt,
        isBooked: isBooked,
        scheduleDetails: scheduleDetails.map((e) => e.toEntity()).toList(),
      );
}
