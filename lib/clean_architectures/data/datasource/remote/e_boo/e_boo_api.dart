import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/e_boo/e_boo_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'e_boo_api.g.dart';

@injectable
@RestApi()
abstract class EBooApi {
  static const String getEBooApi = "/e-book";

  @factoryMethod
  factory EBooApi(Dio dio) = _EBooApi;

  @GET(getEBooApi)
  Future<HttpResponse<EBooResponse?>> getEBoos(
    @Queries() Map<String, dynamic> queries,
  );
}
