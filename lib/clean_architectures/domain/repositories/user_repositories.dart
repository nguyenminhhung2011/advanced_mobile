import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/bloc/ratting_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/user_info/views/user_info_bloc.dart';

abstract class UserRepositories {
  SingleResult<bool> reportUser(
      {required String userId, required String content});

  SingleResult<bool> booTutor(
      {required List<String> scheduleDetailIds, required String note});

  SingleResult<bool> cancelBooTutor({required List<String> scheduleDetailIds});

  SingleResult<bool> updateStudentRequest(
      {required String booId, required String content});

  SingleResult<bool> reviewTutor(
      {required ReviewTutorRequest reviewTutorRequest});

  SingleResult<int> getTotalTime();

  SingleResult<User> updateUserInfo(
      {required UpdateProfileRequest updateProfileRequest});

  Future<User?> getUserInfo();

  SingleResult<bool> becomeTutor(
      {required BecomeTutorRequest becomeTutorRequest});
}
