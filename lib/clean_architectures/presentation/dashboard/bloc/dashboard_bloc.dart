import 'dart:async';

import 'package:disposebag/disposebag.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/views/tab_items.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

@injectable
class DashboardBloc extends DisposeCallbackBaseBloc {
  final Function1<int, void> changeTabView;

  final Stream<int> tabIndex$;

  final Stream<DashboardState> state$;

  DashboardBloc._({
    required Function0<void> dispose,
    required this.changeTabView,
    required this.tabIndex$,
    required this.state$,
  }) : super(dispose);

  factory DashboardBloc() {
    final changeTabViewController = PublishSubject<int>();

    final tabIndexController = BehaviorSubject<int>.seeded(0);

    final changeTab$ = changeTabViewController.stream.share();

    final state$ = Rx.merge<DashboardState>([
      changeTab$.map((event) {
        if (event != tabIndexController.value) {
          tabIndexController.add(event);
        }
        return ChangeTab(const [], event, false);
      })
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{'state': state$}.debug();

    return DashboardBloc._(
      dispose: () async => await DisposeBag(
              [changeTabViewController, tabIndexController, ...subscriptions])
          .dispose(),
      changeTabView: (index) => changeTabViewController.add(index),
      tabIndex$: tabIndexController,
      state$: state$,
    );
  }
}
