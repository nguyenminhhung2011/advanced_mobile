import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/boo/boo_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/schedule/bloc/schedule_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class UpdateStudentRequest {
  final String booId;
  final String content;
  UpdateStudentRequest({required this.booId, required this.content});
}

@injectable
class ScheduleBloc extends DisposeCallbackBaseBloc {
  final Function0<void> getBooInfo;

  final Function0<void> refreshData;

  final Function1<int, void> changeTab;

  final Function1<BooInfo, void> cancelBooTutor;

  final Function2<String, String, void> editRequest;

  final Stream<bool?> loading$;

  final Stream<int> tab$;

  final Stream<ScheduleState?> state$;

  final Stream<Pagination<BooInfo>> history$;

  ScheduleBloc._({
    required Function0<void> dispose,
    required this.cancelBooTutor,
    required this.refreshData,
    required this.editRequest,
    required this.getBooInfo,
    required this.changeTab,
    required this.history$,
    required this.loading$,
    required this.state$,
    required this.tab$,
  }) : super(dispose);

  factory ScheduleBloc({required BooUseCase booUseCase}) {
    final getHistoryController = PublishSubject<void>();

    final cancelBooTutorController = PublishSubject<BooInfo>();

    final updateStudentRequestController =
        PublishSubject<UpdateStudentRequest>();

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

    final cancelState$ =
        cancelBooTutorController.stream.exhaustMap<ScheduleState>((event) {
      if (event.id.isNotEmpty) {
        try {
          return booUseCase
              .cancelBooTutor(scheduleDetailIds: <String>[event.id])
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => CancelBooTutorFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    final currentData = historyController.value;
                    historyController.add(
                      currentData.copyWith(
                        count: currentData.count - 1,
                        rows: currentData.rows.where((element) {
                          final returnData = element as BooInfo;
                          return returnData.id != event.id;
                        }).toList(),
                      ) as Pagination<BooInfo>,
                    );
                    return const CancelBooTutorSuccess();
                  },
                ),
              );
        } catch (e) {
          return Stream.error(CancelBooTutorFailed(message: e.toString()));
        }
      }
      return Stream.error(const CancelBooTutorFailed(
        message: 'Must cancel boo before 2 hours',
      ));
    });

    final updateStudentRequest$ = updateStudentRequestController.stream
        .exhaustMap<ScheduleState>((value) {
      if (value.booId.isEmpty) {
        return Stream.error(
          const UpdateStudentRequestFailed(message: 'Boo id null'),
        );
      }
      try {
        return booUseCase
            .updateStudentRequest(booId: value.booId, content: value.content)
            .doOn(
              listen: () => loadingController.add(true),
              cancel: () => loadingController.add(false),
            )
            .map((data) => data.fold(
                  ifLeft: (error) => UpdateStudentRequestFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    final currentData = historyController.value;
                    historyController.add(
                      currentData.copyWith(
                          rows: currentData.rows.map((e) {
                        final returnData = e as BooInfo;
                        if (returnData.id == value.booId) {
                          return returnData.copyWith(
                            studentRequest: value.content,
                          );
                        }
                        return returnData;
                      }).toList()) as Pagination<BooInfo>,
                    );
                    return const UpdateStudentRequestSuccess();
                  },
                ));
      } catch (e) {
        return Stream.error(UpdateStudentRequestFailed(message: e.toString()));
      }
    });

    final state$ = Rx.merge<ScheduleState>([
      updateStudentRequest$,
      cancelState$,
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
                  dateTimeLte:
                      DateTime.now().subtract(const Duration(days: 15)),
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

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return ScheduleBloc._(
      dispose: () async => await DisposeBag(
        [
          getHistoryController,
          historyController,
          loadingController,
          tabController,
          updateStudentRequestController,
          cancelBooTutorController,
          ...subscriptions,
        ],
      ).dispose(),
      editRequest: (booId, content) => updateStudentRequestController.add(
        UpdateStudentRequest(booId: booId, content: content),
      ),
      cancelBooTutor: (scheduleIds) =>
          cancelBooTutorController.add(scheduleIds),
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
