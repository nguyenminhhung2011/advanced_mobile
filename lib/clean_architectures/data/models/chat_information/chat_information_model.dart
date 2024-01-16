import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_information_model.g.dart';

@JsonSerializable()
class ChatInformationModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  ChatInformationModel({
    required this.id,
    required this.name,
    this.avatar,
  });

  factory ChatInformationModel.fromJson(Map<String, dynamic> json) =>
      _$ChatInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatInformationModelToJson(this);
}
