import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_to_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChildToModel {
  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'expires')
  final DateTime? expires;

  ChildToModel(this.token, this.expires);

  Map<String, dynamic> toJson() => _$ChildToModelToJson(this);

  factory ChildToModel.fromJson(Map<String, dynamic> json) =>
      _$ChildToModelFromJson(json);
}
