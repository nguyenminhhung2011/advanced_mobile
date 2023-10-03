import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';

abstract class UserRepositories {
  SingleResult<bool> reportUser(
      {required String userId, required String content});

  SingleResult<bool> booTutor(
      {required List<String> scheduleDetailIds, required String note});

  SingleResult<bool> cancelBooTutor({required List<String> scheduleDetailIds});

  SingleResult<bool> updateStudentRequest(
      {required String booId, required String content});
}
