import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lettutor/clean_architectures/data/models/chat_information/chat_information_model.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'isRead')
  final bool isRead;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'fromInfo')
  final ChatInformationModel fromInfo;

  @JsonKey(name: 'toInfo')
  final ChatInformationModel toInfo;

  @JsonKey(name: 'partner')
  final ChatInformationModel? partner;

  ChatModel({
    required this.id,
    required this.content,
    required this.isRead,
    required this.createdAt,
    this.updatedAt,
    required this.fromInfo,
    required this.toInfo,
    this.partner,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  Chat get toEntity => Chat(
      id: id,
      content: content,
      createdAt: DateTime.parse(createdAt),
      updatedAt: (updatedAt?.isNotEmpty ?? false)
          ? DateTime.parse(updatedAt!)
          : DateTime.now(),
      isRead: isRead,
      fromInfo: fromInfo.toEntity,
      toInfo: toInfo.toEntity,
      partner: partner?.toEntity);
}
