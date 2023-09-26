import 'package:flutter_base_clean_architecture/clean_architectures/data/models/schedule/schedule_model.dart';

class SchedulesResponse {
  final String status;
  final List<ScheduleModel> schedules;
  SchedulesResponse(this.status, this.schedules);

  factory SchedulesResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['scheduleOfTutor'];
    if (cData == null) return SchedulesResponse('Error', List.empty());
    return SchedulesResponse(
      data['message']?.toString() ?? 'Error',
      ((cData) as List<dynamic>).map((e) => ScheduleModel.fromJson(e)).toList(),
    );
  }
}
