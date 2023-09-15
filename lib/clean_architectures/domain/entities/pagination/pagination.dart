import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination.freezed.dart';

@freezed
class Pagination<T> with _$Pagination {
  const factory Pagination({
    @Default(0) int count,
    @Default(10) int perPage,
    @Default(1) int currentPage,
    required List<T> rows,
  }) = _Pagination;
}
