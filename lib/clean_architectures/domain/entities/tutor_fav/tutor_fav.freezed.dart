// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_fav.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TutorFav {
  Pagination<Tutor> get tutors => throw _privateConstructorUsedError;
  List<String> get fav => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TutorFavCopyWith<TutorFav> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TutorFavCopyWith<$Res> {
  factory $TutorFavCopyWith(TutorFav value, $Res Function(TutorFav) then) =
      _$TutorFavCopyWithImpl<$Res, TutorFav>;
  @useResult
  $Res call({Pagination<Tutor> tutors, List<String> fav});

  $PaginationCopyWith<Tutor, $Res> get tutors;
}

/// @nodoc
class _$TutorFavCopyWithImpl<$Res, $Val extends TutorFav>
    implements $TutorFavCopyWith<$Res> {
  _$TutorFavCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tutors = null,
    Object? fav = null,
  }) {
    return _then(_value.copyWith(
      tutors: null == tutors
          ? _value.tutors
          : tutors // ignore: cast_nullable_to_non_nullable
              as Pagination<Tutor>,
      fav: null == fav
          ? _value.fav
          : fav // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<Tutor, $Res> get tutors {
    return $PaginationCopyWith<Tutor, $Res>(_value.tutors, (value) {
      return _then(_value.copyWith(tutors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TutorFavCopyWith<$Res> implements $TutorFavCopyWith<$Res> {
  factory _$$_TutorFavCopyWith(
          _$_TutorFav value, $Res Function(_$_TutorFav) then) =
      __$$_TutorFavCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Pagination<Tutor> tutors, List<String> fav});

  @override
  $PaginationCopyWith<Tutor, $Res> get tutors;
}

/// @nodoc
class __$$_TutorFavCopyWithImpl<$Res>
    extends _$TutorFavCopyWithImpl<$Res, _$_TutorFav>
    implements _$$_TutorFavCopyWith<$Res> {
  __$$_TutorFavCopyWithImpl(
      _$_TutorFav _value, $Res Function(_$_TutorFav) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tutors = null,
    Object? fav = null,
  }) {
    return _then(_$_TutorFav(
      tutors: null == tutors
          ? _value.tutors
          : tutors // ignore: cast_nullable_to_non_nullable
              as Pagination<Tutor>,
      fav: null == fav
          ? _value._fav
          : fav // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_TutorFav implements _TutorFav {
  const _$_TutorFav(
      {this.tutors = const Pagination<Tutor>(
          rows: <Tutor>[], count: 0, perPage: 10, currentPage: 0),
      final List<String> fav = const <String>[]})
      : _fav = fav;

  @override
  @JsonKey()
  final Pagination<Tutor> tutors;
  final List<String> _fav;
  @override
  @JsonKey()
  List<String> get fav {
    if (_fav is EqualUnmodifiableListView) return _fav;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fav);
  }

  @override
  String toString() {
    return 'TutorFav(tutors: $tutors, fav: $fav)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TutorFav &&
            (identical(other.tutors, tutors) || other.tutors == tutors) &&
            const DeepCollectionEquality().equals(other._fav, _fav));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tutors, const DeepCollectionEquality().hash(_fav));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TutorFavCopyWith<_$_TutorFav> get copyWith =>
      __$$_TutorFavCopyWithImpl<_$_TutorFav>(this, _$identity);
}

abstract class _TutorFav implements TutorFav {
  const factory _TutorFav(
      {final Pagination<Tutor> tutors, final List<String> fav}) = _$_TutorFav;

  @override
  Pagination<Tutor> get tutors;
  @override
  List<String> get fav;
  @override
  @JsonKey(ignore: true)
  _$$_TutorFavCopyWith<_$_TutorFav> get copyWith =>
      throw _privateConstructorUsedError;
}
