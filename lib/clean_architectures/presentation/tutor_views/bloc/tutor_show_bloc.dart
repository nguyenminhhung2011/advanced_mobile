import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
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

  final Stream<TutorFav> tutor$;

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
    final paginationController = BehaviorSubject<TutorFav>.seeded(TutorFav());
    final fetchDataController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final isValid$ = Rx.combineLatest2(
            paginationController.stream
                .map((e) => Validator.paginationValid(e.tutors)),
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
            .withLatestFrom(
                paginationController.stream, (_, TutorFav tutorFav) => tutorFav)
            .exhaustMap((value) {
          final pagination = value.tutors;
          try {
            return tutorShowUseCase
                .pagFetchData(
                    page: pagination.currentPage + 1, size: pagination.perPage)
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
                        paginationController.add(TutorFav(
                          tutors: Pagination<Tutor>(
                            count: pData.tutors.count,
                            perPage: pData.tutors.perPage,
                            currentPage: pData.tutors.currentPage,
                            rows: [...pagination.rows, ...pData.tutors.rows],
                          ),
                          fav: pData.fav,
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
