import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';

abstract class CourseRepositories {
  SingleResult<Pagination<Course>> pagFetchCourseData(
      {required int page, required int perPge, String? q, String? categoryId});

  SingleResult<Course> getCourseDetail({required String courseId});

  SingleResult<List<CourseCategory>> getCourseCategory();
}
