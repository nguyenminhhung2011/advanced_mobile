import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_fav/tutor_fav.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/log_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
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

  final Function1<String, void> addTutorToFav;

  final Function0<void> onRefreshData;

  final Function0<void> getUpComingClass;

  final Function0<void> changeFavoriteMode;

  final Function0<void> getTotalTime;

  final Function0<void> openBeforeMeeting;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<bool?> loadingHeader$;

  final Stream<bool?> favoriteMode$;

  final Stream<int> learningTotalTime$;

  final Stream<TutorFav> tutor$;

  final Stream<TutorShowState> state$;

  final Stream<BooInfo?> upComingClass$;

  TutorShowBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.fetchData,
    required this.getTotalTime,
    required this.addTutorToFav,
    required this.onRefreshData,
    required this.getUpComingClass,
    required this.changeFavoriteMode,
    required this.openBeforeMeeting,

    ///[States]

    required this.learningTotalTime$,
    required this.upComingClass$,
    required this.loadingHeader$,
    required this.favoriteMode$,
    required this.loading$,
    required this.state$,
    required this.tutor$,
  }) : super(dispose);

  factory TutorShowBloc({required TutorShowUseCase tutorShowUseCase}) {
    final paginationController = BehaviorSubject<TutorFav>.seeded(TutorFav());

    final tutorUserIdToAdd = PublishSubject<String>();

    final fetchDataController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final loadingHeaderController = BehaviorSubject<bool>.seeded(false);

    final favoriteModeController = BehaviorSubject<bool>.seeded(false);

    final learningTotalTimeController = BehaviorSubject<int>.seeded(0);

    final upComingClassController = BehaviorSubject<BooInfo?>.seeded(null);

    // final tutorIdAddFavController = BehaviorSubject<String>.seeded('');

    final getUpComingClassController = PublishSubject<void>();

    final addTutorToFavController = PublishSubject<void>();

    final getTotalTimeController = PublishSubject<void>();

    final openBeforeMeetingController = PublishSubject<void>();

    final changeFavoriteModeController = PublishSubject<void>();

    final isValid$ = Rx.combineLatest2(
            paginationController.stream
                .map((e) => Validator.paginationValid(e.tutors)),
            loadingController.stream,
            (paginationValid, loading) => paginationValid || !loading)
        .shareValueSeeded(false);

    final fetchData$ = fetchDataController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final addTutorFav$ = addTutorToFavController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final addTutorFavState$ = Rx.merge([
      addTutorFav$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(tutorUserIdToAdd.stream, (_, String s) => s)
          .exhaustMap((userId) {
        try {
          return tutorShowUseCase
              .addTutorToFavorite(userId: userId)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) =>
                      AddTutorToFavFailed(message: error.message),
                  ifRight: (add) {
                    if (add) {
                      final currentData = paginationController.value;
                      paginationController.add(TutorFav(
                        tutors: currentData.tutors,
                        fav: currentData.fav.contains(userId)
                            ? currentData.fav
                                .where((element) => element != userId)
                                .toList()
                            : [...currentData.fav, userId].toList(),
                      ));
                      return const AddTutorToFavSuccess();
                    }
                    return const AddTutorToFavFailed(message: 'Failed');
                  },
                ),
              );
        } catch (e) {
          return Stream<TutorShowState>.error(
            const AddTutorToFavFailed(message: 'Add tutor Failed'),
          );
        }
      }),
      addTutorFav$
          .where((isValid) => !isValid)
          .map((_) => const FetchDataTutorFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    final getTotalTimeState$ =
        getTotalTimeController.stream.exhaustMap<TutorShowState>((value) {
      try {
        return tutorShowUseCase
            .getTotalTime()
            .doOn(
              listen: () => loadingHeaderController.add(true),
              cancel: () => loadingHeaderController.add(false),
            )
            .map(
              (data) => data.fold(
                  ifLeft: (error) => GetTotalTimeFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    learningTotalTimeController.add(cData);
                    return const GetTotalTimeSuccess();
                  }),
            );
      } catch (e) {
        return Stream.error(GetTotalTimeFailed(message: e.toString()));
      }
    });

    final getUpComingState$ =
        getUpComingClassController.stream.exhaustMap<TutorShowState>((value) {
      try {
        {
          return tutorShowUseCase
              .getUpComingClass(dateTime: Constant.currentTime)
              .doOn(
                listen: () => loadingHeaderController.add(true),
                cancel: () => loadingHeaderController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => GetUpComingClassFailed(
                      message: error.message, error: error.code),
                  ifRight: (cData) {
                    if (cData != null) {
                      upComingClassController.add(cData);
                    }
                    return const GetUpComingClassSuccess();
                  },
                ),
              );
        }
      } catch (e) {
        return Stream.error(GetUpComingClassFailed(message: e.toString()));
      }
    });

    final fetchDataState$ = Rx.merge([
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
          .map((_) => const FetchDataTutorFailed(message: "Invalid format")),
    ]).whereNotNull().share();

    ///[Open before meeting view]
    final openBeforeMeetingView$ = openBeforeMeetingController.stream
        .withLatestFrom(upComingClassController.stream, (_, value) => value)
        .share();

    final openBeforeMeetingViewState$ = Rx.merge<TutorShowState>([
      openBeforeMeetingView$
          .where((event) => event.isNotNull)
          .map((event) => OpenBeforeMeetingViewSuccess(event!)),
      openBeforeMeetingView$
          .where((event) => event.isNull)
          .map((_) => const OpenBeforeMeetingViewFailed())
    ]).whereNotNull().share();

    final state$ = Rx.merge<TutorShowState>(
      [
        changeFavoriteModeController.stream.map((event) {
          final currentMode = favoriteModeController.value;
          favoriteModeController.add(!currentMode);
          return const ChangeFavoriteModeSuccess();
        }).share(),
        fetchDataState$,
        addTutorFavState$,
        getUpComingState$,
        getTotalTimeState$,
        openBeforeMeetingViewState$,
      ],
    ).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return TutorShowBloc._(
      dispose: () async => await DisposeBag([
        paginationController,
        fetchDataController,
        loadingController,
        addTutorToFavController,
        tutorUserIdToAdd,
        favoriteModeController,
        learningTotalTimeController,
        loadingHeaderController,
        changeFavoriteModeController,
        getUpComingClassController,
        getTotalTimeController,
        upComingClassController,
        openBeforeMeetingController,
        ...subscriptions,
      ]).dispose(),
      upComingClass$: upComingClassController,
      openBeforeMeeting: () => openBeforeMeetingController.add(null),
      getUpComingClass: () => getUpComingClassController.add(null),
      getTotalTime: () => getTotalTimeController.add(null),
      loadingHeader$: loadingHeaderController,
      learningTotalTime$: learningTotalTimeController,
      onRefreshData: () {
        final loading = loadingController.value;
        if (loading) {
          return;
        }
        paginationController.add(TutorFav());
        fetchDataController.add(null);
      },
      favoriteMode$: favoriteModeController,
      changeFavoriteMode: () => changeFavoriteModeController.add(null),
      addTutorToFav: (value) {
        tutorUserIdToAdd.add(value.trim());
        addTutorToFavController.add(null);
      },
      fetchData: () => fetchDataController.add(null),
      loading$: loadingController,
      state$: state$,
      tutor$: paginationController,
    );
  }
}
