import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/course_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/e_boo_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainUseCase {
  final TutorRepositories _tutorRepositories;

  final CourseRepositories _courseRepositories;

  final EBooRepositories _eBooRepositories;

  MainUseCase(
    this._tutorRepositories,
    this._courseRepositories,
    this._eBooRepositories,
  );

  SingleResult<TutorFav> getTopTutors() =>
      _tutorRepositories.pagFetchTutorsData(page: 1, perPge: 5);

  SingleResult<Pagination<Course>?> getTopCourse() => _courseRepositories
      .pagFetchCourseData(page: 1, perPge: 5, q: null, categoryId: null);

  SingleResult<Pagination<EBoo>> getEBooResponse() => _eBooRepositories
      .getEBooResponse(page: 1, size: 5, q: null, categoryId: null);
}
