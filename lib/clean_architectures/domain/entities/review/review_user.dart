import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_user.freezed.dart';

@freezed
class ReviewUser with _$ReviewUser {
  const factory ReviewUser({
    required String name,
    String? avatar,
  }) = _ReviewUser;
}
