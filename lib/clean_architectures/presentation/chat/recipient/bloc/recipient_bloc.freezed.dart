// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipient_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipientState {
  RecipientData get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipientData data) initial,
    required TResult Function(RecipientData data) loading,
    required TResult Function(RecipientData data) getAllRecipientSuccess,
    required TResult Function(RecipientData data, String message)
        getAllRecipientFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipientData data)? initial,
    TResult? Function(RecipientData data)? loading,
    TResult? Function(RecipientData data)? getAllRecipientSuccess,
    TResult? Function(RecipientData data, String message)?
        getAllRecipientFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipientData data)? initial,
    TResult Function(RecipientData data)? loading,
    TResult Function(RecipientData data)? getAllRecipientSuccess,
    TResult Function(RecipientData data, String message)? getAllRecipientFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetAllRecipientSuccess value)
        getAllRecipientSuccess,
    required TResult Function(_GetAllRecipientFailed value)
        getAllRecipientFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult? Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipientStateCopyWith<RecipientState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientStateCopyWith<$Res> {
  factory $RecipientStateCopyWith(
          RecipientState value, $Res Function(RecipientState) then) =
      _$RecipientStateCopyWithImpl<$Res, RecipientState>;
  @useResult
  $Res call({RecipientData data});

  $RecipientDataCopyWith<$Res> get data;
}

/// @nodoc
class _$RecipientStateCopyWithImpl<$Res, $Val extends RecipientState>
    implements $RecipientStateCopyWith<$Res> {
  _$RecipientStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RecipientData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecipientDataCopyWith<$Res> get data {
    return $RecipientDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $RecipientStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RecipientData data});

  @override
  $RecipientDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$RecipientStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_Initial(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RecipientData,
    ));
  }
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial({required this.data}) : super._();

  @override
  final RecipientData data;

  @override
  String toString() {
    return 'RecipientState.initial(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipientData data) initial,
    required TResult Function(RecipientData data) loading,
    required TResult Function(RecipientData data) getAllRecipientSuccess,
    required TResult Function(RecipientData data, String message)
        getAllRecipientFailed,
  }) {
    return initial(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipientData data)? initial,
    TResult? Function(RecipientData data)? loading,
    TResult? Function(RecipientData data)? getAllRecipientSuccess,
    TResult? Function(RecipientData data, String message)?
        getAllRecipientFailed,
  }) {
    return initial?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipientData data)? initial,
    TResult Function(RecipientData data)? loading,
    TResult Function(RecipientData data)? getAllRecipientSuccess,
    TResult Function(RecipientData data, String message)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetAllRecipientSuccess value)
        getAllRecipientSuccess,
    required TResult Function(_GetAllRecipientFailed value)
        getAllRecipientFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult? Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends RecipientState {
  const factory _Initial({required final RecipientData data}) = _$_Initial;
  const _Initial._() : super._();

  @override
  RecipientData get data;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res>
    implements $RecipientStateCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RecipientData data});

  @override
  $RecipientDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$RecipientStateCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_Loading(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RecipientData,
    ));
  }
}

/// @nodoc

class _$_Loading extends _Loading {
  const _$_Loading({required this.data}) : super._();

  @override
  final RecipientData data;

  @override
  String toString() {
    return 'RecipientState.loading(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Loading &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      __$$_LoadingCopyWithImpl<_$_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipientData data) initial,
    required TResult Function(RecipientData data) loading,
    required TResult Function(RecipientData data) getAllRecipientSuccess,
    required TResult Function(RecipientData data, String message)
        getAllRecipientFailed,
  }) {
    return loading(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipientData data)? initial,
    TResult? Function(RecipientData data)? loading,
    TResult? Function(RecipientData data)? getAllRecipientSuccess,
    TResult? Function(RecipientData data, String message)?
        getAllRecipientFailed,
  }) {
    return loading?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipientData data)? initial,
    TResult Function(RecipientData data)? loading,
    TResult Function(RecipientData data)? getAllRecipientSuccess,
    TResult Function(RecipientData data, String message)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetAllRecipientSuccess value)
        getAllRecipientSuccess,
    required TResult Function(_GetAllRecipientFailed value)
        getAllRecipientFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult? Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends RecipientState {
  const factory _Loading({required final RecipientData data}) = _$_Loading;
  const _Loading._() : super._();

  @override
  RecipientData get data;
  @override
  @JsonKey(ignore: true)
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetAllRecipientSuccessCopyWith<$Res>
    implements $RecipientStateCopyWith<$Res> {
  factory _$$_GetAllRecipientSuccessCopyWith(_$_GetAllRecipientSuccess value,
          $Res Function(_$_GetAllRecipientSuccess) then) =
      __$$_GetAllRecipientSuccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RecipientData data});

  @override
  $RecipientDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetAllRecipientSuccessCopyWithImpl<$Res>
    extends _$RecipientStateCopyWithImpl<$Res, _$_GetAllRecipientSuccess>
    implements _$$_GetAllRecipientSuccessCopyWith<$Res> {
  __$$_GetAllRecipientSuccessCopyWithImpl(_$_GetAllRecipientSuccess _value,
      $Res Function(_$_GetAllRecipientSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_GetAllRecipientSuccess(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RecipientData,
    ));
  }
}

