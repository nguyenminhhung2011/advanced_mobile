import 'package:lettutor/clean_architectures/data/models/chat/chat_model.dart';

class ChatResponse {
  final int count;
  final List<ChatModel> messages;

  ChatResponse(this.count, this.messages);

  factory ChatResponse.fromJson(Map<String, dynamic> data) {
    return ChatResponse(
      data["count"] ?? 0,
      data["rows"] != null
          ? (data["rows"] as List<dynamic>)
              .map((e) => ChatModel.fromJson(e))
              .toList()
          : <ChatModel>[],
    );
  }
}
