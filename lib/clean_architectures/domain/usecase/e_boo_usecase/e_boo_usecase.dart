import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/course_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/e_boo_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class EBooUseCase {
  final EBooRepositories _eBooRepositories;

  final CourseRepositories _courseRepositories;
  EBooUseCase(this._eBooRepositories, this._courseRepositories);

  SingleResult<Pagination<EBoo>> getEBooResponse(
          {required int page,
          required int size,
          String? q,
          String? categoryId}) =>
      _eBooRepositories.getEBooResponse(
          page: page, size: size, q: q, categoryId: categoryId);

  SingleResult<List<CourseCategory>> getCourseCategory() =>
      _courseRepositories.getCourseCategory();
}
