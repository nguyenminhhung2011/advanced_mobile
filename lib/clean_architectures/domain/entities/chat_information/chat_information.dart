import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_information.freezed.dart';

@freezed
class ChatInformation with _$ChatInformation {
  const factory ChatInformation({
    required String id,
    required String name,
    String? avatar,
  }) = _ChatInformation;
}
