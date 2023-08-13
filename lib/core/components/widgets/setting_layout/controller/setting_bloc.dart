import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/controller/setting_modal_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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

enum Appearance { dark, light }

extension AppearanceExtensions on Appearance {
  bool get isDark => this == Appearance.dark;
  bool get isLight => this == Appearance.light;
  Appearance get diffAppearance => isDark ? Appearance.light : Appearance.dark;
}

@injectable
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingModalState get data => state.data;

  // can change name to AppController
  SettingBloc() : super(const SettingState.initial(data: SettingModalState())) {
    on<_Started>(_onStarted);
    on<_UpdateAppearance>(_onUpdateAppearance);
    on<_UpdateCurrencies>(_onUpdateCurrencies);
  }

  FutureOr<void> _onStarted(
    _Started event,
    Emitter<SettingState> emit,
  ) {}

  FutureOr<void> _onUpdateAppearance(
    _UpdateAppearance event,
    Emitter<SettingState> emit,
  ) {
    emit(_UpdateAppearanceSuccess(
      data: data.copyWith(
        appearance: data.appearance.diffAppearance,
      ),
    ));
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
