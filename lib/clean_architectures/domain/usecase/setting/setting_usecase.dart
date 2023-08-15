import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/base/base_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingUseCase extends BaseUseCase<User> {
  SettingUseCase();

  @override
  Future<User?> getUserInfo(token) async => const User(
        id: 'exampleId',
        userName: 'userName',
        password: 'password',
        email: 'email@gmail.com',
        phoneNumber: '0935703991',
      );
  @override
  Future<bool> logOut({required String token}) async => true;
}
