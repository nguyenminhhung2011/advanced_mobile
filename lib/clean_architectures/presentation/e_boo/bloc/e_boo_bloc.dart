import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/bloc/e_boo_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
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

  final Function0<void> refreshItem;

  final Function0<void> getCourseCategory;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<Pagination<EBoo>> eBoo$;

  final Stream<List<CourseCategory>> courseCategories$;

  final Stream<EBooState> state$;

  EBooBloc._({
    required Function0<void> dispose,
    required this.courseCategories$,
    required this.getCourseCategory,
    required this.refreshItem,
    required this.loading$,
    required this.getEBoo,
    required this.state$,
    required this.eBoo$,
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

    final courseCategoriesController =
        BehaviorSubject.seeded(List<CourseCategory>.empty(growable: true));

    final getCourseCategoryController = PublishSubject<void>();

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
                categoryId: categoryId,
                q: query,
              )
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
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
                  },
                ),
              );
        } catch (e) {
          return Stream.error(GetEBooFailed(message: e.toString()));
        }
      }),
      getEBoo$
          .where((isValid) => !isValid)
          .map((_) => const GetEBooFailed(message: "Invalid"))
    ]).whereNotNull().share();

    final getCourseCategories$ = getCourseCategoryController.stream.share();

    final state$ = Rx.merge<EBooState>([
      getCourseCategories$.exhaustMap((value) {
        try {
          ///[🐛🐛] Dumb code
          return eBooUseCase.getCourseCategory().map((data) => data.fold(
              ifLeft: (error) =>
                  GetEBooFailed(message: error.message, error: error.code),
              ifRight: (pData) {
                courseCategoriesController.add(pData);
                return const GetEBooSuccess();
              }));
        } catch (e) {
          return Stream.error(
            GetEBooFailed(message: e.toString()),
          );
        }
      }),
      getEBooState$
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
    }.debug();

    return EBooBloc._(
      dispose: () async => await DisposeBag([
        eBooController,
        getBooController,
        loadingController,
        searchTextController,
        categoryIdController,
        courseCategoriesController,
        getCourseCategoryController,
        ...subscriptions,
      ]).dispose(),
      courseCategories$: courseCategoriesController,
      getCourseCategory: () => getCourseCategoryController.add(null),
      refreshItem: () {
        refreshPaginationController();
        getBooController.add(null);
      },
      getEBoo: (query, category) {
        final currentSearchText = searchTextController.value;
        final currentCategoryId = categoryIdController.value;
        final checkSearchText = (query != null) && currentSearchText != query;
        final checkCategoryId =
            (category != null) && currentCategoryId != category;
        if (checkSearchText) {
          searchTextController.add(query);
        }
        if (checkCategoryId) {
          categoryIdController.add(category);
        }
        if (checkSearchText || checkCategoryId) {
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
