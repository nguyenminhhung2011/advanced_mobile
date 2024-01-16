part of 'chat_detail_bloc.dart';

@freezed
class ChatDetailState with _$ChatDetailState {
  const ChatDetailState._();
  const factory ChatDetailState.initial({required ChatDetailData data}) =
      _Initial;

  const factory ChatDetailState.loading({required ChatDetailData data}) =
      _Loading;

  const factory ChatDetailState.getMessageSuccess(
      {required ChatDetailData data}) = _GetMessageSuccess;

  const factory ChatDetailState.getMessageFailed({
    required ChatDetailData data,
    required String message,
  }) = _GetMessageFailed;

  const factory ChatDetailState.getTutorSuccess(
      {required ChatDetailData data}) = _GetTutorSuccess;

  const factory ChatDetailState.getTutorFailed({
    required ChatDetailData data,
    required String message,
  }) = _GetTutorFailed;

  bool get loading => this is _Loading;
}