/// @nodoc

class _$_GetAllRecipientSuccess extends _GetAllRecipientSuccess {
  const _$_GetAllRecipientSuccess({required this.data}) : super._();

  @override
  final RecipientData data;

  @override
  String toString() {
    return 'RecipientState.getAllRecipientSuccess(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetAllRecipientSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetAllRecipientSuccessCopyWith<_$_GetAllRecipientSuccess> get copyWith =>
      __$$_GetAllRecipientSuccessCopyWithImpl<_$_GetAllRecipientSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipientData data) initial,
    required TResult Function(RecipientData data) loading,
    required TResult Function(RecipientData data) getAllRecipientSuccess,
    required TResult Function(RecipientData data, String message)
        getAllRecipientFailed,
  }) {
    return getAllRecipientSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipientData data)? initial,
    TResult? Function(RecipientData data)? loading,
    TResult? Function(RecipientData data)? getAllRecipientSuccess,
    TResult? Function(RecipientData data, String message)?
        getAllRecipientFailed,
  }) {
    return getAllRecipientSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipientData data)? initial,
    TResult Function(RecipientData data)? loading,
    TResult Function(RecipientData data)? getAllRecipientSuccess,
    TResult Function(RecipientData data, String message)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (getAllRecipientSuccess != null) {
      return getAllRecipientSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetAllRecipientSuccess value)
        getAllRecipientSuccess,
    required TResult Function(_GetAllRecipientFailed value)
        getAllRecipientFailed,
  }) {
    return getAllRecipientSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult? Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
  }) {
    return getAllRecipientSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (getAllRecipientSuccess != null) {
      return getAllRecipientSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetAllRecipientSuccess extends RecipientState {
  const factory _GetAllRecipientSuccess({required final RecipientData data}) =
      _$_GetAllRecipientSuccess;
  const _GetAllRecipientSuccess._() : super._();

  @override
  RecipientData get data;
  @override
  @JsonKey(ignore: true)
  _$$_GetAllRecipientSuccessCopyWith<_$_GetAllRecipientSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetAllRecipientFailedCopyWith<$Res>
    implements $RecipientStateCopyWith<$Res> {
  factory _$$_GetAllRecipientFailedCopyWith(_$_GetAllRecipientFailed value,
          $Res Function(_$_GetAllRecipientFailed) then) =
      __$$_GetAllRecipientFailedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RecipientData data, String message});

  @override
  $RecipientDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetAllRecipientFailedCopyWithImpl<$Res>
    extends _$RecipientStateCopyWithImpl<$Res, _$_GetAllRecipientFailed>
    implements _$$_GetAllRecipientFailedCopyWith<$Res> {
  __$$_GetAllRecipientFailedCopyWithImpl(_$_GetAllRecipientFailed _value,
      $Res Function(_$_GetAllRecipientFailed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_$_GetAllRecipientFailed(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RecipientData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GetAllRecipientFailed extends _GetAllRecipientFailed {
  const _$_GetAllRecipientFailed({required this.data, required this.message})
      : super._();

  @override
  final RecipientData data;
  @override
  final String message;

  @override
  String toString() {
    return 'RecipientState.getAllRecipientFailed(data: $data, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetAllRecipientFailed &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetAllRecipientFailedCopyWith<_$_GetAllRecipientFailed> get copyWith =>
      __$$_GetAllRecipientFailedCopyWithImpl<_$_GetAllRecipientFailed>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RecipientData data) initial,
    required TResult Function(RecipientData data) loading,
    required TResult Function(RecipientData data) getAllRecipientSuccess,
    required TResult Function(RecipientData data, String message)
        getAllRecipientFailed,
  }) {
    return getAllRecipientFailed(data, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RecipientData data)? initial,
    TResult? Function(RecipientData data)? loading,
    TResult? Function(RecipientData data)? getAllRecipientSuccess,
    TResult? Function(RecipientData data, String message)?
        getAllRecipientFailed,
  }) {
    return getAllRecipientFailed?.call(data, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RecipientData data)? initial,
    TResult Function(RecipientData data)? loading,
    TResult Function(RecipientData data)? getAllRecipientSuccess,
    TResult Function(RecipientData data, String message)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (getAllRecipientFailed != null) {
      return getAllRecipientFailed(data, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetAllRecipientSuccess value)
        getAllRecipientSuccess,
    required TResult Function(_GetAllRecipientFailed value)
        getAllRecipientFailed,
  }) {
    return getAllRecipientFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult? Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
  }) {
    return getAllRecipientFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetAllRecipientSuccess value)? getAllRecipientSuccess,
    TResult Function(_GetAllRecipientFailed value)? getAllRecipientFailed,
    required TResult orElse(),
  }) {
    if (getAllRecipientFailed != null) {
      return getAllRecipientFailed(this);
    }
    return orElse();
  }
}

abstract class _GetAllRecipientFailed extends RecipientState {
  const factory _GetAllRecipientFailed(
      {required final RecipientData data,
      required final String message}) = _$_GetAllRecipientFailed;
  const _GetAllRecipientFailed._() : super._();

  @override
  RecipientData get data;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_GetAllRecipientFailedCopyWith<_$_GetAllRecipientFailed> get copyWith =>
      throw _privateConstructorUsedError;
}
