import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/home/home_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/components/utils/type_defs.dart';

class CredentialCourseSearch {
  final Pagination<Course> pagination;
  final String searchText;
  final String category;

  CredentialCourseSearch(this.pagination, this.searchText, this.category);
}

@injectable
class HomeBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function0<void> fetchData;

  final Function0<void> onRefreshData;

  final Function0<void> getCourseCategory;

  final Function1<String, void> submitWithText;

  final Function1<String, void> applyCategory;

  ///[Stream] response

  final Stream<bool?> loading$;

  final Stream<Pagination<Course>> courses$;

  final Stream<List<CourseCategory>> courseCategories$;

  final Stream<HomeState> state$;

  HomeBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.fetchData,
    required this.onRefreshData,
    required this.submitWithText,
    required this.courseCategories$,
    required this.getCourseCategory,
    required this.applyCategory,

    ///[States]
    required this.loading$,
    required this.state$,
    required this.courses$,
  }) : super(dispose);

  factory HomeBloc({required HomeUseCase homeUseCase}) {
    ///[controllers]

    final paginationController = BehaviorSubject<Pagination<Course>>.seeded(
      const Pagination<Course>(
          rows: <Course>[], count: 0, perPage: 10, currentPage: 0),
    );

    final searchTextController = BehaviorSubject<String>.seeded("");

    final categoryController = BehaviorSubject<String>.seeded("");

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final courseCategoriesController =
        BehaviorSubject.seeded(List<CourseCategory>.empty(growable: true));

    final fetchDataController = PublishSubject<void>();

    final getCourseCategoryController = PublishSubject<void>();

    void refreshPaginationData() {
      paginationController.add(const Pagination<Course>(
          rows: <Course>[], count: 0, perPage: 10, currentPage: 0));
    }

    ///
    ///[Streams]
    ///

    final isValid$ = Rx.combineLatest2(
            paginationController.stream.map(Validator.paginationValid),
            loadingController.stream,
            (paginationValid, loading) => !loading || paginationValid)
        .shareValueSeeded(false);

    final fetchData$ = fetchDataController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final getCourseCategories$ = getCourseCategoryController.stream.share();

    final state$ = Rx.merge<HomeState>([
      getCourseCategories$.exhaustMap((value) {
        try {
          return homeUseCase.getCourseCategory().map((data) => data.fold(
              ifLeft: (error) => GetCourseCategoryFailed(
                  message: error.message, error: error.code),
              ifRight: (pData) {
                courseCategoriesController.add(pData);
                return const GetCourseCategorySuccess();
              }));
        } catch (e) {
          return Stream.error(
            GetCourseCategoryFailed(message: e.toString()),
          );
        }
      }),
      fetchData$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(
              Rx.combineLatest3(
                  categoryController.stream,
                  paginationController.stream,
                  searchTextController.stream,
                  (category, pagination, searchText) => CredentialCourseSearch(
                      pagination, searchText, category)).share(),
              (_, cre) => cre)
          .exhaustMap((cre) {
        final pagination = cre.pagination;
        final searchText = cre.searchText;
        final category = cre.category;
        try {
          return homeUseCase
              .pagFetchData(
                page: pagination.currentPage + 1,
                size: pagination.perPage,
                q: searchText,
                categoryId: category,
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
                      paginationController.add(Pagination<Course>(
                        count: data.count,
                        perPage: data.perPage,
                        currentPage: data.currentPage,
                        rows: [...pagination.rows, ...data.rows],
                      ));
                      return const FetchDataCourseSuccess();
                    }
                    return const FetchDataCourseFailed(message: 'Data null');
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

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return HomeBloc._(
      dispose: () async => await DisposeBag([
        paginationController,
        fetchDataController,
        loadingController,
        searchTextController,
        getCourseCategoryController,
        courseCategoriesController,
        categoryController,
        ...subscriptions,
      ]).dispose(),
      fetchData: () => fetchDataController.add(null),
      getCourseCategory: () => getCourseCategoryController.add(null),
      courseCategories$: courseCategoriesController,
      applyCategory: (text) {
        final loading = loadingController.value;
        if (loading) {
          return;
        }
        final currentCategory = categoryController.value;
        if (text != currentCategory) {
          refreshPaginationData();
          categoryController.add(text);
        }
        fetchDataController.add(null);
      },
      submitWithText: (searchText) {
        final loading = loadingController.value;
        final currentSearchText = searchTextController.value;
        if (loading) {
          return;
        }
        if (searchText != currentSearchText) {
          refreshPaginationData();
          searchTextController.add(searchText);
        }
        fetchDataController.add(null);
      },
      onRefreshData: () {
        final loading = loadingController.value;
        if (loading) {
          return;
        }
        refreshPaginationData();
        fetchDataController.add(null);
      },
      loading$: loadingController,
      state$: state$,
      courses$: paginationController,
    );
  }
}
