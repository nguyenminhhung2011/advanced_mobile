// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CourseCategory {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get key => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CourseCategoryCopyWith<CourseCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCategoryCopyWith<$Res> {
  factory $CourseCategoryCopyWith(
          CourseCategory value, $Res Function(CourseCategory) then) =
      _$CourseCategoryCopyWithImpl<$Res, CourseCategory>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String? key,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CourseCategoryCopyWithImpl<$Res, $Val extends CourseCategory>
    implements $CourseCategoryCopyWith<$Res> {
  _$CourseCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? key = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CourseCategoryCopyWith<$Res>
    implements $CourseCategoryCopyWith<$Res> {
  factory _$$_CourseCategoryCopyWith(
          _$_CourseCategory value, $Res Function(_$_CourseCategory) then) =
      __$$_CourseCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String? key,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_CourseCategoryCopyWithImpl<$Res>
    extends _$CourseCategoryCopyWithImpl<$Res, _$_CourseCategory>
    implements _$$_CourseCategoryCopyWith<$Res> {
  __$$_CourseCategoryCopyWithImpl(
      _$_CourseCategory _value, $Res Function(_$_CourseCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? key = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_CourseCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_CourseCategory implements _CourseCategory {
  const _$_CourseCategory(
      {required this.id,
      this.title = '',
      this.description = '',
      this.key,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final String? key;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CourseCategory(id: $id, title: $title, description: $description, key: $key, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourseCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, key, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CourseCategoryCopyWith<_$_CourseCategory> get copyWith =>
      __$$_CourseCategoryCopyWithImpl<_$_CourseCategory>(this, _$identity);
}

abstract class _CourseCategory implements CourseCategory {
  const factory _CourseCategory(
      {required final String id,
      final String title,
      final String description,
      final String? key,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_CourseCategory;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get key;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_CourseCategoryCopyWith<_$_CourseCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
