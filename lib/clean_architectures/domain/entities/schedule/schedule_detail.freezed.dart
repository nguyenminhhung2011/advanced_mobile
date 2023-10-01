// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScheduleDetail {
  String get id => throw _privateConstructorUsedError;
  String get scheduleId => throw _privateConstructorUsedError;
  String get startPeriod => throw _privateConstructorUsedError;
  String get endPeriod => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get startPeriodTimestamp => throw _privateConstructorUsedError;
  DateTime get endPeriodTimestamp => throw _privateConstructorUsedError;
  ScheduleInfo? get scheduleInfo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleDetailCopyWith<ScheduleDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleDetailCopyWith<$Res> {
  factory $ScheduleDetailCopyWith(
          ScheduleDetail value, $Res Function(ScheduleDetail) then) =
      _$ScheduleDetailCopyWithImpl<$Res, ScheduleDetail>;
  @useResult
  $Res call(
      {String id,
      String scheduleId,
      String startPeriod,
      String endPeriod,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime startPeriodTimestamp,
      DateTime endPeriodTimestamp,
      ScheduleInfo? scheduleInfo});

  $ScheduleInfoCopyWith<$Res>? get scheduleInfo;
}

/// @nodoc
class _$ScheduleDetailCopyWithImpl<$Res, $Val extends ScheduleDetail>
    implements $ScheduleDetailCopyWith<$Res> {
  _$ScheduleDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduleId = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? startPeriodTimestamp = null,
    Object? endPeriodTimestamp = null,
    Object? scheduleInfo = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startPeriodTimestamp: null == startPeriodTimestamp
          ? _value.startPeriodTimestamp
          : startPeriodTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endPeriodTimestamp: null == endPeriodTimestamp
          ? _value.endPeriodTimestamp
          : endPeriodTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleInfo: freezed == scheduleInfo
          ? _value.scheduleInfo
          : scheduleInfo // ignore: cast_nullable_to_non_nullable
              as ScheduleInfo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScheduleInfoCopyWith<$Res>? get scheduleInfo {
    if (_value.scheduleInfo == null) {
      return null;
    }

    return $ScheduleInfoCopyWith<$Res>(_value.scheduleInfo!, (value) {
      return _then(_value.copyWith(scheduleInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ScheduleDetailCopyWith<$Res>
    implements $ScheduleDetailCopyWith<$Res> {
  factory _$$_ScheduleDetailCopyWith(
          _$_ScheduleDetail value, $Res Function(_$_ScheduleDetail) then) =
      __$$_ScheduleDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String scheduleId,
      String startPeriod,
      String endPeriod,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime startPeriodTimestamp,
      DateTime endPeriodTimestamp,
      ScheduleInfo? scheduleInfo});

  @override
  $ScheduleInfoCopyWith<$Res>? get scheduleInfo;
}

/// @nodoc
class __$$_ScheduleDetailCopyWithImpl<$Res>
    extends _$ScheduleDetailCopyWithImpl<$Res, _$_ScheduleDetail>
    implements _$$_ScheduleDetailCopyWith<$Res> {
  __$$_ScheduleDetailCopyWithImpl(
      _$_ScheduleDetail _value, $Res Function(_$_ScheduleDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduleId = null,
    Object? startPeriod = null,
    Object? endPeriod = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? startPeriodTimestamp = null,
    Object? endPeriodTimestamp = null,
    Object? scheduleInfo = freezed,
  }) {
    return _then(_$_ScheduleDetail(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      startPeriod: null == startPeriod
          ? _value.startPeriod
          : startPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      endPeriod: null == endPeriod
          ? _value.endPeriod
          : endPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startPeriodTimestamp: null == startPeriodTimestamp
          ? _value.startPeriodTimestamp
          : startPeriodTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endPeriodTimestamp: null == endPeriodTimestamp
          ? _value.endPeriodTimestamp
          : endPeriodTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      scheduleInfo: freezed == scheduleInfo
          ? _value.scheduleInfo
          : scheduleInfo // ignore: cast_nullable_to_non_nullable
              as ScheduleInfo?,
    ));
  }
}

/// @nodoc

class _$_ScheduleDetail implements _ScheduleDetail {
  const _$_ScheduleDetail(
      {required this.id,
      required this.scheduleId,
      required this.startPeriod,
      required this.endPeriod,
      required this.createdAt,
      required this.updatedAt,
      required this.startPeriodTimestamp,
      required this.endPeriodTimestamp,
      this.scheduleInfo});

  @override
  final String id;
  @override
  final String scheduleId;
  @override
  final String startPeriod;
  @override
  final String endPeriod;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime startPeriodTimestamp;
  @override
  final DateTime endPeriodTimestamp;
  @override
  final ScheduleInfo? scheduleInfo;

  @override
  String toString() {
    return 'ScheduleDetail(id: $id, scheduleId: $scheduleId, startPeriod: $startPeriod, endPeriod: $endPeriod, createdAt: $createdAt, updatedAt: $updatedAt, startPeriodTimestamp: $startPeriodTimestamp, endPeriodTimestamp: $endPeriodTimestamp, scheduleInfo: $scheduleInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScheduleDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.startPeriod, startPeriod) ||
                other.startPeriod == startPeriod) &&
            (identical(other.endPeriod, endPeriod) ||
                other.endPeriod == endPeriod) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.startPeriodTimestamp, startPeriodTimestamp) ||
                other.startPeriodTimestamp == startPeriodTimestamp) &&
            (identical(other.endPeriodTimestamp, endPeriodTimestamp) ||
                other.endPeriodTimestamp == endPeriodTimestamp) &&
            (identical(other.scheduleInfo, scheduleInfo) ||
                other.scheduleInfo == scheduleInfo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      scheduleId,
      startPeriod,
      endPeriod,
      createdAt,
      updatedAt,
      startPeriodTimestamp,
      endPeriodTimestamp,
      scheduleInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScheduleDetailCopyWith<_$_ScheduleDetail> get copyWith =>
      __$$_ScheduleDetailCopyWithImpl<_$_ScheduleDetail>(this, _$identity);
}

abstract class _ScheduleDetail implements ScheduleDetail {
  const factory _ScheduleDetail(
      {required final String id,
      required final String scheduleId,
      required final String startPeriod,
      required final String endPeriod,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime startPeriodTimestamp,
      required final DateTime endPeriodTimestamp,
      final ScheduleInfo? scheduleInfo}) = _$_ScheduleDetail;

  @override
  String get id;
  @override
  String get scheduleId;
  @override
  String get startPeriod;
  @override
  String get endPeriod;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime get startPeriodTimestamp;
  @override
  DateTime get endPeriodTimestamp;
  @override
  ScheduleInfo? get scheduleInfo;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleDetailCopyWith<_$_ScheduleDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
