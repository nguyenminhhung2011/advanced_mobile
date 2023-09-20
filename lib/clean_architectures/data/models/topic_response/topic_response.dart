import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';

class TopicResponse {
  final String key;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  TopicResponse(this.key, this.name, this.createdAt, this.updatedAt);
  factory TopicResponse.fromJson(Map<String, dynamic> data) {
    return TopicResponse(
      data['key'] ?? '',
      data['name'] ?? '',
      data['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(data['createdAt'] as String),
      data['updatedAt'] == null
          ? DateTime.now()
          : DateTime.parse(data['updatedAt'] as String),
    );
  }

  Topic toEntity() => Topic(
        key: key,
        name: name,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
