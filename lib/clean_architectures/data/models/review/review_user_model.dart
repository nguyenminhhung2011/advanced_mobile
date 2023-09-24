import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/review/review_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewUserModel {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  ReviewUserModel(this.name, this.avatar);

  Map<String, dynamic> toJson() => _$ReviewUserModelToJson(this);

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewUserModelFromJson(json);

  ReviewUser toEntity() => ReviewUser(name: name ?? '', avatar: avatar);
}
