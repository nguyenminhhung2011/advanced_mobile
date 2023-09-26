import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';

abstract class TutorRepositories {
  SingleResult<TutorFav> pagFetchTutorsData(
      {required int page, required int perPge});

  SingleResult<bool> addTutorToFavorite({required String userId});

  SingleResult<TutorFav?> searchTutor({
    required SearchTutorRequest searchTutorRequest,
  });

  SingleResult<TutorDetail?> getTutorById({required String userId});

  SingleResult<List<Schedule>> getTutorSchedule(
      {required String tutorId,
      required DateTime startTime,
      required DateTime endTime});
}
