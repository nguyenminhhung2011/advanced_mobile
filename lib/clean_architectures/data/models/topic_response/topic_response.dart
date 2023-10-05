import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_response.g.dart';

@JsonSerializable()
class TopicResponse {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'key')
  final String? key;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  TopicResponse(this.id, this.key, this.name, this.createdAt, this.updatedAt);
  factory TopicResponse.fromJson(Map<String, dynamic> json) =>
      _$TopicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopicResponseToJson(this);

  Topic toEntity() => Topic(
        id: id,
        key: key,
        name: name,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
