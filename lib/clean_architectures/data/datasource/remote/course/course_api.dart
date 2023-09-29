import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_category/content_category_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_detail/course_detail_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/courses_response/courses_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'course_api.g.dart';

@injectable
@RestApi()
abstract class CourseApi {
  static const String pagFetchDataApi = "/course";
  static const String contentCategory = "/content-category";

  @factoryMethod
  factory CourseApi(Dio dio) = _CourseApi;

  @GET(pagFetchDataApi)
  Future<HttpResponse<CoursesResponse?>> pagFetchData(
    @Queries() Map<String, dynamic> queries,
  );

  @GET('$pagFetchDataApi/{id}')
  Future<HttpResponse<CourseDetailResponse?>> getCourseDetail(
    @Path('id') String courseId,
  );

  @GET(contentCategory)
  Future<HttpResponse<ContentCategoryResponse?>> getContentCategory();
}
