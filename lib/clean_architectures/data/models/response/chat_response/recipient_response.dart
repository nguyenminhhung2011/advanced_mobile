import 'package:lettutor/clean_architectures/data/models/chat/chat_model.dart';

class RecipientResponse {
  final int unreadCount;
  final List<ChatModel> messages;

  RecipientResponse(this.unreadCount, this.messages);

  factory RecipientResponse.fromJson(Map<String, dynamic> data) {
    return RecipientResponse(
      data["unreadCount"] ?? 0,
      data["messages"] != null
          ? (data["messages"] as List<dynamic>)
              .map((e) => ChatModel.fromJson(e))
              .toList()
          : <ChatModel>[],
    );
  }
}
