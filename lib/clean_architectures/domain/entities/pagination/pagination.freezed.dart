// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Pagination<T> {
  int get count => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  List<T> get rows => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginationCopyWith<T, Pagination<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<T, $Res> {
  factory $PaginationCopyWith(
          Pagination<T> value, $Res Function(Pagination<T>) then) =
      _$PaginationCopyWithImpl<T, $Res, Pagination<T>>;
  @useResult
  $Res call({int count, int perPage, int currentPage, List<T> rows});
}

/// @nodoc
class _$PaginationCopyWithImpl<T, $Res, $Val extends Pagination<T>>
    implements $PaginationCopyWith<T, $Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? perPage = null,
    Object? currentPage = null,
    Object? rows = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value.rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginationCopyWith<T, $Res>
    implements $PaginationCopyWith<T, $Res> {
  factory _$$_PaginationCopyWith(
          _$_Pagination<T> value, $Res Function(_$_Pagination<T>) then) =
      __$$_PaginationCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int count, int perPage, int currentPage, List<T> rows});
}

/// @nodoc
class __$$_PaginationCopyWithImpl<T, $Res>
    extends _$PaginationCopyWithImpl<T, $Res, _$_Pagination<T>>
    implements _$$_PaginationCopyWith<T, $Res> {
  __$$_PaginationCopyWithImpl(
      _$_Pagination<T> _value, $Res Function(_$_Pagination<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? perPage = null,
    Object? currentPage = null,
    Object? rows = null,
  }) {
    return _then(_$_Pagination<T>(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      rows: null == rows
          ? _value._rows
          : rows // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_Pagination<T> implements _Pagination<T> {
  const _$_Pagination(
      {this.count = 0,
      this.perPage = 10,
      this.currentPage = 1,
      required final List<T> rows})
      : _rows = rows;

  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final int perPage;
  @override
  @JsonKey()
  final int currentPage;
  final List<T> _rows;
  @override
  List<T> get rows {
    if (_rows is EqualUnmodifiableListView) return _rows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rows);
  }

  @override
  String toString() {
    return 'Pagination<$T>(count: $count, perPage: $perPage, currentPage: $currentPage, rows: $rows)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pagination<T> &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(other._rows, _rows));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count, perPage, currentPage,
      const DeepCollectionEquality().hash(_rows));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginationCopyWith<T, _$_Pagination<T>> get copyWith =>
      __$$_PaginationCopyWithImpl<T, _$_Pagination<T>>(this, _$identity);
}

abstract class _Pagination<T> implements Pagination<T> {
  const factory _Pagination(
      {final int count,
      final int perPage,
      final int currentPage,
      required final List<T> rows}) = _$_Pagination<T>;

  @override
  int get count;
  @override
  int get perPage;
  @override
  int get currentPage;
  @override
  List<T> get rows;
  @override
  @JsonKey(ignore: true)
  _$$_PaginationCopyWith<T, _$_Pagination<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
