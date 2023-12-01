import 'package:lettutor/clean_architectures/data/models/token/child_to_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenModel {
  @JsonKey(name: 'access')
  final ChildToModel? access;

  @JsonKey(name: 'refresh')
  final ChildToModel? refresh;

  TokenModel(this.access, this.refresh);

  get accessToken => null;

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
