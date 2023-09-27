import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';

abstract class DataState<T> {
  final T? data;
  // ignore: deprecated_member_use
  final DioError? dioError;

  const DataState({
    this.data,
    this.dioError,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({required super.data});
}

class DataFailed<T> extends DataState<T> {
  const DataFailed({required super.dioError});
}

extension DataStateExtensions<T> on DataState<T> {
  Either<AppException, bool> toBoolResult() {
    if (this is DataFailed) {
      return Either.left(
        AppException(message: dioError?.message ?? 'Error'),
      );
    }
    return const Either.right(true);
  }
}
