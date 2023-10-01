import 'package:flutter_base_clean_architecture/clean_architectures/data/models/schedule/schedule_detail_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'boo_info_model.g.dart';

@JsonSerializable()
class BooInfoModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'scheduleId')
  final String? scheduleId;

  @JsonKey(name: 'cancelReasonId')
  final String? cancelReasonId;

  @JsonKey(name: 'lessonPlanId')
  final String? lessonPlanId;

  @JsonKey(name: 'calendarId')
  final String? calendarId;

  @JsonKey(name: 'cancelNote')
  final String? cancelNote;

  @JsonKey(name: 'isDeleted')
  final bool? isDeleted;

  @JsonKey(name: 'isTrial')
  final bool? isTrial;

  @JsonKey(name: 'convertedLesson')
  final int? convertedLesson;

  @JsonKey(name: 'tutorMeetingLink')
  final String? tutorMeetingLink;

  @JsonKey(name: 'studentMeetingLink')
  final String? studentMeetingLink;

  @JsonKey(name: 'googleMeetLink')
  final String? googleMeetLink;

  @JsonKey(name: 'studentRequest')
  final String? studentRequest;

  @JsonKey(name: 'tutorReview')
  final String? tutorReview;

  @JsonKey(name: 'scoreByTutor')
  final String? scoreByTutor;

  @JsonKey(name: 'recordUrl')
  final String? recordUrl;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'createdAtTimeStamp')
  final int? createdAtTimeStamp;

  @JsonKey(name: 'updatedAtTimeStamp')
  final int? updatedAtTimeStamp;

  @JsonKey(name: 'scheduleDetailInfo')
  final ScheduleDetailModel? scheduleDetailInfo;

  BooInfoModel(
    this.id,
    this.userId,
    this.scheduleId,
    this.cancelReasonId,
    this.lessonPlanId,
    this.calendarId,
    this.cancelNote,
    this.isDeleted,
    this.isTrial,
    this.convertedLesson,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.googleMeetLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.recordUrl,
    this.createdAt,
    this.updatedAt,
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.scheduleDetailInfo,
  );

  Map<String, dynamic> toJson() => _$BooInfoModelToJson(this);

  factory BooInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BooInfoModelFromJson(json);

  BooInfo toEntity() => BooInfo(
        id: id,
        userId: userId,
        scheduleId: scheduleId,
        cancelReasonId: cancelReasonId,
        lessonPlanId: lessonPlanId,
        calendarId: calendarId,
        cancelNote: cancelNote,
        isDeleted: isDeleted,
        isTrial: isTrial,
        convertedLesson: convertedLesson,
        tutorMeetingLink: tutorMeetingLink,
        studentMeetingLink: studentMeetingLink,
        googleMeetLink: googleMeetLink,
        studentRequest: studentRequest,
        tutorReview: tutorReview,
        scoreByTutor: scoreByTutor,
        recordUrl: recordUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
        createdAtTimeStamp: createdAtTimeStamp != null
            ? DateTime.fromMillisecondsSinceEpoch(createdAtTimeStamp!)
            : null,
        updatedAtTimeStamp: updatedAtTimeStamp != null
            ? DateTime.fromMillisecondsSinceEpoch(updatedAtTimeStamp!)
            : null,
        scheduleDetailInfo: scheduleDetailInfo?.toEntity(),
      );
}
