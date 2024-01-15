import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/data/models/token/token_model.dart';

abstract class AuthRepository {
  SingleResult<TokenModel?> login(
      {required String email, required String password});

  SingleResult<TokenModel?> register(
      {required String email, required String password});

  SingleResult<bool?> resetPassword({required String email});

  SingleResult<TokenModel?> googleSignIn();

  SingleResult<TokenModel?> fbSignIn();

  SingleResult<bool?> facebookSignIn();

  SingleResult<bool?> verifyAccountEmail({required String token});
}
