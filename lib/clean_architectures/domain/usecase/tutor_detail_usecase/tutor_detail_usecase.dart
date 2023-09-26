import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/review/review.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/review_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorDetailUseCase {
  final TutorRepositories _tutorRepositories;
  final ReviewRepositories _reviewRepositories;
  final UserRepositories _userRepositories;
  TutorDetailUseCase(this._tutorRepositories, this._reviewRepositories,
      this._userRepositories);

  SingleResult<TutorDetail?> getTutorById({required String userId}) =>
      _tutorRepositories.getTutorById(userId: userId);

  SingleResult<bool> addTutorToFavorite({required String userId}) =>
      _tutorRepositories.addTutorToFavorite(userId: userId);

  SingleResult<Pagination<Review>> getReviews(
          {required String userId,
          required int perPage,
          required int currentPage}) =>
      _reviewRepositories.getReviews(
          page: currentPage, perPge: perPage, userId: userId);

  SingleResult<bool> reportTutor(
          {required String userId, required String content}) =>
      _userRepositories.reportUser(userId: userId, content: content);
}
