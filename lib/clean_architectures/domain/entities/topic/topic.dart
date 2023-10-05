import 'package:freezed_annotation/freezed_annotation.dart';
part 'topic.freezed.dart';

@freezed
class Topic with _$Topic {
  const factory Topic({
    int? id,
    String? key,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Topic;
}
