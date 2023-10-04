import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/boo_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorShowUseCase {
  final TutorRepositories _tutorRepositories;
  final UserRepositories _userRepositories;
  final BooRepositories _booRepositories;
  TutorShowUseCase(
    this._tutorRepositories,
    this._userRepositories,
    this._booRepositories,
  );

  SingleResult<TutorFav?> pagFetchData(
          {required int page, required int size}) =>
      _tutorRepositories.pagFetchTutorsData(page: page, perPge: size);

  SingleResult<bool> addTutorToFavorite({required String userId}) =>
      _tutorRepositories.addTutorToFavorite(userId: userId);

  SingleResult<int> getTotalTime() => _userRepositories.getTotalTime();

  SingleResult<BooInfo?> getUpComingClass({required DateTime dateTime}) =>
      _booRepositories.getUpComingBooInfo(dateTime: dateTime);
}
