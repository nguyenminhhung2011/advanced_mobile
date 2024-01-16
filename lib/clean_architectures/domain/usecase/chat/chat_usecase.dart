import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/repositories/chat_repositories.dart';

@injectable
class ChatUseCase {
  final ChatRepositories _chatRepositories;
  ChatUseCase(this._chatRepositories);

  Future<SResult<List<Chat>>> getAllRecipient() =>
      _chatRepositories.getAllRecipient();
}
