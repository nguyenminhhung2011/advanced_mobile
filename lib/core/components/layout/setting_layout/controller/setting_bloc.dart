import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_modal_state.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/setting/setting_usecase.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.freezed.dart';

enum Currencies { usd, vnd }

extension CurrenciesExtensions on Currencies {
  String toCodeString() => switch (this) {
        Currencies.usd => 'USD',
        _ => 'VND',
      };
}

enum Appearance {
  dark,
  light;

  static Appearance fromText(String text) =>
      text == 'l' ? Appearance.light : Appearance.dark;
}

extension AppearanceExtensions on Appearance {
  bool get isDark => this == Appearance.dark;
  bool get isLight => this == Appearance.light;
  Appearance get diffAppearance => isDark ? Appearance.light : Appearance.dark;
}

@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingUseCase _settingUseCase;
  SettingModalState get data => state.data;
  // can change name to AppController
  SettingBloc(
    this._settingUseCase,
  ) : super(const SettingState.initial(data: SettingModalState())) {
    on<_Started>(_onStarted);
    on<_UpdateAppearance>(_onUpdateAppearance);
    on<_UpdateCurrencies>(_onUpdateCurrencies);
    on<_GetUserInfo>(_onGetUserInfo);
    on<_UpdateLangCode>(_onUpdateLangCode);
    on<_UpdatePassCode>(_onUpdatePassCode);
    on<_LogOut>(_onLogOut);
    on<_RemovePassCode>(_onRemovePassCode);
  }

  FutureOr<void> _onStarted(
    _Started event,
    Emitter<SettingState> emit,
  ) {
    String appearance = _settingUseCase.appearance ?? 'l';
    String langCode = _settingUseCase.languageCode ?? 'vi';
    String passCode = _settingUseCase.passCode ?? '';
    emit(_Initial(
      data: data.copyWith(
        appearance: Appearance.fromText(appearance.toLowerCase()),
        langCode: langCode.toLowerCase(),
        currentLocale: S.delegate.supportedLocales
            .firstWhere((e) => e.languageCode == langCode),
        passCode: passCode.toLowerCase(),
      ),
    ));
  }

  FutureOr<void> _onUpdateAppearance(
    _UpdateAppearance event,
    Emitter<SettingState> emit,
  ) async {
    bool? setAppearance;
    if (data.appearance.diffAppearance.isDark) {
      setAppearance = await _settingUseCase.setAppearance(appearance: 'd');
    } else {
      setAppearance = await _settingUseCase.setAppearance(appearance: 'l');
    }
    if (setAppearance ?? false) {
      emit(_UpdateAppearanceSuccess(
        data: data.copyWith(
          appearance: data.appearance.diffAppearance,
        ),
      ));
    }
  }

  FutureOr<void> _onUpdatePassCode(
    _UpdatePassCode event,
    Emitter<SettingState> emit,
  ) async {
    final passCodeSet =
        await _settingUseCase.setPassCode(newPassCode: event.newPassCode);
    if (passCodeSet ?? false) {
      emit(_UpdatePassCodeSuccess(
        data: data.copyWith(
          passCode: event.newPassCode,
        ),
      ));
    }
  }

  FutureOr<void> _onRemovePassCode(
    _RemovePassCode event,
    Emitter<SettingState> emit,
  ) {
    if (data.passCode.isNotEmpty) {
      _settingUseCase.removePassCode();
      emit(_RemovePassCodeSuccess(data: data.copyWith(passCode: '')));
    }
  }

  FutureOr<void> _onUpdateLangCode(
    _UpdateLangCode event,
    Emitter<SettingState> emit,
  ) async {
    final langSet =
        await _settingUseCase.setLanguageCode(langName: event.langCode);
    if (langSet ?? false) {
      emit(_UpdateLangCodeSuccess(
        data: data.copyWith(
          langCode: event.langCode,
          currentLocale: S.delegate.supportedLocales.firstWhere(
            (e) => e.languageCode == event.langCode,
          ),
        ),
      ));
    }
  }

  FutureOr<void> _onLogOut(
    _LogOut event,
    Emitter<SettingState> emit,
  ) {
    _settingUseCase.removeAccessToken();
    emit(_LogOutSuccess(data: data));
  }

  FutureOr<void> _onGetUserInfo(
    _GetUserInfo event,
    Emitter<SettingState> emit,
  ) async {
    emit(_Loading(data: data));
    try {
      final token = _settingUseCase.accessToken;
      final userData = await _settingUseCase.getUserInfo(token);
      if (userData == null) {
        return emit(_GetUserFailed(data: data, message: 'Failed'));
      }
      return emit(_GetUserSuccess(data: data.copyWith(currentUser: userData)));
    } on AppException catch (e) {
      emit(_GetUserFailed(data: data, message: e.toString()));
    } catch (e) {
      emit(_GetUserFailed(data: data, message: e.toString()));
    }
  }

  FutureOr<void> _onUpdateCurrencies(
    _UpdateCurrencies event,
    Emitter<SettingState> emit,
  ) {
    emit(_UpdateCurrenciesSuccess(
      data: data.copyWith(currencies: event.currencies),
    ));
  }
}
