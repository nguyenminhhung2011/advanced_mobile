import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_message_request.freezed.dart';

@freezed
class GetMessageRequest with _$GetMessageRequest {
  const factory GetMessageRequest({
    required String id, 
    required int page,
    required int perPage,
    int? startTime,
  }) = _GetMessageRequest;
}
  