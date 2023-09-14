import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

@freezed
class Pagination<T> with _$Pagination {
  const factory Pagination({
    required int count,
    @Default(10) int perPage,
    @Default(1) int currentPage,
    @Default([]) List<T> rows,
  }) = _Pagination;
}
