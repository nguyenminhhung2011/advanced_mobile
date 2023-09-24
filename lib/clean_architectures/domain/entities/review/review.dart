import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/review/review_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required double rating,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    required ReviewUser reviewUser,
  }) = _Review;
}
