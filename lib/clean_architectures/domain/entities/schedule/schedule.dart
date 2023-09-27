import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required String id,
    required String tutorId,
    required String startTime,
    required String endTime,
    required DateTime startTimestamp,
    required DateTime endTimestamp,
    required DateTime createdAt,
    required bool isBooked,
    @Default(<ScheduleDetail>[]) List<ScheduleDetail> scheduleDetails,
  }) = _Schedule;
}
