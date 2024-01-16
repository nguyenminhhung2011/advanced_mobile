// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatInformation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatInformationCopyWith<ChatInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatInformationCopyWith<$Res> {
  factory $ChatInformationCopyWith(
          ChatInformation value, $Res Function(ChatInformation) then) =
      _$ChatInformationCopyWithImpl<$Res, ChatInformation>;
  @useResult
  $Res call({String id, String name, String? avatar});
}

/// @nodoc
class _$ChatInformationCopyWithImpl<$Res, $Val extends ChatInformation>
    implements $ChatInformationCopyWith<$Res> {
  _$ChatInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatInformationCopyWith<$Res>
    implements $ChatInformationCopyWith<$Res> {
  factory _$$_ChatInformationCopyWith(
          _$_ChatInformation value, $Res Function(_$_ChatInformation) then) =
      __$$_ChatInformationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? avatar});
}

/// @nodoc
class __$$_ChatInformationCopyWithImpl<$Res>
    extends _$ChatInformationCopyWithImpl<$Res, _$_ChatInformation>
    implements _$$_ChatInformationCopyWith<$Res> {
  __$$_ChatInformationCopyWithImpl(
      _$_ChatInformation _value, $Res Function(_$_ChatInformation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$_ChatInformation(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ChatInformation implements _ChatInformation {
  const _$_ChatInformation({required this.id, required this.name, this.avatar});

  @override
  final String id;
  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ChatInformation(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatInformation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatInformationCopyWith<_$_ChatInformation> get copyWith =>
      __$$_ChatInformationCopyWithImpl<_$_ChatInformation>(this, _$identity);
}

abstract class _ChatInformation implements ChatInformation {
  const factory _ChatInformation(
      {required final String id,
      required final String name,
      final String? avatar}) = _$_ChatInformation;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$_ChatInformationCopyWith<_$_ChatInformation> get copyWith =>
      throw _privateConstructorUsedError;
}
