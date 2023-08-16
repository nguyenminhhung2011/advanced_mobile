// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_modal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingModalState {
  Appearance get appearance => throw _privateConstructorUsedError;
  Currencies get currencies => throw _privateConstructorUsedError;
  String get langCode => throw _privateConstructorUsedError;
  Locale get currentLocale => throw _privateConstructorUsedError;
  String get passCode => throw _privateConstructorUsedError;
  User? get currentUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingModalStateCopyWith<SettingModalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingModalStateCopyWith<$Res> {
  factory $SettingModalStateCopyWith(
          SettingModalState value, $Res Function(SettingModalState) then) =
      _$SettingModalStateCopyWithImpl<$Res, SettingModalState>;
  @useResult
  $Res call(
      {Appearance appearance,
      Currencies currencies,
      String langCode,
      Locale currentLocale,
      String passCode,
      User? currentUser});

  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$SettingModalStateCopyWithImpl<$Res, $Val extends SettingModalState>
    implements $SettingModalStateCopyWith<$Res> {
  _$SettingModalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appearance = null,
    Object? currencies = null,
    Object? langCode = null,
    Object? currentLocale = null,
    Object? passCode = null,
    Object? currentUser = freezed,
  }) {
    return _then(_value.copyWith(
      appearance: null == appearance
          ? _value.appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as Appearance,
      currencies: null == currencies
          ? _value.currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as Currencies,
      langCode: null == langCode
          ? _value.langCode
          : langCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocale: null == currentLocale
          ? _value.currentLocale
          : currentLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      passCode: null == passCode
          ? _value.passCode
          : passCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get currentUser {
    if (_value.currentUser == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.currentUser!, (value) {
      return _then(_value.copyWith(currentUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SettingModalStateCopyWith<$Res>
    implements $SettingModalStateCopyWith<$Res> {
  factory _$$_SettingModalStateCopyWith(_$_SettingModalState value,
          $Res Function(_$_SettingModalState) then) =
      __$$_SettingModalStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Appearance appearance,
      Currencies currencies,
      String langCode,
      Locale currentLocale,
      String passCode,
      User? currentUser});

  @override
  $UserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$$_SettingModalStateCopyWithImpl<$Res>
    extends _$SettingModalStateCopyWithImpl<$Res, _$_SettingModalState>
    implements _$$_SettingModalStateCopyWith<$Res> {
  __$$_SettingModalStateCopyWithImpl(
      _$_SettingModalState _value, $Res Function(_$_SettingModalState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appearance = null,
    Object? currencies = null,
    Object? langCode = null,
    Object? currentLocale = null,
    Object? passCode = null,
    Object? currentUser = freezed,
  }) {
    return _then(_$_SettingModalState(
      appearance: null == appearance
          ? _value.appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as Appearance,
      currencies: null == currencies
          ? _value.currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as Currencies,
      langCode: null == langCode
          ? _value.langCode
          : langCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentLocale: null == currentLocale
          ? _value.currentLocale
          : currentLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      passCode: null == passCode
          ? _value.passCode
          : passCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_SettingModalState implements _SettingModalState {
  const _$_SettingModalState(
      {this.appearance = Appearance.light,
      this.currencies = Currencies.usd,
      this.langCode = 'en',
      this.currentLocale = const Locale('en', ''),
      this.passCode = '',
      this.currentUser});

  @override
  @JsonKey()
  final Appearance appearance;
  @override
  @JsonKey()
  final Currencies currencies;
  @override
  @JsonKey()
  final String langCode;
  @override
  @JsonKey()
  final Locale currentLocale;
  @override
  @JsonKey()
  final String passCode;
  @override
  final User? currentUser;

  @override
  String toString() {
    return 'SettingModalState(appearance: $appearance, currencies: $currencies, langCode: $langCode, currentLocale: $currentLocale, passCode: $passCode, currentUser: $currentUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingModalState &&
            (identical(other.appearance, appearance) ||
                other.appearance == appearance) &&
            (identical(other.currencies, currencies) ||
                other.currencies == currencies) &&
            (identical(other.langCode, langCode) ||
                other.langCode == langCode) &&
            (identical(other.currentLocale, currentLocale) ||
                other.currentLocale == currentLocale) &&
            (identical(other.passCode, passCode) ||
                other.passCode == passCode) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appearance, currencies, langCode,
      currentLocale, passCode, currentUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingModalStateCopyWith<_$_SettingModalState> get copyWith =>
      __$$_SettingModalStateCopyWithImpl<_$_SettingModalState>(
          this, _$identity);
}

abstract class _SettingModalState implements SettingModalState {
  const factory _SettingModalState(
      {final Appearance appearance,
      final Currencies currencies,
      final String langCode,
      final Locale currentLocale,
      final String passCode,
      final User? currentUser}) = _$_SettingModalState;

  @override
  Appearance get appearance;
  @override
  Currencies get currencies;
  @override
  String get langCode;
  @override
  Locale get currentLocale;
  @override
  String get passCode;
  @override
  User? get currentUser;
  @override
  @JsonKey(ignore: true)
  _$$_SettingModalStateCopyWith<_$_SettingModalState> get copyWith =>
      throw _privateConstructorUsedError;
}
