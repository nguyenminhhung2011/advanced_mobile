import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:retrofit/dio.dart';

abstract class BaseApi {
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(data: httpResponse.data);
      } else {
        return DataFailed(
          // ignore: deprecated_member_use
          dioError: DioError(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
          ),
        );
      }
      // ignore: deprecated_member_use
    } on DioError catch (error) {
      return DataFailed(dioError: error);
    }
  }
}
