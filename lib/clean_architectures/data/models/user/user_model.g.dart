// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['level'] as String?,
      json['avatar'] as String?,
      json['country'] as String?,
      json['language'] as String?,
      json['requireNote'] as String?,
      json['studySchedule'] as String?,
      json['creditCardNumber'] as String?,
      json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      json['tutorInfo'] == null
          ? null
          : TutorModel.fromJson(json['tutorInfo'] as Map<String, dynamic>),
      json['timezone'] as int?,
      (json['avgRating'] as num?)?.toDouble(),
      json['walletInfo'] == null
          ? null
          : WalletInfoModel.fromJson(
              json['walletInfo'] as Map<String, dynamic>),
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['isActivated'] as bool?,
      (json['learnTopics'] as List<dynamic>?)
          ?.map((e) => TopicResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['testPreparations'] as List<dynamic>?)
          ?.map((e) => TopicResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isPhoneActivated'] as bool?,
      json['canSendMessage'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'level': instance.level,
      'avatar': instance.avatar,
      'country': instance.country,
      'language': instance.language,
      'requireNote': instance.requireNote,
      'studySchedule': instance.studySchedule,
      'creditCardNumber': instance.creditCardNumber,
      'birthday': instance.birthday?.toIso8601String(),
      'tutorInfo': instance.tutorInfo,
      'timezone': instance.timezone,
      'avgRating': instance.avgRating,
      'walletInfo': instance.walletInfo,
      'roles': instance.roles,
      'isActivated': instance.isActivated,
      'learnTopics': instance.learnTopics,
      'testPreparations': instance.testPreparations,
      'isPhoneActivated': instance.isPhoneActivated,
      'canSendMessage': instance.canSendMessage,
    };
