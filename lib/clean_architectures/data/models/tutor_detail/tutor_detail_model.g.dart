// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorDetailModel _$TutorDetailModelFromJson(Map<String, dynamic> json) =>
    TutorDetailModel(
      json['video'] as String?,
      json['bio'] as String?,
      json['education'] as String?,
      json['experience'] as String?,
      json['profession'] as String?,
      json['accent'] as String?,
      json['targetStudent'] as String?,
      json['interests'] as String?,
      json['languages'] as String?,
      json['specialties'] as String?,
      (json['rating'] as num?)?.toDouble(),
      (json['avgRating'] as num?)?.toDouble(),
      json['totalFeedback'] as int?,
      json['isNative'] as bool?,
      json['isFavorite'] as bool?,
      json['youtubeVideoId'] as String?,
      json['User'] == null
          ? null
          : TutorUserDetailModel.fromJson(json['User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TutorDetailModelToJson(TutorDetailModel instance) =>
    <String, dynamic>{
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'accent': instance.accent,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'rating': instance.rating,
      'avgRating': instance.avgRating,
      'totalFeedback': instance.totalFeedback,
      'isNative': instance.isNative,
      'isFavorite': instance.isFavorite,
      'youtubeVideoId': instance.youtubeVideoId,
      'User': instance.user,
    };
