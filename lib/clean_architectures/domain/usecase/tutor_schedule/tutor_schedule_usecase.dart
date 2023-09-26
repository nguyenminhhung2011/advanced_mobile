import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorScheduleUseCase {
  final TutorRepositories _tutorRepositories;
  TutorScheduleUseCase(this._tutorRepositories);

  SingleResult<List<Schedule>> getTutorSchedule(
          {required String tutorId,
          required DateTime startTime,
          required DateTime endTime}) =>
      _tutorRepositories.getTutorSchedule(
          tutorId: tutorId, startTime: startTime, endTime: endTime);
}
