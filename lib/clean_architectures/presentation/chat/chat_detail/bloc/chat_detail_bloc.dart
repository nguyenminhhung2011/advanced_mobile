import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/get_message_request/get_message_request.dart';
import 'package:lettutor/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:lettutor/clean_architectures/domain/usecase/chat/chat_usecase.dart';
import 'package:lettutor/clean_architectures/presentation/chat/chat_detail/bloc/chat_detail_data.dart';

part 'chat_detail_state.dart';

part 'chat_detail_bloc.freezed.dart';

@injectable
class ChatDetailCubit extends Cubit<ChatDetailState> {
  final ChatUseCase _chatUseCase;
  final String _id;
  ChatDetailCubit(@factoryParam String id, this._chatUseCase)
      : _id = id,
        super(
          _Initial(
            data: ChatDetailData(
              chat: Pagination<Chat>(
                perPage: 25,
                currentPage: 0,
                count: 0,
                rows: List.empty(growable: true),
              ),
            ),
          ),
        );

  ChatDetailData get data => state.data;

  Pagination<Chat> get chat => data.chat;

  Future<void> getMessage() async {
    emit(_Loading(data: data));
    (await _chatUseCase.getMessages(GetMessageRequest(
      id: _id,
      page: data.chat.currentPage + 1,
      perPage: data.chat.perPage,
      startTime: DateTime.now().millisecondsSinceEpoch,
    )))
        .fold(
            ifLeft: (error) =>
                emit(_GetMessageFailed(data: data, message: error.message)),
            ifRight: (rData) {
              if (rData.isEmpty) {
                emit(_GetTutorFailed(data: data, message: "Max message"));
              }
              emit(_GetMessageSuccess(
                  data: data.copyWith(
                chat: chat.copyWith(
                    rows: <Chat>[...chat.rows, ...rData],
                    currentPage: chat.currentPage + 1) as Pagination<Chat>,
              )));
            });
  }

  Future<void> getTutor() async {
    (await _chatUseCase.getTutorDetail(_id)).fold(
      ifLeft: (error) =>
          emit(_GetTutorFailed(data: data, message: error.message)),
      ifRight: (rData) =>
          emit(_GetMessageSuccess(data: data.copyWith(tutor: rData))),
    );
  }
}
