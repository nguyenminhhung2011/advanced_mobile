import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_detail/course_detail_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/courses_response/courses_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'course_api.g.dart';

@injectable
@RestApi()
abstract class CourseApi {
  static const String pagFetchDataApi = "/course";

  @factoryMethod
  factory CourseApi(Dio dio) = _CourseApi;

  @GET('$pagFetchDataApi?page={page}&size={size}')
  Future<HttpResponse<CoursesResponse?>> pagFetchData(
    @Path('page') int page,
    @Path('size') int size,
  );

  @GET('$pagFetchDataApi/{id}')
  Future<HttpResponse<CourseDetailResponse?>> getCourseDetail(
    @Path('id') String courseId,
  );
}
