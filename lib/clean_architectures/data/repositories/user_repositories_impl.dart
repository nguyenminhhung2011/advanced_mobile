import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/user/user_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
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

        return response.toBoolResult();
      });

  @override
  SingleResult<bool> booTutor(
          {required List<String> scheduleDetailIds, required String note}) =>
      SingleResult.fromCallable(() async {
        await Future.delayed(const Duration(seconds: 2));
        final body = {'scheduleDetailIds': scheduleDetailIds, 'note': note};
        final response = await getStateOf(
            request: () async => _userApi.bookingTutor(body: body));
        return response.toBoolResult();
      });

  @override
  SingleResult<bool> cancelBooTutor(
          {required List<String> scheduleDetailIds}) =>
      SingleResult.fromCallable(() async {
        final body = {'scheduleDetailIds': scheduleDetailIds};
        final response = await getStateOf(
            request: () async => _userApi.cancelTutor(body: body));
        return response.toBoolResult();
      });

  @override
  SingleResult<bool> updateStudentRequest(
          {required String booId, required String content}) =>
      SingleResult.fromCallable(() async {
        final body = {"studentRequest": content};
        final response = await getStateOf(
          request: () async => _userApi.updateStudentRequest(booId, body: body),
        );
        return response.toBoolResult();
      });
}
