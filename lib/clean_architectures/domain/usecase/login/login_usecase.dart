import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
// import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/base/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  SingleResult<TokenModel?> login(
          {required String email, required String password}) =>
      _authRepository.login(email: email, password: password);

  SingleResult<bool?> googleSignIn() =>
      _authRepository.googleSignIn();
}
