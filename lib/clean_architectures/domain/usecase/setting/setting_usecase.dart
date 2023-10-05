import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/base/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingUseCase extends BaseUseCase<User> {
  final UserRepositories _userRepositories;
  SettingUseCase(this._userRepositories);

  @override
  Future<User?> getUserInfo(token) async => _userRepositories.getUserInfo();
  @override
  Future<bool> logOut({required String token}) async => true;
}
