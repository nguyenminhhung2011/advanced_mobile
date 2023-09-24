// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReviewUser {
  String get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReviewUserCopyWith<ReviewUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewUserCopyWith<$Res> {
  factory $ReviewUserCopyWith(
          ReviewUser value, $Res Function(ReviewUser) then) =
      _$ReviewUserCopyWithImpl<$Res, ReviewUser>;
  @useResult
  $Res call({String name, String? avatar});
}

/// @nodoc
class _$ReviewUserCopyWithImpl<$Res, $Val extends ReviewUser>
    implements $ReviewUserCopyWith<$Res> {
  _$ReviewUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$_ReviewUserCopyWith<$Res>
    implements $ReviewUserCopyWith<$Res> {
  factory _$$_ReviewUserCopyWith(
          _$_ReviewUser value, $Res Function(_$_ReviewUser) then) =
      __$$_ReviewUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? avatar});
}

/// @nodoc
class __$$_ReviewUserCopyWithImpl<$Res>
    extends _$ReviewUserCopyWithImpl<$Res, _$_ReviewUser>
    implements _$$_ReviewUserCopyWith<$Res> {
  __$$_ReviewUserCopyWithImpl(
      _$_ReviewUser _value, $Res Function(_$_ReviewUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? avatar = freezed,
  }) {
    return _then(_$_ReviewUser(
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

class _$_ReviewUser implements _ReviewUser {
  const _$_ReviewUser({required this.name, this.avatar});

  @override
  final String name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'ReviewUser(name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReviewUser &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReviewUserCopyWith<_$_ReviewUser> get copyWith =>
      __$$_ReviewUserCopyWithImpl<_$_ReviewUser>(this, _$identity);
}

abstract class _ReviewUser implements ReviewUser {
  const factory _ReviewUser(
      {required final String name, final String? avatar}) = _$_ReviewUser;

  @override
  String get name;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$_ReviewUserCopyWith<_$_ReviewUser> get copyWith =>
      throw _privateConstructorUsedError;
}
