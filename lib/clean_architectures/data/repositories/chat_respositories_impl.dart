import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/chat/chat_api.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/data/models/response/chat_response/chat_response.dart';
import 'package:lettutor/clean_architectures/data/models/response/chat_response/recipient_response.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/get_message_request/get_message_request.dart';
import 'package:lettutor/clean_architectures/domain/repositories/chat_repositories.dart';

@Injectable(as: ChatRepositories)
class ChatRepositoriesImpl extends BaseApi implements ChatRepositories {
  final ChatApi _chatApi;
  ChatRepositoriesImpl(this._chatApi);

  @override
  Future<SResult<List<Chat>>> getAllRecipient() async =>
      await apiCallSR<RecipientResponse, List<Chat>>(
        mapper: (result) => result!.messages.map((e) => e.toEntity).toList(),
        request: () async => await _chatApi.getAllRecipient(),
      );

  @override
  Future<SResult<List<Chat>>> getAllMessage(GetMessageRequest request) async {
    final queries = <String, dynamic>{
      if (request.startTime != null) "startTime": request.startTime,
      "page": request.page,
      "perPage": request.perPage
    };
    return await apiCallSR<ChatResponse, List<Chat>>(
      mapper: (result) => result!.messages.map((e) => e.toEntity).toList(),
      request: () async =>
          await _chatApi.getMessage(id: request.id, queries: queries),
    );
  }
}
