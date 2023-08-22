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

  const factory SettingState.updateLangCodeSuccess(
      {required SettingModalState data}) = _UpdateLangCodeSuccess;

  const factory SettingState.getUserSuccess({
    required SettingModalState data,
  }) = _GetUserSuccess;

  const factory SettingState.logOutSuccess({
    required SettingModalState data,
  }) = _LogOutSuccess;

  const factory SettingState.getUserFailed({
    required SettingModalState data,
    required String message,
  }) = _GetUserFailed;

  const factory SettingState.updatePassCodeSuccess({
    required SettingModalState data,
  }) = _UpdatePassCodeSuccess;

  const factory SettingState.removePassCodeSuccess({
    required SettingModalState data,
  }) = _RemovePassCodeSuccess;

  bool get isLoading => maybeWhen(
      orElse: () => false, loading: (_, loadingType) => loadingType == 0);
}
