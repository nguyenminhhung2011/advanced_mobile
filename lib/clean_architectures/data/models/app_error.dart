import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class AppError {
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  AppError._(this.error, this.message, this.stackTrace);
}

typedef SResult<T> = Either<AppException, T>;

///[value] return both data and exception
typedef SingleResult<T> = Single<SResult<T>>;
