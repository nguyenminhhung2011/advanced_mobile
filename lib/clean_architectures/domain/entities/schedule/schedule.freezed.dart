// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Schedule {
  String get id => throw _privateConstructorUsedError;
  String get tutorId => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  DateTime get startTimestamp => throw _privateConstructorUsedError;
  DateTime get endTimestamp => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isBooked => throw _privateConstructorUsedError;
  List<ScheduleDetail> get scheduleDetails =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res, Schedule>;
  @useResult
  $Res call(
      {String id,
      String tutorId,
      String startTime,
      String endTime,
      DateTime startTimestamp,
      DateTime endTimestamp,
      DateTime createdAt,
      bool isBooked,
      List<ScheduleDetail> scheduleDetails});
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res, $Val extends Schedule>
    implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? startTimestamp = null,
    Object? endTimestamp = null,
    Object? createdAt = null,
    Object? isBooked = null,
    Object? scheduleDetails = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      startTimestamp: null == startTimestamp
          ? _value.startTimestamp
          : startTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTimestamp: null == endTimestamp
          ? _value.endTimestamp
          : endTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isBooked: null == isBooked
          ? _value.isBooked
          : isBooked // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduleDetails: null == scheduleDetails
          ? _value.scheduleDetails
          : scheduleDetails // ignore: cast_nullable_to_non_nullable
              as List<ScheduleDetail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$$_ScheduleCopyWith(
          _$_Schedule value, $Res Function(_$_Schedule) then) =
      __$$_ScheduleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String tutorId,
      String startTime,
      String endTime,
      DateTime startTimestamp,
      DateTime endTimestamp,
      DateTime createdAt,
      bool isBooked,
      List<ScheduleDetail> scheduleDetails});
}

/// @nodoc
class __$$_ScheduleCopyWithImpl<$Res>
    extends _$ScheduleCopyWithImpl<$Res, _$_Schedule>
    implements _$$_ScheduleCopyWith<$Res> {
  __$$_ScheduleCopyWithImpl(
      _$_Schedule _value, $Res Function(_$_Schedule) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tutorId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? startTimestamp = null,
    Object? endTimestamp = null,
    Object? createdAt = null,
    Object? isBooked = null,
    Object? scheduleDetails = null,
  }) {
    return _then(_$_Schedule(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tutorId: null == tutorId
          ? _value.tutorId
          : tutorId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      startTimestamp: null == startTimestamp
          ? _value.startTimestamp
          : startTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTimestamp: null == endTimestamp
          ? _value.endTimestamp
          : endTimestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isBooked: null == isBooked
          ? _value.isBooked
          : isBooked // ignore: cast_nullable_to_non_nullable
              as bool,
      scheduleDetails: null == scheduleDetails
          ? _value._scheduleDetails
          : scheduleDetails // ignore: cast_nullable_to_non_nullable
              as List<ScheduleDetail>,
    ));
  }
}

/// @nodoc

class _$_Schedule implements _Schedule {
  const _$_Schedule(
      {required this.id,
      required this.tutorId,
      required this.startTime,
      required this.endTime,
      required this.startTimestamp,
      required this.endTimestamp,
      required this.createdAt,
      required this.isBooked,
      final List<ScheduleDetail> scheduleDetails = const <ScheduleDetail>[]})
      : _scheduleDetails = scheduleDetails;

  @override
  final String id;
  @override
  final String tutorId;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final DateTime startTimestamp;
  @override
  final DateTime endTimestamp;
  @override
  final DateTime createdAt;
  @override
  final bool isBooked;
  final List<ScheduleDetail> _scheduleDetails;
  @override
  @JsonKey()
  List<ScheduleDetail> get scheduleDetails {
    if (_scheduleDetails is EqualUnmodifiableListView) return _scheduleDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scheduleDetails);
  }

  @override
  String toString() {
    return 'Schedule(id: $id, tutorId: $tutorId, startTime: $startTime, endTime: $endTime, startTimestamp: $startTimestamp, endTimestamp: $endTimestamp, createdAt: $createdAt, isBooked: $isBooked, scheduleDetails: $scheduleDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Schedule &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tutorId, tutorId) || other.tutorId == tutorId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.startTimestamp, startTimestamp) ||
                other.startTimestamp == startTimestamp) &&
            (identical(other.endTimestamp, endTimestamp) ||
                other.endTimestamp == endTimestamp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isBooked, isBooked) ||
                other.isBooked == isBooked) &&
            const DeepCollectionEquality()
                .equals(other._scheduleDetails, _scheduleDetails));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tutorId,
      startTime,
      endTime,
      startTimestamp,
      endTimestamp,
      createdAt,
      isBooked,
      const DeepCollectionEquality().hash(_scheduleDetails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScheduleCopyWith<_$_Schedule> get copyWith =>
      __$$_ScheduleCopyWithImpl<_$_Schedule>(this, _$identity);
}

abstract class _Schedule implements Schedule {
  const factory _Schedule(
      {required final String id,
      required final String tutorId,
      required final String startTime,
      required final String endTime,
      required final DateTime startTimestamp,
      required final DateTime endTimestamp,
      required final DateTime createdAt,
      required final bool isBooked,
      final List<ScheduleDetail> scheduleDetails}) = _$_Schedule;

  @override
  String get id;
  @override
  String get tutorId;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  DateTime get startTimestamp;
  @override
  DateTime get endTimestamp;
  @override
  DateTime get createdAt;
  @override
  bool get isBooked;
  @override
  List<ScheduleDetail> get scheduleDetails;
  @override
  @JsonKey(ignore: true)
  _$$_ScheduleCopyWith<_$_Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}
