import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor_detail/tutor_detail_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutors_response/search_tutors_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutors_response/tutors_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'tutor_api.g.dart';

@injectable
@RestApi()
abstract class TutorApi {
  static const String pagFetchDataApi = "/tutor/more";
  static const String addTutorFavoriteApi = "/user/manageFavoriteTutor";
  static const String searchTutorApi = "/tutor/search";
  static const String getTutorByIdApi = "/tutor ";

  @factoryMethod
  factory TutorApi(Dio dio) = _TutorApi;

  @GET('$pagFetchDataApi?perPage={size}&page={page}')
  Future<HttpResponse<TutorsResponse?>> pagFetchData(
    @Path('page') int page,
    @Path('size') int size,
  );

  @POST(addTutorFavoriteApi)
  Future<HttpResponse> addTutorToFavorite(
      {@Body() required Map<String, dynamic> body});

  @POST(searchTutorApi)
  Future<HttpResponse<SearchTutorsResponse?>> searchTutor(
      {@Body() required Map<String, dynamic> body});

  @GET('$getTutorByIdApi/{id}')
  Future<HttpResponse<TutorDetailModel?>> getTutorById(@Path('id') String id);
}
