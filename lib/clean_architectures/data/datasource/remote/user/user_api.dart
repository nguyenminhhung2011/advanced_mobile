import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@injectable
@RestApi()
abstract class UserApi {
  static const String reportTutorApi = "/report";

  @factoryMethod
  factory UserApi(Dio dio) = _UserApi;

  @POST(reportTutorApi)
  Future<HttpResponse> reportTutor(
      {@Body() required Map<String, dynamic> body});
}
  