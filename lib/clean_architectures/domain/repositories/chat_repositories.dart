import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/get_message_request/get_message_request.dart';

abstract class ChatRepositories {
  Future<SResult<List<Chat>>> getAllRecipient();
  Future<SResult<List<Chat>>> getAllMessage(GetMessageRequest request);
}
