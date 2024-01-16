import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';

abstract class ChatRepositories {
  Future<SResult<List<Chat>>> getAllRecipient();
}
