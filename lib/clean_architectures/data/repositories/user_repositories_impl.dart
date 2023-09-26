import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/user/user_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepositories)
class UserRepositoriesImpl extends BaseApi implements UserRepositories {
  final UserApi _userApi;
  UserRepositoriesImpl(this._userApi);

  @override
  SingleResult<bool> reportUser(
          {required String userId, required String content}) =>
      SingleResult.fromCallable(() async {
        final body = {'tutorId': userId, 'content': content};

        final response = await getStateOf(
            request: () async => await _userApi.reportTutor(body: body));
        if (response is DataFailed) {
          return Either.left(
            AppException(message: response.dioError?.message ?? 'Error'),
          );
        }
        return const Either.right(true);
      });
}
