import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lettutor/clean_architectures/domain/entities/chat/chat.dart';
import 'package:lettutor/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:lettutor/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';

part 'chat_detail_data.freezed.dart';

@freezed
class ChatDetailData with _$ChatDetailData {
  const factory ChatDetailData({
    required Pagination<Chat> chat,
    TutorDetail? tutor,
  }) = _ChatDetailData;
}
