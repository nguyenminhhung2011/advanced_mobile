import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/reviews_response/reviews_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'review_api.g.dart';

@injectable
@RestApi()
abstract class ReviewApi {
  static const String getReviewApi = "/feedback/v2";

  @factoryMethod
  factory ReviewApi(Dio dio) = _ReviewApi;

  @GET('$getReviewApi/{id}')
  Future<HttpResponse<ReviewResponse>> getReviews(@Path('id') String id,
      {@Body() required Map<String, dynamic> body});
}
