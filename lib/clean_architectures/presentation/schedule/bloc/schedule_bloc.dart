import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/boo/boo_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/schedule/bloc/schedule_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class ScheduleBloc extends DisposeCallbackBaseBloc {
  final Function0<void> getBooHistory;

  final Stream<bool?> loading$;

  final Stream<ScheduleState?> state$;

  final Stream<Pagination<BooInfo>> history$;

  ScheduleBloc._({
    required Function0<void> dispose,
    required this.getBooHistory,
    required this.loading$,
    required this.history$,
    required this.state$,
  }) : super(dispose);

  factory ScheduleBloc({required BooUseCase booUseCase}) {
    final getHistoryController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final historyController = BehaviorSubject.seeded(
      Pagination<BooInfo>(
          rows: List<BooInfo>.empty(), count: 0, perPage: 10, currentPage: 0),
    );

    // void refreshPagination() {
    //   historyController.add(
    //     Pagination<BooInfo>(
    //         rows: List<BooInfo>.empty(), count: 0, perPage: 10, currentPage: 0),
    //   );
    // }
    final getHistory$ = getHistoryController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final state$ = Rx.merge<ScheduleState>([
      getHistory$
          .where((isValid) => !isValid)
          .withLatestFrom(
              historyController.stream, (_, pagination) => pagination)
          .exhaustMap((pagination) {
        try {
          return booUseCase
              .getBooInfo(
                  page: pagination.currentPage + 1,
                  perPage: pagination.perPage,
                  dateTimeLte: DateTime.now())
              .doOn()
              .map((data) => data.fold(
                  ifLeft: (error) => GetBooHistoryFailed(
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
                    return const GetBooHistorySuccess();
                  }));
        } catch (e) {
          return Stream.error(
            GetBooHistoryFailed(message: e.toString()),
          );
        }
      })
    ]).whereNotNull().share();

    return ScheduleBloc._(
      dispose: () async => await DisposeBag(
        [getHistoryController, historyController, loadingController],
      ).dispose(),
      getBooHistory: () => getHistoryController.add(null),
      history$: historyController,
      loading$: loadingController,
      state$: state$,
    );
  }
}
