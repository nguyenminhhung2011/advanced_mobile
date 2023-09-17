import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/views/tab_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashBoarEvent, DashboardState> {
  DashboardBloc()
      : super(
          const DashboardInitial([], 0, true),
        ) {
    on<ChangeTabEvent>(_onChangeTab);
    on<ChangeShowMenuEvent>(_onChangeShoeMenu);
  }

  FutureOr<void> _onChangeTab(
    ChangeTabEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(ChangeTab(state.tabItems, event.index, state.isShowMenu));
  }

  FutureOr<void> _onChangeShoeMenu(
    ChangeShowMenuEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(ChangeShowMenu(state.tabItems, state.index, !state.isShowMenu));
  }
}
