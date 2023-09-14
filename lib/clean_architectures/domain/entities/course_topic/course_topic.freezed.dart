// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CourseTopic {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get orderCourse => throw _privateConstructorUsedError;
  String? get nameFile => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CourseTopicCopyWith<CourseTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseTopicCopyWith<$Res> {
  factory $CourseTopicCopyWith(
          CourseTopic value, $Res Function(CourseTopic) then) =
      _$CourseTopicCopyWithImpl<$Res, CourseTopic>;
  @useResult
  $Res call(
      {String id,
      String courseId,
      String name,
      String description,
      int? orderCourse,
      String? nameFile,
      String? videoUrl,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CourseTopicCopyWithImpl<$Res, $Val extends CourseTopic>
    implements $CourseTopicCopyWith<$Res> {
  _$CourseTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? name = null,
    Object? description = null,
    Object? orderCourse = freezed,
    Object? nameFile = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orderCourse: freezed == orderCourse
          ? _value.orderCourse
          : orderCourse // ignore: cast_nullable_to_non_nullable
              as int?,
      nameFile: freezed == nameFile
          ? _value.nameFile
          : nameFile // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_CourseTopicCopyWith<$Res>
    implements $CourseTopicCopyWith<$Res> {
  factory _$$_CourseTopicCopyWith(
          _$_CourseTopic value, $Res Function(_$_CourseTopic) then) =
      __$$_CourseTopicCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String courseId,
      String name,
      String description,
      int? orderCourse,
      String? nameFile,
      String? videoUrl,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_CourseTopicCopyWithImpl<$Res>
    extends _$CourseTopicCopyWithImpl<$Res, _$_CourseTopic>
    implements _$$_CourseTopicCopyWith<$Res> {
  __$$_CourseTopicCopyWithImpl(
      _$_CourseTopic _value, $Res Function(_$_CourseTopic) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? name = null,
    Object? description = null,
    Object? orderCourse = freezed,
    Object? nameFile = freezed,
    Object? videoUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_CourseTopic(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orderCourse: freezed == orderCourse
          ? _value.orderCourse
          : orderCourse // ignore: cast_nullable_to_non_nullable
              as int?,
      nameFile: freezed == nameFile
          ? _value.nameFile
          : nameFile // ignore: cast_nullable_to_non_nullable
              as String?,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
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

class _$_CourseTopic implements _CourseTopic {
  const _$_CourseTopic(
      {required this.id,
      required this.courseId,
      this.name = '',
      this.description = '',
      this.orderCourse,
      this.nameFile,
      this.videoUrl,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;
  @override
  final String courseId;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final int? orderCourse;
  @override
  final String? nameFile;
  @override
  final String? videoUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CourseTopic(id: $id, courseId: $courseId, name: $name, description: $description, orderCourse: $orderCourse, nameFile: $nameFile, videoUrl: $videoUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CourseTopic &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderCourse, orderCourse) ||
                other.orderCourse == orderCourse) &&
            (identical(other.nameFile, nameFile) ||
                other.nameFile == nameFile) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, courseId, name, description,
      orderCourse, nameFile, videoUrl, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CourseTopicCopyWith<_$_CourseTopic> get copyWith =>
      __$$_CourseTopicCopyWithImpl<_$_CourseTopic>(this, _$identity);
}

abstract class _CourseTopic implements CourseTopic {
  const factory _CourseTopic(
      {required final String id,
      required final String courseId,
      final String name,
      final String description,
      final int? orderCourse,
      final String? nameFile,
      final String? videoUrl,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_CourseTopic;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get name;
  @override
  String get description;
  @override
  int? get orderCourse;
  @override
  String? get nameFile;
  @override
  String? get videoUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_CourseTopicCopyWith<_$_CourseTopic> get copyWith =>
      throw _privateConstructorUsedError;
}
