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

  SingleResult<TokenModel?> register(
          {required String email, required String password}) =>
      _authRepository.register(email: email, password: password);

  SingleResult<bool?> googleSignIn() => _authRepository.googleSignIn();

  SingleResult<bool?> verifyAccount() => _authRepository.verifyAccountEmail(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjQ5MjAwOC1jYWY3LTRjZTUtYTc5Ny1iNzFkZmJjM2E1ZGEiLCJpYXQiOjE2OTY5MTc3MTIsImV4cCI6MTY5NzAwNDExMiwidHlwZSI6ImFjY2VzcyJ9.ApAT8knr_Goe-re118kn2EBW_PGlFdpAFl4dk9OfiTM",
      );
}
