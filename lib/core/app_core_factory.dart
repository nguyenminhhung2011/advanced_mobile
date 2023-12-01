import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:lettutor/clean_architectures/data/datasource/local/preferences.dart';
import 'package:lettutor/clean_architectures/data/models/token/sign_in_response.dart';
import 'package:lettutor/core/components/configurations/configurations.dart';

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
  final _dio = Dio(
    BaseOptions(
      baseUrl: Configurations.baseUrl,
      headers: {
        "content-type": "application/json;encoding=utf-8",
        "Accept": "*/*",
      },
    ),
  )..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

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
      log("💥[Refresh] calling refresh token");

      ///[Warning] if don't have this line code render dio call => duplicate
      await CommonAppSettingPref.setExpiredTime(-1);
      try {
        final response = await _dio.post(
          "/auth/refresh-token",
          data: {
            'refreshToken': refreshToken,
            'timezone': "7",
          },
        );
        log("💥[Refresh] ${response.statusCode}  + ${response.data}");
        if (response.statusCode == HttpStatus.ok) {
          final responseData = SignInResponse.fromJson(response.data);
          options.headers["Authorization"] =
              "Bearer ${responseData.token.access}";
          await CommonAppSettingPref.setAccessToken(
              responseData.token.access?.token ?? "");
          await CommonAppSettingPref.setRefreshToken(
              responseData.token.refresh?.token ?? "");
          await CommonAppSettingPref.setExpiredTime(
              responseData.token.access?.expires?.millisecondsSinceEpoch ?? -1);
          // return handler.next(options);
        } else {
          log("Logging out");
          return;
        }
      } catch (e) {
        log("💥[Refresh] ${e.toString()}");

        return;
      }
    }
    options.headers["Authorization"] = "Bearer $accessToken";
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
