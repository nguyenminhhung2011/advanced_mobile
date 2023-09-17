import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';

abstract class TutorRepositories {
  SingleResult<TutorFav> pagFetchTutorsData(
      {required int page, required int perPge});

  SingleResult<bool> addTutorToFavorite({required String userId});
}
