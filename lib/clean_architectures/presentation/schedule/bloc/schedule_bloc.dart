import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/boo/boo_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/schedule/bloc/schedule_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class ScheduleBloc extends DisposeCallbackBaseBloc {
  final Function0<void> getBooInfo;

  final Function0<void> refreshData;

  final Function1<int, void> changeTab;

  final Stream<bool?> loading$;

  final Stream<int> tab$;

  final Stream<ScheduleState?> state$;

  final Stream<Pagination<BooInfo>> history$;

  ScheduleBloc._({
    required Function0<void> dispose,
    required this.getBooInfo,
    required this.refreshData,
    required this.changeTab,
    required this.loading$,
    required this.history$,
    required this.state$,
    required this.tab$,
  }) : super(dispose);

  factory ScheduleBloc({required BooUseCase booUseCase}) {
    final getHistoryController = PublishSubject<void>();

    final tabController = BehaviorSubject<int>.seeded(0);

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final historyController = BehaviorSubject.seeded(
      Pagination<BooInfo>(
          rows: List<BooInfo>.empty(), count: 0, perPage: 10, currentPage: 0),
    );

    void refreshPagination() {
      historyController.add(
        Pagination<BooInfo>(
            rows: List<BooInfo>.empty(), count: 0, perPage: 10, currentPage: 0),
      );
    }

    final isValid$ = Rx.combineLatest2(
            loadingController.stream,
            historyController.stream
                .map((event) => Validator.paginationValid(event)),
            (loading, pagination) => !loading || pagination)
        .shareValueSeeded(false);

    final getHistory$ = getHistoryController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<ScheduleState>([
      getHistory$
          .where((isValid) => isValid)
          .withLatestFrom(
              historyController.stream, (_, pagination) => pagination)
          .exhaustMap((pagination) {
        final currentTab = tabController.value;
        try {
          return booUseCase
              .getBooInfo(
                  page: pagination.currentPage + 1,
                  perPage: pagination.perPage,
                  dateTimeLte: DateTime.now().subtract(const Duration(days: 10)),
                  isHistoryGet: currentTab == 1)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) => GetBooInfoFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    final currentData = historyController.value;
                    historyController.add(
                      Pagination(
                        rows: [...currentData.rows, ...cData.rows],
                        count: cData.count,
                        perPage: cData.perPage,
                        currentPage: cData.currentPage,
                      ),
                    );
                    return const GetBooInfoSuccess();
                  }));
        } catch (e) {
          return Stream.error(
            GetBooInfoFailed(message: e.toString()),
          );
        }
      }),
      getHistory$
          .where((isValid) => !isValid)
          .map((_) => const GetBooInfoFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    return ScheduleBloc._(
      dispose: () async => await DisposeBag(
        [
          getHistoryController,
          historyController,
          loadingController,
          tabController
        ],
      ).dispose(),
      getBooInfo: () => getHistoryController.add(null),
      changeTab: (tab) {
        tabController.add(tab);
        refreshPagination();
        getHistoryController.add(null);
      },
      refreshData: () {
        refreshPagination();
        getHistoryController.add(null);
      },
      tab$: tabController,
      history$: historyController,
      loading$: loadingController,
      state$: state$,
    );
  }
}
