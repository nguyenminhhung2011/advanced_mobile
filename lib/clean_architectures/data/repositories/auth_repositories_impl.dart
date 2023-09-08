import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:injectable/injectable.dart';

void delayed() async {
  await Future.delayed(const Duration(seconds: 3));
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  SingleResult<User?> login({required String email, required String password}) {
    delayed();
    return SingleResult.fromCallable(
      () => Either.right(
        User(id: '01', userName: email, password: password),
      ),
    );
  }
}
