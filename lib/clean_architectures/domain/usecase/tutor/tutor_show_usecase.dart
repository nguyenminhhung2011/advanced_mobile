import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorShowUseCase {
  final TutorRepositories _tutorRepositories;
  TutorShowUseCase(this._tutorRepositories);

  SingleResult<TutorFav?> pagFetchData(
          {required int page, required int size}) =>
      _tutorRepositories.pagFetchTutorsData(page: page, perPge: size);

  SingleResult<bool> addTutorToFavorite({required String userId}) =>
      _tutorRepositories.addTutorToFavorite(userId: userId);
}
