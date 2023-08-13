part of 'setting_bloc.dart';

@freezed
class SettingEvent with _$SettingEvent {
  const factory SettingEvent.started() = _Started;
  const factory SettingEvent.updateAppearance() = _UpdateAppearance;

  const factory SettingEvent.updateCurrencies({
    required Currencies currencies,
  }) = _UpdateCurrencies;
}
