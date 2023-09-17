import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class TutorShowBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function0<void> fetchData;

  final Function0<void> fetchFavoritesData;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<Pagination<Tutor>> tutor$;

  final Stream<TutorShowState> state$;

  TutorShowBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.fetchData,
    required this.fetchFavoritesData,

    ///[States]
    required this.loading$,
    required this.state$,
    required this.tutor$,
  }) : super(dispose);

  factory TutorShowBloc({required TutorShowUseCase tutorShowUseCase}) {
    final paginationController = BehaviorSubject<Pagination<Tutor>>.seeded(
      const Pagination<Tutor>(
          rows: <Tutor>[], count: 0, perPage: 10, currentPage: 0),
    );
    final fetchDataController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final isValid$ = Rx.combineLatest2(
            paginationController.stream.map(Validator.paginationValid),
            loadingController.stream,
            (paginationValid, loading) => paginationValid || !loading)
        .shareValueSeeded(false);

    final fetchData$ = fetchDataController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<TutorShowState>(
      [
        fetchData$
            .where((isValid) => isValid)
            .debug(log: debugPrint)
            .withLatestFrom(paginationController.stream,
                (_, Pagination<Tutor> pagination) => pagination)
            .exhaustMap((value) {
          try {
            return tutorShowUseCase
                .pagFetchData(page: value.currentPage + 1, size: value.perPage)
                .doOn(
                  listen: () => loadingController.add(true),
                  cancel: () => loadingController.add(false),
                )
                .map(
                  (data) => data.fold(
                    ifLeft: (error) => FetchDataTutorFailed(
                      error: error.code,
                      message: error.message,
                    ),
                    ifRight: (pData) {
                      if (pData != null) {
                        paginationController.add(Pagination<Tutor>(
                          count: pData.count,
                          perPage: pData.perPage,
                          currentPage: pData.currentPage,
                          rows: [...value.rows, ...pData.rows],
                        ));
                        return const FetchDataTutorSuccess();
                      }
                      return const FetchDataTutorFailed();
                    },
                  ),
                );
          } catch (e) {
            ///do something
            return Stream<TutorShowState>.error(
              FetchDataTutorFailed(message: e.toString()),
            );
          }
        }).debug(identifier: 'Fetch tutors data', log: debugPrint),
        fetchData$
            .where((isValid) => !isValid)
            .map((_) => const FetchDataTutorFailed(message: "Invalid format"))
      ],
    ).whereNotNull().share();

    return TutorShowBloc._(
      dispose: () async => await DisposeBag(
              [paginationController, fetchDataController, loadingController])
          .dispose(),
      fetchFavoritesData: () {},
      fetchData: () => fetchDataController.add(null),
      loading$: loadingController,
      state$: state$,
      tutor$: paginationController,
    );
  }
}
