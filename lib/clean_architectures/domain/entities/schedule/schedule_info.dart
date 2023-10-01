import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_info.freezed.dart';

@freezed
class ScheduleInfo with _$ScheduleInfo {
  const factory ScheduleInfo({
    required String id,
    required String tutorId,
    required String date,
    required String startTime,
    required String endTime,
    required DateTime startTimestamp,
    required DateTime endTimestamp,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Tutor tutorInfo,
  }) = _ScheduleInfo;
}
