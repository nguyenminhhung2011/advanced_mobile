import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:lettutor/clean_architectures/data/datasource/local/preferences.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/auth/auth_api.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/data/models/token/sign_in_response.dart';
import 'package:lettutor/clean_architectures/data/models/token/token_model.dart';
import 'package:lettutor/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:lettutor/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/utils/validators.dart';
import 'package:lettutor/core/services/firebase_service.dart';

void delayed() async {
  await Future.delayed(const Duration(seconds: 6));
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends BaseApi implements AuthRepository {
  final AuthApi _authApi;
  final FirebaseServices _firebaseServices;
  AuthRepositoryImpl(this._authApi, this._firebaseServices);

  @override
  SingleResult<TokenModel?> login(
      {required String email, required String password}) {
    final body = {'email': email, 'password': password};
    return authFunction(functionCall: _authApi.login(body: body));
  }

  @override
  SingleResult<TokenModel?> register(
      {required String email, required String password}) {
    final body = {
      'email': email,
      'password': password,
      'source': null,
    };
    return authFunction(functionCall: _authApi.register(body: body));
  }

  @override
  SingleResult<bool?> resetPassword({required String email}) =>
      SingleResult.fromCallable(() async {
        final response = await getStateOf(
          request: () async => _authApi.resetPassword(body: {"email": email}),
        );
        return response.toBoolResult();
      });

  @override
  SingleResult<bool?> facebookSignIn() {
    throw UnimplementedError();
  }

  @override
  SingleResult<TokenModel?> googleSignIn() {
    return SingleResult.fromCallable(
      () async {
        final accessToken = await _firebaseServices.googleAuth();
        if (accessToken.isEmpty) {
          return Either.left(
              AppException(message: "Can not get access token from google"));
        }
        log("🎉[ access] $accessToken");
        final response = await getStateOf<SignInResponse?>(
          request: () async =>
              await _authApi.googleSignIn(body: {"access_token": accessToken}),
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
  SingleResult<bool?> verifyAccountEmail({required String token}) =>
      SingleResult.fromCallable(
        () async {
          final response = await getStateOf(
            request: () async => _authApi.verifyEmailAccount(token),
          );
          return response.toBoolResult();
        },
      );

  @override
  SingleResult<TokenModel?> fbSignIn() {
    return SingleResult.fromCallable(
      () async {
        final accessToken = await _firebaseServices.fbAuth();
        if (accessToken.isEmpty) {
          return Either.left(
              AppException(message: "Can not get access token from google"));
        }
        log("🎉[ access] $accessToken");
        final response = await getStateOf<SignInResponse?>(
          request: () async => await _authApi
              .facebookSignIn(body: {"access_token": accessToken}),
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
}
