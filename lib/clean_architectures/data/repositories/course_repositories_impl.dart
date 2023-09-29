import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/course/course_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/courses_response/courses_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/course_repositories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CourseRepositories)
class CourseRepositoriesImpl extends BaseApi implements CourseRepositories {
  final CourseApi _courseApi;
  CourseRepositoriesImpl(this._courseApi);

  @override
  SingleResult<Pagination<Course>> pagFetchCourseData(
          {required int page,
          required int perPge,
          String? q,
          String? categoryId}) =>
      SingleResult.fromCallable(
        () async {
          await Future.delayed(const Duration(seconds: 2));
          final queries = <String, dynamic>{"page": page, "size": perPge};
          if (q?.isNotEmpty ?? false) {
            queries.addAll({"q": q!});
          }
          if (categoryId?.isNotEmpty ?? false) {
            queries.addAll({"categoryId": categoryId!});
          }
          final response = await getStateOf<CoursesResponse?>(
            request: () async => await _courseApi.pagFetchData(queries),
          );
          if (response is DataFailed) {
            return Either.left(
              AppException(message: response.dioError?.message ?? 'Error'),
            );
          }
          final courseResponse = response.data;

          if (courseResponse == null) {
            return Either.left(AppException(message: 'Data error'));
          }

          if (courseResponse.status == 'Error') {
            return Either.left(AppException(message: 'Error'));
          }
          return Either.right(
            Pagination(
              count: courseResponse.count,
              currentPage: page,
              rows: courseResponse.courses.map((e) => e.toEntity()).toList(),
            ),
          );
        },
      );

  @override
  SingleResult<Course> getCourseDetail({required String courseId}) =>
      SingleResult.fromCallable(
        () async {
          await Future.delayed(const Duration(seconds: 1));
          final response = await getStateOf(
            request: () async => _courseApi.getCourseDetail(courseId),
          );
          if (response is DataFailed) {
            return Either.left(
              AppException(message: response.dioError?.message ?? 'Error'),
            );
          }
          final courseResponse = response.data;
          if (courseResponse == null) {
            return Either.left(AppException(message: "Data null"));
          }
          if (courseResponse.message == 'Failed') {
            return Either.left(AppException(message: 'Error'));
          }
          return Either.right(
            courseResponse.data!.toEntity(),
          );
        },
      );

  @override
  SingleResult<List<CourseCategory>> getCourseCategory() =>
      SingleResult.fromCallable(() async {
        final response = await getStateOf(
          request: () async => await _courseApi.getContentCategory(),
        );
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        final dataResponse = response.data;
        if (dataResponse?.rows.isNotEmpty ?? false) {
          return Either.right(
            dataResponse!.rows.map((e) => e.toEntity()).toList(),
          );
        }
        return Either.left(AppException(message: "Data null"));
      });
}
