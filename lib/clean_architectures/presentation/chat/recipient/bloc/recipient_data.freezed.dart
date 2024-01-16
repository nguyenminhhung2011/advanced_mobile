// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipient_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipientData {
  List<Chat> get recipients => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipientDataCopyWith<RecipientData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientDataCopyWith<$Res> {
  factory $RecipientDataCopyWith(
          RecipientData value, $Res Function(RecipientData) then) =
      _$RecipientDataCopyWithImpl<$Res, RecipientData>;
  @useResult
  $Res call({List<Chat> recipients});
}

/// @nodoc
class _$RecipientDataCopyWithImpl<$Res, $Val extends RecipientData>
    implements $RecipientDataCopyWith<$Res> {
  _$RecipientDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipients = null,
  }) {
    return _then(_value.copyWith(
      recipients: null == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecipientDataCopyWith<$Res>
    implements $RecipientDataCopyWith<$Res> {
  factory _$$_RecipientDataCopyWith(
          _$_RecipientData value, $Res Function(_$_RecipientData) then) =
      __$$_RecipientDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Chat> recipients});
}

/// @nodoc
class __$$_RecipientDataCopyWithImpl<$Res>
    extends _$RecipientDataCopyWithImpl<$Res, _$_RecipientData>
    implements _$$_RecipientDataCopyWith<$Res> {
  __$$_RecipientDataCopyWithImpl(
      _$_RecipientData _value, $Res Function(_$_RecipientData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipients = null,
  }) {
    return _then(_$_RecipientData(
      recipients: null == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ));
  }
}

/// @nodoc

class _$_RecipientData implements _RecipientData {
  const _$_RecipientData({required final List<Chat> recipients})
      : _recipients = recipients;

  final List<Chat> _recipients;
  @override
  List<Chat> get recipients {
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipients);
  }

  @override
  String toString() {
    return 'RecipientData(recipients: $recipients)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecipientData &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_recipients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecipientDataCopyWith<_$_RecipientData> get copyWith =>
      __$$_RecipientDataCopyWithImpl<_$_RecipientData>(this, _$identity);
}

abstract class _RecipientData implements RecipientData {
  const factory _RecipientData({required final List<Chat> recipients}) =
      _$_RecipientData;

  @override
  List<Chat> get recipients;
  @override
  @JsonKey(ignore: true)
  _$$_RecipientDataCopyWith<_$_RecipientData> get copyWith =>
      throw _privateConstructorUsedError;
}
