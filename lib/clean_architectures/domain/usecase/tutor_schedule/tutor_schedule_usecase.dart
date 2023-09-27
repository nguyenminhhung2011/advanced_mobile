import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorScheduleUseCase {
  final TutorRepositories _tutorRepositories;
  final UserRepositories _userRepositories;
  TutorScheduleUseCase(this._tutorRepositories, this._userRepositories);

  SingleResult<List<Schedule>> getTutorSchedule(
          {required String tutorId,
          required DateTime startTime,
          required DateTime endTime}) =>
      _tutorRepositories.getTutorSchedule(
          tutorId: tutorId, startTime: startTime, endTime: endTime);

  SingleResult<bool> booTutorClass({
    required List<String> scheduleDetailIds,
    required String note,
  }) =>
      _userRepositories.booTutor(
          scheduleDetailIds: scheduleDetailIds, note: note);
}
