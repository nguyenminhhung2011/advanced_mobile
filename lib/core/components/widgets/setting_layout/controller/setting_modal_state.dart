import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/controller/setting_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_modal_state.freezed.dart';

@freezed
class SettingModalState with _$SettingModalState {
  const factory SettingModalState({
    @Default(Appearance.light) Appearance appearance,
    @Default(Currencies.usd) Currencies currencies,
  }) = _SettingModalState;
}
