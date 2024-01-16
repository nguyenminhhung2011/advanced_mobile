// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Chat {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  ChatInformation get fromInfo => throw _privateConstructorUsedError;
  ChatInformation get toInfo => throw _privateConstructorUsedError;
  ChatInformation? get partner => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {String id,
      String content,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isRead,
      ChatInformation fromInfo,
      ChatInformation toInfo,
      ChatInformation? partner});

  $ChatInformationCopyWith<$Res> get fromInfo;
  $ChatInformationCopyWith<$Res> get toInfo;
  $ChatInformationCopyWith<$Res>? get partner;
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isRead = null,
    Object? fromInfo = null,
    Object? toInfo = null,
    Object? partner = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      fromInfo: null == fromInfo
          ? _value.fromInfo
          : fromInfo // ignore: cast_nullable_to_non_nullable
              as ChatInformation,
      toInfo: null == toInfo
          ? _value.toInfo
          : toInfo // ignore: cast_nullable_to_non_nullable
              as ChatInformation,
      partner: freezed == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as ChatInformation?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatInformationCopyWith<$Res> get fromInfo {
    return $ChatInformationCopyWith<$Res>(_value.fromInfo, (value) {
      return _then(_value.copyWith(fromInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatInformationCopyWith<$Res> get toInfo {
    return $ChatInformationCopyWith<$Res>(_value.toInfo, (value) {
      return _then(_value.copyWith(toInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatInformationCopyWith<$Res>? get partner {
    if (_value.partner == null) {
      return null;
    }

    return $ChatInformationCopyWith<$Res>(_value.partner!, (value) {
      return _then(_value.copyWith(partner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$_ChatCopyWith(_$_Chat value, $Res Function(_$_Chat) then) =
      __$$_ChatCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String content,
      DateTime createdAt,
      DateTime? updatedAt,
      bool isRead,
      ChatInformation fromInfo,
      ChatInformation toInfo,
      ChatInformation? partner});

  @override
  $ChatInformationCopyWith<$Res> get fromInfo;
  @override
  $ChatInformationCopyWith<$Res> get toInfo;
  @override
  $ChatInformationCopyWith<$Res>? get partner;
}

/// @nodoc
class __$$_ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res, _$_Chat>
    implements _$$_ChatCopyWith<$Res> {
  __$$_ChatCopyWithImpl(_$_Chat _value, $Res Function(_$_Chat) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isRead = null,
    Object? fromInfo = null,
    Object? toInfo = null,
    Object? partner = freezed,
  }) {
    return _then(_$_Chat(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      fromInfo: null == fromInfo
          ? _value.fromInfo
          : fromInfo // ignore: cast_nullable_to_non_nullable
              as ChatInformation,
      toInfo: null == toInfo
          ? _value.toInfo
          : toInfo // ignore: cast_nullable_to_non_nullable
              as ChatInformation,
      partner: freezed == partner
          ? _value.partner
          : partner // ignore: cast_nullable_to_non_nullable
              as ChatInformation?,
    ));
  }
}

/// @nodoc

class _$_Chat implements _Chat {
  const _$_Chat(
      {required this.id,
      required this.content,
      required this.createdAt,
      this.updatedAt,
      required this.isRead,
      required this.fromInfo,
      required this.toInfo,
      this.partner});

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final bool isRead;
  @override
  final ChatInformation fromInfo;
  @override
  final ChatInformation toInfo;
  @override
  final ChatInformation? partner;

  @override
  String toString() {
    return 'Chat(id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isRead: $isRead, fromInfo: $fromInfo, toInfo: $toInfo, partner: $partner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chat &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.fromInfo, fromInfo) ||
                other.fromInfo == fromInfo) &&
            (identical(other.toInfo, toInfo) || other.toInfo == toInfo) &&
            (identical(other.partner, partner) || other.partner == partner));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt,
      updatedAt, isRead, fromInfo, toInfo, partner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatCopyWith<_$_Chat> get copyWith =>
      __$$_ChatCopyWithImpl<_$_Chat>(this, _$identity);
}

abstract class _Chat implements Chat {
  const factory _Chat(
      {required final String id,
      required final String content,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      required final bool isRead,
      required final ChatInformation fromInfo,
      required final ChatInformation toInfo,
      final ChatInformation? partner}) = _$_Chat;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isRead;
  @override
  ChatInformation get fromInfo;
  @override
  ChatInformation get toInfo;
  @override
  ChatInformation? get partner;
  @override
  @JsonKey(ignore: true)
  _$$_ChatCopyWith<_$_Chat> get copyWith => throw _privateConstructorUsedError;
}
