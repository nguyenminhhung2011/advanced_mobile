import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_preview/course_preview_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_user_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'tutor_user_detail_model.g.dart';

@JsonSerializable()
class TutorUserDetailModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'isPublicRecord')
  final bool? isPublicRecord;

  @JsonKey(name: 'caredByStaffId')
  final String? caredByStaffId;

  @JsonKey(name: 'studentGroupId')
  final String? studentGroupId;

  @JsonKey(name: 'zaloUserId')
  final String? zaloUserId;

  @JsonKey(name: 'courses')
  final List<CoursePreviewModel> courses;

  TutorUserDetailModel(
      this.id,
      this.level,
      this.avatar,
      this.name,
      this.country,
      this.language,
      this.isPublicRecord,
      this.caredByStaffId,
      this.studentGroupId,
      this.zaloUserId,
      this.courses);

  factory TutorUserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TutorUserDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TutorUserDetailModelToJson(this);

  TutorUserDetail toEntity() => TutorUserDetail(
      id: id,
      level: level,
      avatar: avatar,
      name: name,
      country: country,
      language: language,
      isPublicRecord: isPublicRecord,
      caredByStaffId: caredByStaffId,
      studentGroupId: studentGroupId,
      zaloUserId: zaloUserId,
      courses: courses.map((e) => e.toEntity()).toList());
}
