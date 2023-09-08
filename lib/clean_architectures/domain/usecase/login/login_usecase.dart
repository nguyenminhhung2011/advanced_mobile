import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/base/base_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_bloc/src/model/result.dart';

@injectable
class LoginUseCase extends BaseUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Stream<Result<User?>> loginS(
          {required String userName, required String password}) =>
      _authRepository.login(email: userName, password: password).map(
            (event) => event.fold(
                ifLeft: (error) => Result.error(error),
                ifRight: (user) => Result.success(user)),
          );
}
