part of 'setting_bloc.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent.started() = _Started;
  const factory SettingEvent.updateAppearance() = _UpdateAppearance;
  const factory SettingEvent.updateLangCode({
    required String langCode,
  }) = _UpdateLangCode;

  const factory SettingEvent.logOut() = _LogOut;

  const factory SettingEvent.getUserInfo() = _GetUserInfo;

  const factory SettingEvent.updateCurrencies({
    required Currencies currencies,
  }) = _UpdateCurrencies;
}
