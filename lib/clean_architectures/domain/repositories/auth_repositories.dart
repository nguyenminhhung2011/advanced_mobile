import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';

abstract class AuthRepository {
  Stream<SResult<User?>> login(
      {required String email, required String password});
}
