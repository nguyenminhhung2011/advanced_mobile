import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_info.freezed.dart';

@freezed
class WalletInfo with _$WalletInfo {
  const factory WalletInfo({
    required String amount,
    @Default(false) bool isBlocked,
    required int bonus,
  }) = _WalletInfo;
}
