import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_detail.freezed.dart';

@freezed
class ScheduleDetail with _$ScheduleDetail {
  const factory ScheduleDetail({
    required String id,
    required String scheduleId,
    required String startPeriod,
    required String endPeriod,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime startPeriodTimestamp,
    required DateTime endPeriodTimestamp,
    ScheduleInfo? scheduleInfo,
  }) = _ScheduleDetail;
}
