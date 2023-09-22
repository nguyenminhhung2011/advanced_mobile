import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor_detail/tutor_user_detail_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutor_detail_model.g.dart';

@JsonSerializable()
class TutorDetailModel {
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

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'avgRating')
  final double? avgRating;

  @JsonKey(name: 'totalFeedback')
  final int? totalFeedback;

  @JsonKey(name: 'isNative')
  final bool? isNative;

  @JsonKey(name: 'isFavorite')
  final bool? isFavorite;

  @JsonKey(name: 'youtubeVideoId')
  final String? youtubeVideoId;

  @JsonKey(name: 'User')
  final TutorUserDetailModel? user;

  TutorDetailModel(
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
      this.rating,
      this.avgRating,
      this.totalFeedback,
      this.isNative,
      this.isFavorite,
      this.youtubeVideoId,
      this.user);

  factory TutorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TutorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TutorDetailModelToJson(this);

  TutorDetail toEntity() => TutorDetail(
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
        rating: rating,
        avgRating: avgRating,
        totalFeedback: totalFeedback,
        isNative: isNative,
        isFavorite: isFavorite,
        youtubeVideoId: youtubeVideoId,
        user: user?.toEntity(),
      );
}
