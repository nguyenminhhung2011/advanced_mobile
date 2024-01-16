// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatDetailState {
  ChatDetailData get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatDetailStateCopyWith<ChatDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailStateCopyWith<$Res> {
  factory $ChatDetailStateCopyWith(
          ChatDetailState value, $Res Function(ChatDetailState) then) =
      _$ChatDetailStateCopyWithImpl<$Res, ChatDetailState>;
  @useResult
  $Res call({ChatDetailData data});

  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ChatDetailStateCopyWithImpl<$Res, $Val extends ChatDetailState>
    implements $ChatDetailStateCopyWith<$Res> {
  _$ChatDetailStateCopyWithImpl(this._value, this._then);

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
              as ChatDetailData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatDetailDataCopyWith<$Res> get data {
    return $ChatDetailDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_Initial>
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
              as ChatDetailData,
    ));
  }
}

/// @nodoc

class _$_Initial extends _Initial {
  const _$_Initial({required this.data}) : super._();

  @override
  final ChatDetailData data;

  @override
  String toString() {
    return 'ChatDetailState.initial(data: $data)';
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
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return initial(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return initial?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
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
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends ChatDetailState {
  const factory _Initial({required final ChatDetailData data}) = _$_Initial;
  const _Initial._() : super._();

  @override
  ChatDetailData get data;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_Loading>
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
              as ChatDetailData,
    ));
  }
}

/// @nodoc

class _$_Loading extends _Loading {
  const _$_Loading({required this.data}) : super._();

  @override
  final ChatDetailData data;

