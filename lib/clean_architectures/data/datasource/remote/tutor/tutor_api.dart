import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutors_response/tutors_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'tutor_api.g.dart';


@injectable
@RestApi()
abstract class TutorApi {
  static const String pagFetchDataApi = "/tutor/more?";

  @factoryMethod
  factory TutorApi(Dio dio) = _TutorApi;

  @GET('$pagFetchDataApi?perPage={size}&page={page}')
  Future<HttpResponse<TutorResponse?>> pagFetchData(
    @Path('page') int page,
    @Path('size') int size,
  );
}
