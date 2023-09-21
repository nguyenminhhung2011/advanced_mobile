import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_tutor_request.freezed.dart';

@freezed
class SearchTutorRequest with _$SearchTutorRequest {
  const factory SearchTutorRequest({
    required int perPage,
    required int page,
    required String search,
    required List<String> topics,
    required Map<String, dynamic> nationality,
  }) = _SearchTutorRequest;
}
