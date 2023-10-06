import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/app/app_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/app_repostiories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppRepositories)
class AppRepositoriesImpl extends BaseApi implements AppRepositories {
  final AppApi _appApi;
  AppRepositoriesImpl(this._appApi);

  @override
  SingleResult<List<Topic>> getTopics() {
    return SingleResult.fromCallable(() async {
      final response = await getStateOf(
        request: () async => await _appApi.getTopic(),
      );

      final response1 = await getStateOf(
        request: () async => await _appApi.getTestPreparation(),
      );

      if ((response is DataFailed) && (response1 is DataFailed)) {
        return Either.left(
          AppException(message: response.dioError?.message ?? 'Error'),
        );
      }
      if ((response.data == null) && (response1.data == null)) {
        return Either.left(
          AppException(message: "Data error"),
        );
      }
      return Either.right(
        [
          ...response.data
                  ?.map((e) => e.toEntity().copyWith(isTopics: true))
                  .toList() ??
              <Topic>[],
          ...response1.data
                  ?.map((e) => e.toEntity().copyWith(isTopics: false))
                  .toList() ??
              <Topic>[],
        ],
      );
    });
  }
}
