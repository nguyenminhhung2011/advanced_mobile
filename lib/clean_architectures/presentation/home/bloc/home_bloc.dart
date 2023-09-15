import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/home/home_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/components/utils/type_defs.dart';

@injectable
class HomeBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function0<void> fetchData;

  ///[Stream] response

  final Stream<bool?> loading$;

  final Stream<Pagination<Course>> courses$;

  final Stream<HomeState> state$;

  HomeBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.fetchData,

    ///[States]
    required this.loading$,
    required this.state$,
    required this.courses$,
  }) : super(dispose);

  factory HomeBloc({required HomeUseCase homeUseCase}) {
    ///[controllers]

    final paginationController = PublishSubject<Pagination<Course>>();

    final fetchDataController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    ///
    ///[Streams]
    ///

    final isValid$ = Rx.combineLatest2(
            paginationController.stream.map((pag) => pag.count == 0
                ? true
                : pag.count < (pag.perPage * pag.currentPage)),
            loadingController.stream,
            (paginationValid, loading) => !loading && paginationValid)
        .shareValueSeeded(false);

    final fetchData$ = fetchDataController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<HomeState>([
      fetchData$
          .where((isValid) => isValid)
          .withLatestFrom(paginationController.stream,
              (_, Pagination<Course> pagination) => pagination)
          .exhaustMap((pagination) {
        try {
          return homeUseCase
              .pagFetchData(
                page: pagination.currentPage + 1,
                size: pagination.perPage,
              )
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => FetchDataCourseFailed(
                      error: error.code, message: error.message),
                  ifRight: (data) {
                    if (data != null) {
                      paginationController.add(data);
                    }
                    return const FetchDataCourseSuccess();
                  },
                ),
              );
        } catch (e) {
          return Stream<HomeState>.error(
            FetchDataCourseFailed(message: e.toString()),
          );
        }
      }).debug(identifier: 'Fetch courses data', log: debugPrint),
      fetchData$
          .where((isValid) => !isValid)
          .map((_) => const FetchDataCourseFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    return HomeBloc._(
      dispose: () async => await DisposeBag(
              [paginationController, fetchDataController, loadingController])
          .dispose(),
      fetchData: () => fetchDataController.add(null),
      loading$: loadingController,
      state$: state$,
      courses$: paginationController,
    );
  }
}