  @override
  String toString() {
    return 'ChatDetailState.loading(data: $data)';
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
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return loading(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return loading?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
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
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends ChatDetailState {
  const factory _Loading({required final ChatDetailData data}) = _$_Loading;
  const _Loading._() : super._();

  @override
  ChatDetailData get data;
  @override
  @JsonKey(ignore: true)
  _$$_LoadingCopyWith<_$_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetMessageSuccessCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_GetMessageSuccessCopyWith(_$_GetMessageSuccess value,
          $Res Function(_$_GetMessageSuccess) then) =
      __$$_GetMessageSuccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetMessageSuccessCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_GetMessageSuccess>
    implements _$$_GetMessageSuccessCopyWith<$Res> {
  __$$_GetMessageSuccessCopyWithImpl(
      _$_GetMessageSuccess _value, $Res Function(_$_GetMessageSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_GetMessageSuccess(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatDetailData,
    ));
  }
}

/// @nodoc

class _$_GetMessageSuccess extends _GetMessageSuccess {
  const _$_GetMessageSuccess({required this.data}) : super._();

  @override
  final ChatDetailData data;

  @override
  String toString() {
    return 'ChatDetailState.getMessageSuccess(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetMessageSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetMessageSuccessCopyWith<_$_GetMessageSuccess> get copyWith =>
      __$$_GetMessageSuccessCopyWithImpl<_$_GetMessageSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return getMessageSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return getMessageSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getMessageSuccess != null) {
      return getMessageSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return getMessageSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return getMessageSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getMessageSuccess != null) {
      return getMessageSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetMessageSuccess extends ChatDetailState {
  const factory _GetMessageSuccess({required final ChatDetailData data}) =
      _$_GetMessageSuccess;
  const _GetMessageSuccess._() : super._();

  @override
  ChatDetailData get data;
  @override
  @JsonKey(ignore: true)
  _$$_GetMessageSuccessCopyWith<_$_GetMessageSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetMessageFailedCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_GetMessageFailedCopyWith(
          _$_GetMessageFailed value, $Res Function(_$_GetMessageFailed) then) =
      __$$_GetMessageFailedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data, String message});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetMessageFailedCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_GetMessageFailed>
    implements _$$_GetMessageFailedCopyWith<$Res> {
  __$$_GetMessageFailedCopyWithImpl(
      _$_GetMessageFailed _value, $Res Function(_$_GetMessageFailed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_$_GetMessageFailed(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatDetailData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GetMessageFailed extends _GetMessageFailed {
  const _$_GetMessageFailed({required this.data, required this.message})
      : super._();

  @override
  final ChatDetailData data;
  @override
  final String message;

  @override
  String toString() {
    return 'ChatDetailState.getMessageFailed(data: $data, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetMessageFailed &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetMessageFailedCopyWith<_$_GetMessageFailed> get copyWith =>
      __$$_GetMessageFailedCopyWithImpl<_$_GetMessageFailed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return getMessageFailed(data, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return getMessageFailed?.call(data, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getMessageFailed != null) {
      return getMessageFailed(data, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return getMessageFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return getMessageFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getMessageFailed != null) {
      return getMessageFailed(this);
    }
    return orElse();
  }
}

abstract class _GetMessageFailed extends ChatDetailState {
  const factory _GetMessageFailed(
      {required final ChatDetailData data,
      required final String message}) = _$_GetMessageFailed;
  const _GetMessageFailed._() : super._();

  @override
  ChatDetailData get data;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_GetMessageFailedCopyWith<_$_GetMessageFailed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetTutorSuccessCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_GetTutorSuccessCopyWith(
          _$_GetTutorSuccess value, $Res Function(_$_GetTutorSuccess) then) =
      __$$_GetTutorSuccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetTutorSuccessCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_GetTutorSuccess>
    implements _$$_GetTutorSuccessCopyWith<$Res> {
  __$$_GetTutorSuccessCopyWithImpl(
      _$_GetTutorSuccess _value, $Res Function(_$_GetTutorSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_GetTutorSuccess(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatDetailData,
    ));
  }
}

/// @nodoc

class _$_GetTutorSuccess extends _GetTutorSuccess {
  const _$_GetTutorSuccess({required this.data}) : super._();

  @override
  final ChatDetailData data;

  @override
  String toString() {
    return 'ChatDetailState.getTutorSuccess(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetTutorSuccess &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetTutorSuccessCopyWith<_$_GetTutorSuccess> get copyWith =>
      __$$_GetTutorSuccessCopyWithImpl<_$_GetTutorSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return getTutorSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return getTutorSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getTutorSuccess != null) {
      return getTutorSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return getTutorSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return getTutorSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getTutorSuccess != null) {
      return getTutorSuccess(this);
    }
    return orElse();
  }
}

abstract class _GetTutorSuccess extends ChatDetailState {
  const factory _GetTutorSuccess({required final ChatDetailData data}) =
      _$_GetTutorSuccess;
  const _GetTutorSuccess._() : super._();

  @override
  ChatDetailData get data;
  @override
  @JsonKey(ignore: true)
  _$$_GetTutorSuccessCopyWith<_$_GetTutorSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_GetTutorFailedCopyWith<$Res>
    implements $ChatDetailStateCopyWith<$Res> {
  factory _$$_GetTutorFailedCopyWith(
          _$_GetTutorFailed value, $Res Function(_$_GetTutorFailed) then) =
      __$$_GetTutorFailedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChatDetailData data, String message});

  @override
  $ChatDetailDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$_GetTutorFailedCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$_GetTutorFailed>
    implements _$$_GetTutorFailedCopyWith<$Res> {
  __$$_GetTutorFailedCopyWithImpl(
      _$_GetTutorFailed _value, $Res Function(_$_GetTutorFailed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_$_GetTutorFailed(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ChatDetailData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_GetTutorFailed extends _GetTutorFailed {
  const _$_GetTutorFailed({required this.data, required this.message})
      : super._();

  @override
  final ChatDetailData data;
  @override
  final String message;

  @override
  String toString() {
    return 'ChatDetailState.getTutorFailed(data: $data, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetTutorFailed &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetTutorFailedCopyWith<_$_GetTutorFailed> get copyWith =>
      __$$_GetTutorFailedCopyWithImpl<_$_GetTutorFailed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ChatDetailData data) initial,
    required TResult Function(ChatDetailData data) loading,
    required TResult Function(ChatDetailData data) getMessageSuccess,
    required TResult Function(ChatDetailData data, String message)
        getMessageFailed,
    required TResult Function(ChatDetailData data) getTutorSuccess,
    required TResult Function(ChatDetailData data, String message)
        getTutorFailed,
  }) {
    return getTutorFailed(data, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailData data)? initial,
    TResult? Function(ChatDetailData data)? loading,
    TResult? Function(ChatDetailData data)? getMessageSuccess,
    TResult? Function(ChatDetailData data, String message)? getMessageFailed,
    TResult? Function(ChatDetailData data)? getTutorSuccess,
    TResult? Function(ChatDetailData data, String message)? getTutorFailed,
  }) {
    return getTutorFailed?.call(data, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ChatDetailData data)? initial,
    TResult Function(ChatDetailData data)? loading,
    TResult Function(ChatDetailData data)? getMessageSuccess,
    TResult Function(ChatDetailData data, String message)? getMessageFailed,
    TResult Function(ChatDetailData data)? getTutorSuccess,
    TResult Function(ChatDetailData data, String message)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getTutorFailed != null) {
      return getTutorFailed(data, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetMessageSuccess value) getMessageSuccess,
    required TResult Function(_GetMessageFailed value) getMessageFailed,
    required TResult Function(_GetTutorSuccess value) getTutorSuccess,
    required TResult Function(_GetTutorFailed value) getTutorFailed,
  }) {
    return getTutorFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult? Function(_GetMessageFailed value)? getMessageFailed,
    TResult? Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult? Function(_GetTutorFailed value)? getTutorFailed,
  }) {
    return getTutorFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetMessageSuccess value)? getMessageSuccess,
    TResult Function(_GetMessageFailed value)? getMessageFailed,
    TResult Function(_GetTutorSuccess value)? getTutorSuccess,
    TResult Function(_GetTutorFailed value)? getTutorFailed,
    required TResult orElse(),
  }) {
    if (getTutorFailed != null) {
      return getTutorFailed(this);
    }
    return orElse();
  }
}

abstract class _GetTutorFailed extends ChatDetailState {
  const factory _GetTutorFailed(
      {required final ChatDetailData data,
      required final String message}) = _$_GetTutorFailed;
  const _GetTutorFailed._() : super._();

  @override
  ChatDetailData get data;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_GetTutorFailedCopyWith<_$_GetTutorFailed> get copyWith =>
      throw _privateConstructorUsedError;
}
