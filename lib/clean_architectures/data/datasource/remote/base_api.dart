import 'dart:developer';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:lettutor/clean_architectures/data/datasource/local/preferences.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/data/models/token/sign_in_response.dart';
import 'package:lettutor/clean_architectures/data/models/token/token_model.dart';
import 'package:lettutor/core/components/network/app_exception.dart';
import 'package:lettutor/core/components/utils/validators.dart';
import 'package:intl/intl.dart';
import 'package:retrofit/dio.dart';

abstract class BaseApi {
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();

      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.created) {
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

  AppException toErrorMessage(DioException? exception) => AppException(
      message: exception?.response?.data["message"]?.toString() ?? 'Error');

  SingleResult<TokenModel?> authFunction({
    required Future<HttpResponse<SignInResponse?>> functionCall,
  }) {
    return SingleResult.fromCallable(
      () async {
        final response = await getStateOf<SignInResponse?>(
          request: () async => await functionCall,
        );
        if (response is DataFailed) {
          return Either.left(toErrorMessage(response.dioError));
        }
        if (response.data == null) {
          return Either.left(AppException(message: 'Data error'));
        }
        final tokenModel = response.data!.token;
        if (Validator.tokenNull(tokenModel)) {
          return Either.left(AppException(message: 'Data null'));
        }

        ///[Print] log data
        log("[Access] ${tokenModel.access?.token}");
        log("[Refresh] ${tokenModel.refresh?.token}");
        log("[Expired time] ${DateFormat().add_yMd().format(tokenModel.access?.expires ?? DateTime.now())}");

        await CommonAppSettingPref.setExpiredTime(
            (tokenModel.access?.expires ?? DateTime.now())
                .millisecondsSinceEpoch);
        await CommonAppSettingPref.setAccessToken(
            tokenModel.access?.token ?? '');
        await CommonAppSettingPref.setRefreshToken(
            tokenModel.refresh?.token ?? '');

        return Either.right(tokenModel);
      },
    );
  }

  SingleResult<R> apiCall<T, R>({
    required R Function(T?) mapper,
    required Future<HttpResponse<T>> Function() request,
  }) =>
      SingleResult.fromCallable(
        () async {
          try {
            final response =
                await getStateOf(request: () async => await request.call());
            if (response is DataFailed) {
              return Either.left(toErrorMessage(response.dioError));
            }
            if (response.data == null) {
              return Either.left(AppException(message: "Data null"));
            }

            return Either.right(mapper.call(response.data));
          } catch (e) {
            return Either.left(AppException(message: e.toString()));
          }
        },
      );

  Future<SResult<R>> apiCallSR<T, R>({
    required R Function(T?) mapper,
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final response =
          await getStateOf(request: () async => await request.call());
      if (response is DataFailed) {
        return Either.left(toErrorMessage(response.dioError));
      }
      if (response.data == null) {
        return Either.left(AppException(message: "Data null"));
      }

      return Either.right(mapper.call(response.data));
    } catch (e) {
      return Either.left(AppException(message: e.toString()));
    }
  }
}
