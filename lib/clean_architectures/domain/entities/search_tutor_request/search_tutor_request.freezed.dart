// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_tutor_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchTutorRequest {
  int get perPage => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  List<String> get topics => throw _privateConstructorUsedError;
  Map<String, dynamic> get nationality => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchTutorRequestCopyWith<SearchTutorRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchTutorRequestCopyWith<$Res> {
  factory $SearchTutorRequestCopyWith(
          SearchTutorRequest value, $Res Function(SearchTutorRequest) then) =
      _$SearchTutorRequestCopyWithImpl<$Res, SearchTutorRequest>;
  @useResult
  $Res call(
      {int perPage,
      int page,
      String search,
      List<String> topics,
      Map<String, dynamic> nationality});
}

/// @nodoc
class _$SearchTutorRequestCopyWithImpl<$Res, $Val extends SearchTutorRequest>
    implements $SearchTutorRequestCopyWith<$Res> {
  _$SearchTutorRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = null,
    Object? page = null,
    Object? search = null,
    Object? topics = null,
    Object? nationality = null,
  }) {
    return _then(_value.copyWith(
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: null == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchTutorRequestCopyWith<$Res>
    implements $SearchTutorRequestCopyWith<$Res> {
  factory _$$_SearchTutorRequestCopyWith(_$_SearchTutorRequest value,
          $Res Function(_$_SearchTutorRequest) then) =
      __$$_SearchTutorRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int perPage,
      int page,
      String search,
      List<String> topics,
      Map<String, dynamic> nationality});
}

/// @nodoc
class __$$_SearchTutorRequestCopyWithImpl<$Res>
    extends _$SearchTutorRequestCopyWithImpl<$Res, _$_SearchTutorRequest>
    implements _$$_SearchTutorRequestCopyWith<$Res> {
  __$$_SearchTutorRequestCopyWithImpl(
      _$_SearchTutorRequest _value, $Res Function(_$_SearchTutorRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? perPage = null,
    Object? page = null,
    Object? search = null,
    Object? topics = null,
    Object? nationality = null,
  }) {
    return _then(_$_SearchTutorRequest(
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: null == nationality
          ? _value._nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$_SearchTutorRequest implements _SearchTutorRequest {
  const _$_SearchTutorRequest(
      {required this.perPage,
      required this.page,
      required this.search,
      required final List<String> topics,
      required final Map<String, dynamic> nationality})
      : _topics = topics,
        _nationality = nationality;

  @override
  final int perPage;
  @override
  final int page;
  @override
  final String search;
  final List<String> _topics;
  @override
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  final Map<String, dynamic> _nationality;
  @override
  Map<String, dynamic> get nationality {
    if (_nationality is EqualUnmodifiableMapView) return _nationality;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nationality);
  }

  @override
  String toString() {
    return 'SearchTutorRequest(perPage: $perPage, page: $page, search: $search, topics: $topics, nationality: $nationality)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchTutorRequest &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.search, search) || other.search == search) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality()
                .equals(other._nationality, _nationality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      perPage,
      page,
      search,
      const DeepCollectionEquality().hash(_topics),
      const DeepCollectionEquality().hash(_nationality));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchTutorRequestCopyWith<_$_SearchTutorRequest> get copyWith =>
      __$$_SearchTutorRequestCopyWithImpl<_$_SearchTutorRequest>(
          this, _$identity);
}

abstract class _SearchTutorRequest implements SearchTutorRequest {
  const factory _SearchTutorRequest(
      {required final int perPage,
      required final int page,
      required final String search,
      required final List<String> topics,
      required final Map<String, dynamic> nationality}) = _$_SearchTutorRequest;

  @override
  int get perPage;
  @override
  int get page;
  @override
  String get search;
  @override
  List<String> get topics;
  @override
  Map<String, dynamic> get nationality;
  @override
  @JsonKey(ignore: true)
  _$$_SearchTutorRequestCopyWith<_$_SearchTutorRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
