import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/course_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeUseCase {
  final CourseRepositories _courseRepositories;

  HomeUseCase(this._courseRepositories);

  SingleResult<Pagination<Course>?> pagFetchData(
          {required int page, required int size}) =>
      _courseRepositories.pagFetchCourseData(page: page, perPge: size);
}