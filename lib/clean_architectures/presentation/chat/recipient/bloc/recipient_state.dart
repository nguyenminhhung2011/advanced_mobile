part of 'recipient_bloc.dart';

@freezed
class RecipientState with _$RecipientState {
  const RecipientState._();

  const factory RecipientState.initial({required RecipientData data}) =
      _Initial;

  const factory RecipientState.loading({required RecipientData data}) =
      _Loading;

  const factory RecipientState.getAllRecipientSuccess(
      {required RecipientData data}) = _GetAllRecipientSuccess;

  const factory RecipientState.getAllRecipientFailed(
      {required RecipientData data,
      required String message}) = _GetAllRecipientFailed;

  bool get loading => this is _Loading;
}
