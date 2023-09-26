import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_user_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'tutor_detail.freezed.dart';

@freezed
class TutorDetail with _$TutorDetail {
  const factory TutorDetail({
    String? video,
    String? bio,
    String? education,
    String? experience,
    String? profession,
    String? accent,
    String? targetStudent,
    String? interests,
    String? languages,
    String? specialties,
    double? rating,
    double? avgRating,
    int? totalFeedback,
    bool? isNative,
    bool? isFavorite,
    String? youtubeVideoId,
    TutorUserDetail? user,
    
  }) = _TutorDetail;
}
