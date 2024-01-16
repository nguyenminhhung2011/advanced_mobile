// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_message_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GetMessageRequest {
  String get id => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get perPage => throw _privateConstructorUsedError;
  int? get startTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GetMessageRequestCopyWith<GetMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetMessageRequestCopyWith<$Res> {
  factory $GetMessageRequestCopyWith(
          GetMessageRequest value, $Res Function(GetMessageRequest) then) =
      _$GetMessageRequestCopyWithImpl<$Res, GetMessageRequest>;
  @useResult
  $Res call({String id, int page, int perPage, int? startTime});
}

/// @nodoc
class _$GetMessageRequestCopyWithImpl<$Res, $Val extends GetMessageRequest>
    implements $GetMessageRequestCopyWith<$Res> {
  _$GetMessageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? page = null,
    Object? perPage = null,
    Object? startTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetMessageRequestCopyWith<$Res>
    implements $GetMessageRequestCopyWith<$Res> {
  factory _$$_GetMessageRequestCopyWith(_$_GetMessageRequest value,
          $Res Function(_$_GetMessageRequest) then) =
      __$$_GetMessageRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int page, int perPage, int? startTime});
}

/// @nodoc
class __$$_GetMessageRequestCopyWithImpl<$Res>
    extends _$GetMessageRequestCopyWithImpl<$Res, _$_GetMessageRequest>
    implements _$$_GetMessageRequestCopyWith<$Res> {
  __$$_GetMessageRequestCopyWithImpl(
      _$_GetMessageRequest _value, $Res Function(_$_GetMessageRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? page = null,
    Object? perPage = null,
    Object? startTime = freezed,
  }) {
    return _then(_$_GetMessageRequest(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_GetMessageRequest implements _GetMessageRequest {
  const _$_GetMessageRequest(
      {required this.id,
      required this.page,
      required this.perPage,
      this.startTime});

  @override
  final String id;
  @override
  final int page;
  @override
  final int perPage;
  @override
  final int? startTime;

  @override
  String toString() {
    return 'GetMessageRequest(id: $id, page: $page, perPage: $perPage, startTime: $startTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetMessageRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, page, perPage, startTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetMessageRequestCopyWith<_$_GetMessageRequest> get copyWith =>
      __$$_GetMessageRequestCopyWithImpl<_$_GetMessageRequest>(
          this, _$identity);
}

abstract class _GetMessageRequest implements GetMessageRequest {
  const factory _GetMessageRequest(
      {required final String id,
      required final int page,
      required final int perPage,
      final int? startTime}) = _$_GetMessageRequest;

  @override
  String get id;
  @override
  int get page;
  @override
  int get perPage;
  @override
  int? get startTime;
  @override
  @JsonKey(ignore: true)
  _$$_GetMessageRequestCopyWith<_$_GetMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
