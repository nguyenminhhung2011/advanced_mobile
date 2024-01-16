// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatDetailData {
  Pagination<Chat> get chat => throw _privateConstructorUsedError;
  TutorDetail? get tutor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatDetailDataCopyWith<ChatDetailData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailDataCopyWith<$Res> {
  factory $ChatDetailDataCopyWith(
          ChatDetailData value, $Res Function(ChatDetailData) then) =
      _$ChatDetailDataCopyWithImpl<$Res, ChatDetailData>;
  @useResult
  $Res call({Pagination<Chat> chat, TutorDetail? tutor});

  $PaginationCopyWith<Chat, $Res> get chat;
  $TutorDetailCopyWith<$Res>? get tutor;
}

/// @nodoc
class _$ChatDetailDataCopyWithImpl<$Res, $Val extends ChatDetailData>
    implements $ChatDetailDataCopyWith<$Res> {
  _$ChatDetailDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
    Object? tutor = freezed,
  }) {
    return _then(_value.copyWith(
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Pagination<Chat>,
      tutor: freezed == tutor
          ? _value.tutor
          : tutor // ignore: cast_nullable_to_non_nullable
              as TutorDetail?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<Chat, $Res> get chat {
    return $PaginationCopyWith<Chat, $Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TutorDetailCopyWith<$Res>? get tutor {
    if (_value.tutor == null) {
      return null;
    }

    return $TutorDetailCopyWith<$Res>(_value.tutor!, (value) {
      return _then(_value.copyWith(tutor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatDetailDataCopyWith<$Res>
    implements $ChatDetailDataCopyWith<$Res> {
  factory _$$_ChatDetailDataCopyWith(
          _$_ChatDetailData value, $Res Function(_$_ChatDetailData) then) =
      __$$_ChatDetailDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Pagination<Chat> chat, TutorDetail? tutor});

  @override
  $PaginationCopyWith<Chat, $Res> get chat;
  @override
  $TutorDetailCopyWith<$Res>? get tutor;
}

/// @nodoc
class __$$_ChatDetailDataCopyWithImpl<$Res>
    extends _$ChatDetailDataCopyWithImpl<$Res, _$_ChatDetailData>
    implements _$$_ChatDetailDataCopyWith<$Res> {
  __$$_ChatDetailDataCopyWithImpl(
      _$_ChatDetailData _value, $Res Function(_$_ChatDetailData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
    Object? tutor = freezed,
  }) {
    return _then(_$_ChatDetailData(
      chat: null == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Pagination<Chat>,
      tutor: freezed == tutor
          ? _value.tutor
          : tutor // ignore: cast_nullable_to_non_nullable
              as TutorDetail?,
    ));
  }
}

/// @nodoc

class _$_ChatDetailData implements _ChatDetailData {
  const _$_ChatDetailData({required this.chat, this.tutor});

  @override
  final Pagination<Chat> chat;
  @override
  final TutorDetail? tutor;

  @override
  String toString() {
    return 'ChatDetailData(chat: $chat, tutor: $tutor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatDetailData &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.tutor, tutor) || other.tutor == tutor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, chat, tutor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatDetailDataCopyWith<_$_ChatDetailData> get copyWith =>
      __$$_ChatDetailDataCopyWithImpl<_$_ChatDetailData>(this, _$identity);
}

abstract class _ChatDetailData implements ChatDetailData {
  const factory _ChatDetailData(
      {required final Pagination<Chat> chat,
      final TutorDetail? tutor}) = _$_ChatDetailData;

  @override
  Pagination<Chat> get chat;
  @override
  TutorDetail? get tutor;
  @override
  @JsonKey(ignore: true)
  _$$_ChatDetailDataCopyWith<_$_ChatDetailData> get copyWith =>
      throw _privateConstructorUsedError;
}
