import 'package:flutter_base_clean_architecture/clean_architectures/data/models/schedule/schedule_info_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleDetailModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'scheduleId')
  final String scheduleId;

  @JsonKey(name: 'startPeriod')
  final String startPeriod;

  @JsonKey(name: 'endPeriod')
  final String endPeriod;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @JsonKey(name: 'startPeriodTimestamp')
  final int startPeriodTimestamp;

  @JsonKey(name: 'endPeriodTimestamp')
  final int endPeriodTimestamp;

  @JsonKey(name: 'scheduleInfo')
  final ScheduleInfoModel? scheduleInfo;

  ScheduleDetailModel(
    this.id,
    this.scheduleId,
    this.startPeriod,
    this.endPeriod,
    this.createdAt,
    this.updatedAt,
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.scheduleInfo,
  );

  Map<String, dynamic> toJson() => _$ScheduleDetailModelToJson(this);

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailModelFromJson(json);

  ScheduleDetail toEntity() => ScheduleDetail(
        id: id,
        scheduleId: scheduleId,
        startPeriod: startPeriod,
        endPeriod: endPeriod,
        createdAt: createdAt,
        updatedAt: updatedAt,
        startPeriodTimestamp:
            DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp),
        endPeriodTimestamp:
            DateTime.fromMillisecondsSinceEpoch(endPeriodTimestamp),
        scheduleInfo: scheduleInfo?.toEntity(),
      );
}
