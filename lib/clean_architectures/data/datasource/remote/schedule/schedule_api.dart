import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/up_coming_response/up_coming_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_api.g.dart';

@injectable
@RestApi()
abstract class ScheduleApi {
  static const String getSchedule = "/booking/list/student";
  static const String getUpComingApi = "/booking/next";

  @factoryMethod
  factory ScheduleApi(Dio dio) = _ScheduleApi;

  @GET(getSchedule)
  Future<HttpResponse<BooResponse?>> getBooHistory(
    @Queries() Map<String, dynamic> queries,
  );

  @GET("$getUpComingApi?dateTime={time}")
  Future<HttpResponse<UpComingResponse?>> getUpComing(@Path('time') int time);
}
