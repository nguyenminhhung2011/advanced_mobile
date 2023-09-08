import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/auth_repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Stream<SResult<User?>> login(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
