import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/local/preferences.dart';
import 'package:flutter_base_clean_architecture/core/dependency_injection/di.dart';

import '../clean_architectures/data/datasource/remote/auth/auth_api.dart';

class AppCoreFactory {
  static Dio createDio(String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "content-type": "application/json;encoding=utf-8",
          "Accept": "*/*",
        },
      ),
    )
      ..interceptors.add(TokenInterceptor())
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    if (!kIsWeb) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return dio;
  }
}

class TokenInterceptor implements Interceptor {
  // final AuthApi _authApi = injector.get<AuthApi>();

  @override
  // ignore: deprecated_member_use
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = CommonAppSettingPref.getAccessToken();
    String refreshToken = CommonAppSettingPref.getRefreshToken();
    int expiredTime = CommonAppSettingPref.getExpiredTime();

    log('🌟[Access] $accessToken\n[Refresh] $refreshToken');

    if (accessToken.isEmpty || refreshToken.isEmpty || expiredTime == -1) {
      return handler.next(options);
    }

    final expiredTimeParsed = DateTime.fromMillisecondsSinceEpoch(expiredTime);
    final isExpired = DateTime.now().isAfter(expiredTimeParsed);

    if (isExpired) {
      ///[Warning] if don't have this line code render dio call => duplicate
      await CommonAppSettingPref.setExpiredTime(-1);
      try {
        final response = await injector.get<AuthApi>().refreshToken(body: {
          'refreshToken': refreshToken,
          'timezone': "7",
        });
        if (response.response.statusCode == HttpStatus.ok &&
            response.data.isSuccess) {
          final responseData = response.data;
          options.headers["Authorization"] =
              "Bearer ${responseData.accessToken}";
          await CommonAppSettingPref.setAccessToken(responseData.accessToken);
          await CommonAppSettingPref.setRefreshToken(responseData.refreshToken);
          await CommonAppSettingPref.setExpiredTime(responseData.expiredTime);
          // return handler.next(options);
        } else {
          log("Logging out");
        }
      } catch (e) {
        log(e.toString());
        return;
      }
    } else {
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
