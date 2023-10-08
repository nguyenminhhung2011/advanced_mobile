import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/total_time_response/total_time_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/user/user_info.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@injectable
@RestApi()
abstract class UserApi {
  static const String reportTutorApi = "/report";
  static const String bookAndCancelTutor = "/booking";
  static const String updateStudentRequestApi =
      "$bookAndCancelTutor/student-request";
  static const String getUserInfoApi = "/user/info";
  static const String getTotalTimeApi = "/call/total";
  static const String reviewTutorApi = "/user/feedbackTutor";
  static const String becomeTutorApi = "/tutor/register";

  @factoryMethod
  factory UserApi(Dio dio) = _UserApi;

  @POST(reportTutorApi)
  Future<HttpResponse> reportTutor(
      {@Body() required Map<String, dynamic> body});

  @POST(bookAndCancelTutor)
  Future<HttpResponse> bookingTutor(
      {@Body() required Map<String, dynamic> body});

  @DELETE(bookAndCancelTutor)
  Future<HttpResponse> cancelTutor(
      {@Body() required Map<String, dynamic> body});

  @POST("$updateStudentRequestApi/{booId}")
  Future<HttpResponse> updateStudentRequest(@Path('booId') String booId,
      {@Body() required Map<String, dynamic> body});

  @GET(getTotalTimeApi)
  Future<HttpResponse<TotalTimeResponse?>> getTotalTime();

  @GET(getUserInfoApi)
  Future<HttpResponse<UserInfo?>> getUserInfo();

  @PUT(getUserInfoApi)
  Future<HttpResponse<UserInfo?>> updateUserInfo(
      {@Body() required Map<String, dynamic> body});

  @POST(reviewTutorApi)
  Future<HttpResponse> reviewTutor(
      {@Body() required Map<String, dynamic> body});

  @POST(becomeTutorApi)
  Future<HttpResponse> becomeTutor({
    @Body() required Map<String, dynamic> body,
    @Header("Content-Type") required String contentType,
  });
}
