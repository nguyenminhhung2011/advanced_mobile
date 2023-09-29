import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/bloc/e_boo_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class EBooRequest {
  final String query;
  final String categoryId;
  final Pagination<EBoo> eBoos;
  EBooRequest(this.query, this.categoryId, this.eBoos);
}

@injectable
class EBooBloc extends DisposeCallbackBaseBloc {
  ///[Functions]

  final Function2<String?, String?, void> getEBoo;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<Pagination<EBoo>> eBoo$;

  final Stream<EBooState> state$;

  EBooBloc._({
    required Function0<void> dispose,
    required this.getEBoo,
    required this.loading$,
    required this.eBoo$,
    required this.state$,
  }) : super(dispose);

  factory EBooBloc({required EBooUseCase eBooUseCase}) {
    final getBooController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final searchTextController = BehaviorSubject<String>.seeded("");

    final categoryIdController = BehaviorSubject<String>.seeded("");

    final eBooController = BehaviorSubject<Pagination<EBoo>>.seeded(
      const Pagination<EBoo>(
          rows: <EBoo>[], count: 0, currentPage: 0, perPage: 10),
    );

    void refreshPaginationController() {
      eBooController.add(
        const Pagination<EBoo>(
            rows: <EBoo>[], count: 0, currentPage: 0, perPage: 10),
      );
    }

    final getEBoo$ = getBooController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final getEBooState$ = Rx.merge<EBooState>([
      getEBoo$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(
              Rx.combineLatest3(
                searchTextController.stream,
                categoryIdController.stream,
                eBooController.stream,
                (search, categoryId, eBoo) =>
                    EBooRequest(search, categoryId, eBoo),
              ),
              (_, request) => request)
          .exhaustMap((request) {
        final query = request.query;
        final categoryId = request.categoryId;
        final pagination = request.eBoos;
        try {
          return eBooUseCase
              .getEBooResponse(
                page: pagination.currentPage + 1,
                size: pagination.perPage,
                q: query,
                categoryId: categoryId,
              )
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) =>
                      GetEBooFailed(message: error.message, error: error.code),
                  ifRight: (eData) {
                    eBooController.add(Pagination<EBoo>(
                      count: eData.count,
                      perPage: eData.perPage,
                      currentPage: eData.currentPage,
                      rows: [...pagination.rows, ...eData.rows],
                    ));
                    return const GetEBooSuccess();
                  }));
        } catch (e) {
          return Stream.error(GetEBooFailed(message: e.toString()));
        }
      }),
      getEBoo$
          .where((isValid) => !isValid)
          .map((_) => const GetEBooFailed(message: "Invalid"))
    ]).whereNotNull().share();

    final state$ = Rx.merge<EBooState>([getEBooState$]).whereNotNull().share();

    return EBooBloc._(
      dispose: () async => await DisposeBag([
        eBooController,
        getBooController,
        loadingController,
        searchTextController,
        categoryIdController,
      ]).dispose(),
      getEBoo: (query, category) {
        final currentSearchText = searchTextController.value;
        final checkSearchText = (query != null) && currentSearchText != query;
        if (checkSearchText) {
          searchTextController.add(query);
        }
        if (checkSearchText) {
          refreshPaginationController();
        }

        getBooController.add(null);
      },
      loading$: loadingController,
      eBoo$: eBooController,
      state$: state$,
    );
  }
}
