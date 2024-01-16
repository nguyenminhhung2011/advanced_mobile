import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/domain/usecase/chat/chat_usecase.dart';
import 'package:lettutor/clean_architectures/presentation/chat/recipient/bloc/recipient_data.dart';

part 'recipient_state.dart';

part 'recipient_bloc.freezed.dart';

@injectable
class RecipientCubit extends Cubit<RecipientState> {
  final ChatUseCase _chatUseCase;

  RecipientCubit(this._chatUseCase)
      : super(
          _Initial(data: RecipientData(recipients: List.empty(growable: true))),
        );

  RecipientData get data => state.data;

  Future<void> onGetRecipient() async {
    emit(_Loading(data: data));
    (await _chatUseCase.getAllRecipient()).fold(
      ifLeft: (error) =>
          emit(_GetAllRecipientFailed(data: data, message: error.message)),
      ifRight: (rData) => emit(
        _GetAllRecipientSuccess(
          data: data.copyWith(recipients: [...data.recipients, ...rData]),
        ),
      ),
    );
  }
}
