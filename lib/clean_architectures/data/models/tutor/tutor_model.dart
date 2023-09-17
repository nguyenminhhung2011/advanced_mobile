import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutor_model.g.dart';

@JsonSerializable()
class TutorModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'google')
  final String? google;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'apple')
  final String? apple;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'birthday')
  final DateTime? birthday;

  @JsonKey(name: 'requestPassword')
  final bool? requestPassword;

  @JsonKey(name: 'isActivated')
  final bool? isActivated;

  @JsonKey(name: 'isPhoneActivated')
  final bool? isPhoneActivated;

  @JsonKey(name: 'requireNote')
  final String? requireNote;

  @JsonKey(name: 'timezone')
  final int? timezone;

  @JsonKey(name: 'phoneAuth')
  final String? phoneAuth;

  @JsonKey(name: 'isPhoneAuthActivated')
  final bool? isPhoneAuthActivated;

  //@JsonKey(name: 'studySchedule')
  //final String? studySchedule;

  @JsonKey(name: 'canSendMessage')
  final bool? canSendMessage;

  @JsonKey(name: 'isPublicRecord')
  final bool? isPublicRecord;

  @JsonKey(name: 'caredByStaffId')
  final String? caredByStaffId;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'deletedAt')
  final String? deletedAt;

  @JsonKey(name: 'studentGroupId')
  final String? studentGroupId;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'video')
  final String? video;

  @JsonKey(name: 'bio')
  final String? bio;

  @JsonKey(name: 'education')
  final String? education;

  @JsonKey(name: 'experience')
  final String? experience;

  @JsonKey(name: 'profession')
  final String? profession;

  @JsonKey(name: 'accent')
  final String? accent;

  @JsonKey(name: 'targetStudent')
  final String? targetStudent;

  @JsonKey(name: 'interests')
  final String? interests;

  @JsonKey(name: 'languages')
  final String? languages;

  @JsonKey(name: 'specialties')
  final String? specialties;

  @JsonKey(name: 'resume')
  final String? resume;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'isNative')
  final bool? isNative;

  @JsonKey(name: 'price')
  final double? price;

  @JsonKey(name: 'isOnline')
  final bool? isOnline;

  TutorModel(
      this.id,
      this.level,
      this.email,
      this.google,
      this.facebook,
      this.apple,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.isPhoneActivated,
      this.requireNote,
      this.timezone,
      this.phoneAuth,
      this.isPhoneAuthActivated,
      this.canSendMessage,
      this.isPublicRecord,
      this.caredByStaffId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentGroupId,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.resume,
      this.rating,
      this.isNative,
      this.price,
      this.isOnline);

  factory TutorModel.fromJson(Map<String, dynamic> json) =>
      _$TutorModelFromJson(json);

  Map<String, dynamic> toJson() => _$TutorModelToJson(this);

  Tutor toEntity() => Tutor(
        id: id,
        level: level,
        email: email,
        google: google,
        facebook: facebook,
        apple: apple,
        avatar: avatar,
        name: name,
        country: country,
        phone: phone,
        language: language,
        birthday: birthday,
        requestPassword: requestPassword,
        isActivated: isActivated,
        isPhoneActivated: isPhoneActivated,
        requireNote: requireNote,
        timezone: timezone,
        phoneAuth: phoneAuth,
        isPhoneAuthActivated: isPhoneAuthActivated,
        canSendMessage: canSendMessage,
        isPublicRecord: isPublicRecord,
        caredByStaffId: caredByStaffId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
        studentGroupId: studentGroupId,
        userId: userId,
        video: video,
        bio: bio,
        education: education,
        experience: experience,
        profession: profession,
        accent: accent,
        targetStudent: targetStudent,
        interests: interests,
        languages: languages,
        specialties: specialties,
        resume: resume,
        rating: rating,
        isNative: isNative,
        price: price,
        isOnline: isOnline,
      );
}
