import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/get_message_request/get_message_request.dart';
import 'package:lettutor/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:lettutor/clean_architectures/domain/repositories/chat_repositories.dart';
import 'package:lettutor/clean_architectures/domain/repositories/tutor_repositories.dart';

@injectable
class ChatUseCase {
  final ChatRepositories _chatRepositories;
  final TutorRepositories _tutorRepositories;
  ChatUseCase(this._chatRepositories, this._tutorRepositories);

  Future<SResult<List<Chat>>> getAllRecipient() async =>
      await _chatRepositories.getAllRecipient();

  Future<SResult<List<Chat>>> getMessages(GetMessageRequest request) async =>
      await _chatRepositories.getAllMessage(request);

  Future<SResult<TutorDetail>> getTutorDetail(String userId) async =>
      await _tutorRepositories.getTutorByIdNotStream(userId: userId);
}
