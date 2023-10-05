import 'package:flutter_base_clean_architecture/clean_architectures/data/models/topic_response/topic_response.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor/tutor_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/wallet_info_model/wallet_info_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'requireNote')
  final String? requireNote;

  @JsonKey(name: 'studySchedule')
  final String? studySchedule;

  @JsonKey(name: 'creditCardNumber')
  final String? creditCardNumber;

  @JsonKey(name: 'birthday')
  final DateTime? birthday;

  @JsonKey(name: 'tutorInfo')
  final TutorModel? tutorInfo;

  @JsonKey(name: 'timezone')
  final int? timezone;

  @JsonKey(name: 'avgRating')
  final double? avgRating;

  @JsonKey(name: 'walletInfo')
  final WalletInfoModel? walletInfo;

  @JsonKey(name: 'roles')
  final List<String>? roles;

  @JsonKey(name: 'isActivated')
  final bool? isActivated;

  @JsonKey(name: 'learnTopics')
  final List<TopicResponse>? learnTopics;

  @JsonKey(name: 'testPreparations')
  final List<TopicResponse>? testPreparations;

  @JsonKey(name: 'isPhoneActivated')
  final bool? isPhoneActivated;

  @JsonKey(name: 'canSendMessage')
  final bool? canSendMessage;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.level,
    this.avatar,
    this.country,
    this.language,
    this.requireNote,
    this.studySchedule,
    this.creditCardNumber,
    this.birthday,
    this.tutorInfo,
    this.timezone,
    this.avgRating,
    this.walletInfo,
    this.roles,
    this.isActivated,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.canSendMessage,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
        id: id ?? '',
        name: name ?? '',
        email: email,
        phone: phone,
        level: level,
        avatar: avatar,
        country: country,
        language: language,
        requireNote: requireNote,
        studySchedule: studySchedule,
        creditCardNumber: creditCardNumber,
        birthday: birthday,
        tutorInfo: tutorInfo?.toEntity(),
        timezone: timezone,
        avgRating: avgRating,
        walletInfo: walletInfo?.toEntity(),
        roles: roles,
        isActivated: isActivated ?? true,
        learnTopics:
            learnTopics?.map((e) => e.toEntity()).toList() ?? List.empty(),
        testPreparations:
            testPreparations?.map((e) => e.toEntity()).toList() ?? List.empty(),
        isPhoneActivated: isPhoneActivated ?? false,
        canSendMessage: canSendMessage ?? false,
      );
}
