import 'package:dio/dio.dart';
import 'package:lettutor/clean_architectures/data/models/response/total_time_response/total_time_response.dart';
import 'package:lettutor/clean_architectures/domain/entities/user/user.dart';
import 'package:lettutor/clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/ratting/bloc/ratting_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/user_info/views/user_info_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dart_either/dart_either.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/user/user_api.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:lettutor/core/components/network/app_exception.dart';
import 'package:lettutor/core/dependency_injection/di.dart';

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

  @override
  SingleResult<int> getTotalTime() => apiCall<TotalTimeResponse?, int>(
        mapper: (r) => r?.total ?? 0,
        request: () async => await _userApi.getTotalTime(),
      );

  @override
  Future<User?> getUserInfo() async {
    final response = await getStateOf(
      request: () async => await _userApi.getUserInfo(),
    );
    if (response is DataFailed) {
      throw toErrorMessage(response.dioError);
    }
    final responseData = response.data?.user;
    if (responseData == null) {
      throw AppException(message: 'Data null');
    }
    return responseData.toEntity();
  }

  @override
  SingleResult<User> updateUserInfo(
          {required UpdateProfileRequest updateProfileRequest}) =>
      SingleResult.fromCallable(() async {
        final response = await getStateOf(
          request: () async =>
              await _userApi.updateUserInfo(body: updateProfileRequest.toMap),
        );
        if (response is DataFailed) {
          return Either.left(toErrorMessage(response.dioError));
        }
        final responseData = response.data?.user;
        if (responseData != null) {
          return Either.right(responseData.toEntity());
        }
        return Either.left(AppException(message: "Data null"));
      });

  @override
  SingleResult<bool> reviewTutor(
          {required ReviewTutorRequest reviewTutorRequest}) =>
      SingleResult.fromCallable(() async {
        final response = await getStateOf(
          request: () async =>
              _userApi.reviewTutor(body: reviewTutorRequest.toMap),
        );
        return response.toBoolResult();
      });

  @override
  SingleResult<bool> becomeTutor(
          {required BecomeTutorRequest becomeTutorRequest}) =>
      SingleResult.fromCallable(() async {
        try {
          Map<String, dynamic> body = {};

          for (var element in becomeTutorRequest.mapFields()) {
            body.addAll({element.key: element.value});
          }
          final dataState = await injector.get<Dio>().post("/tutor/register",
              data: body,
              options:
                  Options(contentType: Headers.multipartFormDataContentType));
          if (dataState.statusCode == 200) {
            return const Either.right(true);
          }
          return Either.left(
              dataState.data["message"] ?? "Can not register become tutor");
        } catch (e) {
          return Either.left(AppException(message: e.toString()));
        }
      });
}
