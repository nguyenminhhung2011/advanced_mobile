// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CoursePreview {
  String get courseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoursePreviewCopyWith<CoursePreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursePreviewCopyWith<$Res> {
  factory $CoursePreviewCopyWith(
          CoursePreview value, $Res Function(CoursePreview) then) =
      _$CoursePreviewCopyWithImpl<$Res, CoursePreview>;
  @useResult
  $Res call({String courseId, String name});
}

/// @nodoc
class _$CoursePreviewCopyWithImpl<$Res, $Val extends CoursePreview>
    implements $CoursePreviewCopyWith<$Res> {
  _$CoursePreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoursePreviewCopyWith<$Res>
    implements $CoursePreviewCopyWith<$Res> {
  factory _$$_CoursePreviewCopyWith(
          _$_CoursePreview value, $Res Function(_$_CoursePreview) then) =
      __$$_CoursePreviewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String courseId, String name});
}

/// @nodoc
class __$$_CoursePreviewCopyWithImpl<$Res>
    extends _$CoursePreviewCopyWithImpl<$Res, _$_CoursePreview>
    implements _$$_CoursePreviewCopyWith<$Res> {
  __$$_CoursePreviewCopyWithImpl(
      _$_CoursePreview _value, $Res Function(_$_CoursePreview) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? name = null,
  }) {
    return _then(_$_CoursePreview(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CoursePreview implements _CoursePreview {
  const _$_CoursePreview({required this.courseId, required this.name});

  @override
  final String courseId;
  @override
  final String name;

  @override
  String toString() {
    return 'CoursePreview(courseId: $courseId, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoursePreview &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, courseId, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoursePreviewCopyWith<_$_CoursePreview> get copyWith =>
      __$$_CoursePreviewCopyWithImpl<_$_CoursePreview>(this, _$identity);
}

abstract class _CoursePreview implements CoursePreview {
  const factory _CoursePreview(
      {required final String courseId,
      required final String name}) = _$_CoursePreview;

  @override
  String get courseId;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_CoursePreviewCopyWith<_$_CoursePreview> get copyWith =>
      throw _privateConstructorUsedError;
}
