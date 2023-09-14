import 'dart:developer';
import 'dart:io';

import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/local/preferences.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/auth/auth_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:injectable/injectable.dart';

void delayed() async {
  await Future.delayed(const Duration(seconds: 6));
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl(this._authApi);

  @override
  SingleResult<TokenModel?> login(
      {required String email, required String password}) {
    return SingleResult.fromCallable(
      () async {
        final body = {'email': email, 'password': password};
        final response = await _authApi.login(body: body);
        final statusCode = response.response.statusCode;
        log("[Status code] $statusCode");
        if (statusCode != HttpStatus.ok) {
          log("[Error] error");
          return Either.left(
            AppException(
              message: response.response.statusMessage ?? '',
              code: statusCode,
            ),
          );
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

  @override
  SingleResult<User?> register(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
