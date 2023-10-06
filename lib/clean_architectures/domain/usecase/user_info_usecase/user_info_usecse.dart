import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/app_repostiories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/user_info/views/user_info_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserInfoUseCase {
  final UserRepositories _userRepositories;
  final AppRepositories _appRepositories;

  UserInfoUseCase(this._userRepositories, this._appRepositories);

  SingleResult<User> getUserInfo() => SingleResult.fromCallable(
        () async {
          try {
            final response = await _userRepositories.getUserInfo();
            if (response == null) {
              return Either.left(AppException(message: 'Data null'));
            }
            return Either.right(response);
          } on AppException catch (e) {
            return Either.left(AppException(message: e.toString()));
          }
        },
      );
  SingleResult<User> updateUserInf(
          {required UpdateProfileRequest updateProfileRequest}) =>
      _userRepositories.updateUserInfo(
          updateProfileRequest: updateProfileRequest);

  SingleResult<List<Topic>> getTopics() => _appRepositories.getTopics();
}
