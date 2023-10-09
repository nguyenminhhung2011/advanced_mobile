import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPassUseCase {
  final AuthRepository _authRepository;
  ResetPassUseCase(this._authRepository);

  SingleResult<bool?> resetPassword({required String email}) =>
      _authRepository.resetPassword(email: email);
}
