import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/topic_response/topic_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@injectable
@RestApi()
abstract class AppApi {
  static const String branch = "";
  static const String totalTimeApi = "/call/total";
  static const String learningTopicApi = "/learn-topic";
  static const String testPreparationApi = "/test-preparation";

  @factoryMethod
  factory AppApi(Dio dio) = _AppApi;

  @GET(totalTimeApi)
  Future<HttpResponse<int>> getTotalTime();

  @GET(learningTopicApi)
  Future<HttpResponse<List<TopicResponse>?>> getTopic();

  @GET(testPreparationApi)
  Future<HttpResponse<List<TopicResponse>?>> getTestPreparation();
}
