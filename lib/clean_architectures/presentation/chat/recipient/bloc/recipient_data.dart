import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';

part 'recipient_data.freezed.dart';

@freezed
class RecipientData with _$RecipientData {
  const factory RecipientData({
    required List<Chat> recipients,
  }) = _RecipientData;
}
