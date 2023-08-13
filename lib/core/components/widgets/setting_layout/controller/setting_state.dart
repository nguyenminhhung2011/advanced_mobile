part of 'setting_bloc.dart';

@freezed
class SettingState with _$SettingState {
  const SettingState._();
  const factory SettingState.initial({required SettingModalState data}) =
      _Initial;
  const factory SettingState.loading({
    required SettingModalState data,
    @Default(0) int loadingType,
  }) = _Loading;

  const factory SettingState.updateAppearanceSuccess(
      {required SettingModalState data}) = _UpdateAppearanceSuccess;

  const factory SettingState.updateCurrenciesSuccess(
      {required SettingModalState data}) = _UpdateCurrenciesSuccess;
}
