import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat_information/chat_information.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String content,
    required DateTime createdAt,
    DateTime? updatedAt,
    required bool isRead,
    required ChatInformation fromInfo,
    required ChatInformation toInfo,
    ChatInformation? partner,
  }) = _Chat;
}
