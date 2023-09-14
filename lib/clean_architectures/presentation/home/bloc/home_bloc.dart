import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
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

  final Stream<HomeState> state$;

  HomeBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.fetchData,

    ///[States]
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory HomeBloc() {
    ///[controllers]

    final paginationController = PublishSubject<Pagination<Course>>();

    final fetchDataController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    ///
    ///[Streams]
    ///

    final fetchData$ = fetchDataController
        .debug(identifier: "FetchData", log: debugPrint)
        .switchMap((value) {
      paginationController.stream.map((Pagination<Course> pagination) => null);
      return paginationController;
    }).map((event) => null);
    // final state$ = Rx.merge<HomeState>([
    //   fetchDataController.withLatestFrom(
    //     Rx.,
    //     (t, Pagination pagination) => pagination,
    //   )
    // ]).whereNotNull().share();

    return HomeBloc();
  }
}
