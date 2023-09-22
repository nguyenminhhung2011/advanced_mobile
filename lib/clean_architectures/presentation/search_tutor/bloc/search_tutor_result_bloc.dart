import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/search/search_tutor_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_result_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class SearchTutorResultBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function0<void> searchTutor;

  ///[streams]

  final Stream<bool?> loading$;

  final Stream<TutorFav> tutor$;

  final Stream<SearchTutorResultState> state$;

  SearchTutorResultBloc._({
    required Function0<void> dispose,
    required this.searchTutor,
    required this.loading$,
    required this.tutor$,
    required this.state$,
  }) : super(dispose);

  factory SearchTutorResultBloc(
      @factoryParam SearchTutorRequest searchTutorRequest,
      {required SearchTutorUseCase searchTutorUseCase}) {
    final loadingController = BehaviorSubject<bool>.seeded(false);

    final tutorController = BehaviorSubject<TutorFav>.seeded(TutorFav());

    final searchTutorController = PublishSubject<void>();

    final isValid$ = Rx.combineLatest2(
        tutorController.stream.map((e) => Validator.paginationValid(e.tutors)),
        loadingController.stream,
        (paginationValid, loading) =>
            paginationValid || !loading).shareValueSeeded(false);

    final searchTutor$ = searchTutorController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final searchTutorState$ = Rx.merge<SearchTutorResultState>([
      searchTutor$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(
              tutorController.stream, (_, TutorFav tutorFav) => tutorFav)
          .exhaustMap((value) {
        final pagination = value.tutors;
        try {
          return searchTutorUseCase
              .searchTutors(
                searchTutorRequest: SearchTutorRequest(
                  perPage: pagination.perPage,
                  page: pagination.currentPage + 1,
                  search: searchTutorRequest.search,
                  topics: searchTutorRequest.topics,
                  nationality: searchTutorRequest.nationality,
                ),
              )
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) => SearchTutorFailed(
                      error: error.code, message: error.message),
                  ifRight: (pData) {
                    if (pData != null) {
                      tutorController.add(
                        TutorFav(
                          tutors: Pagination<Tutor>(
                            count: pData.tutors.count,
                            perPage: pData.tutors.perPage,
                            currentPage: pData.tutors.currentPage,
                            rows: [...pagination.rows, ...pData.tutors.rows],
                          ),
                        ),
                      );
                      return const SearchTutorSuccess();
                    }
                    return const SearchTutorFailed();
                  }));
        } catch (e) {
          return Stream<SearchTutorResultState>.error(
            SearchTutorFailed(message: e.toString()),
          );
        }
      }),
      searchTutor$.where((isValid) => !isValid).map((_) => const STRInvalid())
    ]).whereNotNull().share();

    final state$ = Rx.merge<SearchTutorResultState>([searchTutorState$])
        .whereNotNull()
        .share();

    return SearchTutorResultBloc._(
      dispose: () async => DisposeBag(
              [loadingController, tutorController, searchTutorController])
          .dispose(),
      searchTutor: () => searchTutorController.add(null),
      loading$: loadingController,
      tutor$: tutorController,
      state$: state$,
    );
  }
}
