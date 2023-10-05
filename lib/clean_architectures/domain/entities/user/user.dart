import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/wallet_info/wallet_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    String? email,
    String? phone,
    String? avatar,
    String? level,
    String? country,
    String? language,
    String? requireNote,
    String? studySchedule,
    String? creditCardNumber,
    DateTime? birthday,
    Tutor? tutorInfo,
    int? timezone,
    double? avgRating,
    WalletInfo? walletInfo,
    List<String>? roles,
    @Default(true) bool isActivated,
    @Default(<Topic>[]) List<Topic> learnTopics,
    @Default(<Topic>[]) List<Topic> testPreparations,
    @Default(true) bool isPhoneActivated,
    @Default(false) bool canSendMessage,
  }) = _User;
}
