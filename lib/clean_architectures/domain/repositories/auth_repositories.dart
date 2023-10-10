import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';

abstract class AuthRepository {
  SingleResult<TokenModel?> login(
      {required String email, required String password});

  SingleResult<TokenModel?> register(
      {required String email, required String password});

  SingleResult<bool?> resetPassword({required String email});

  SingleResult<bool?> googleSignIn();

  SingleResult<bool?> facebookSignIn();

  SingleResult<bool?> verifyAccountEmail({required String token});
}
