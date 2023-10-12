import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/main/main_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/bloc/main_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class MainBloc extends DisposeCallbackBaseBloc {
  ///[Input function]

  final Function0<void> getTopCourse;

  final Function0<void> getTopEBoos;

  final Function0<void> getTopTutors;

  ///[State]

  final Stream<MainState> state$;

  ///[loading stream]

  final Stream<bool?> loadingGetTutors;

  final Stream<bool?> loadingGetCourse;

  final Stream<bool?> loadingGetEBoos;

  ///[data stream]
  final Stream<List<Tutor>> tutors$;

  final Stream<List<Course>> courses$;

  final Stream<List<EBoo>> eBoos$;

  MainBloc._({
    required Function0<void> dispose,
    required this.getTopCourse,
    required this.getTopEBoos,
    required this.getTopTutors,
    //-----------------------------
    required this.state$,
    required this.loadingGetCourse,
    required this.loadingGetEBoos,
    required this.loadingGetTutors,
    //----------------------------
    required this.tutors$,
    required this.courses$,
    required this.eBoos$,
  }) : super(dispose);

  factory MainBloc({required MainUseCase mainUseCase}) {
    ///[Data controller]

    final loadingGetTutorController = BehaviorSubject<bool>.seeded(false);

    final loadingGetCourseController = BehaviorSubject<bool>.seeded(false);

    final loadingGetEBooController = BehaviorSubject<bool>.seeded(false);

    ///[Data controller]

    final tutorController =
        BehaviorSubject<List<Tutor>>.seeded(List.empty(growable: true));

    final courseController =
        BehaviorSubject<List<Course>>.seeded(List.empty(growable: true));

    final eBooController =
        BehaviorSubject<List<EBoo>>.seeded(List.empty(growable: true));

    ///[Function controller]

    final getTutorController = PublishSubject<void>();

    final getCourseController = PublishSubject<void>();

    final getEBooController = PublishSubject<void>();

    ///[Get tutor handle]

    final getTutor$ = getTutorController.stream
        .withLatestFrom(
            loadingGetTutorController.stream, (_, loading) => !loading)
        .share();

    final getTutorState$ = Rx.merge<MainState>([
      getTutor$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return mainUseCase
              .getTopTutors()
              .doOn(
                listen: () => loadingGetTutorController.add(true),
                cancel: () => loadingGetTutorController.add(false),
              )
              .map((data) => data.fold(
                    ifLeft: (error) =>
                        GetTopTutorFailed(message: error.message, error: error),
                    ifRight: (cData) {
                      tutorController.add(cData.tutors.rows as List<Tutor>);
                      return const GetTopTutorSuccess();
                    },
                  ));
        } catch (e) {
          return Stream.error(GetTopTutorFailed(message: e.toString()));
        }
      }),
      getTutor$
          .where((isValid) => !isValid)
          .map((_) => const GetTopTutorFailed(message: "Data is loading"))
    ]).whereNotNull().share();

    ///[Get course handler]

    final getCourse$ = getCourseController.stream
        .withLatestFrom(
            loadingGetCourseController.stream, (_, loading) => !loading)
        .share();

    final getCourseState$ = Rx.merge<MainState>([
      getCourse$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return mainUseCase
              .getTopCourse()
              .doOn(
                listen: () => loadingGetCourseController.add(true),
                cancel: () => loadingGetCourseController.add(false),
              )
              .map(
                (data) => data.fold(
                    ifLeft: (error) => GetTopCourseFailed(
                        message: error.message, error: error),
                    ifRight: (cData) {
                      courseController.add(cData?.rows as List<Course>);
                      return const GetTopCourseSuccess();
                    }),
              );
        } catch (e) {
          return Stream.error(GetTopCourseFailed(message: e.toString()));
        }
      }),
      getCourse$
          .where((isValid) => !isValid)
          .map((_) => const GetTopCourseFailed(message: "Data is loading"))
    ]).whereNotNull().share();

    ///[Get eBoo handle]

    final getEBoo$ = getEBooController.stream
        .withLatestFrom(
            loadingGetEBooController.stream, (_, loading) => !loading)
        .share();

    final getEBooState$ = Rx.merge<MainState>([
      getEBoo$.where((isValid) => isValid).debug(log: debugPrint).exhaustMap(
            (_) => mainUseCase
                .getEBooResponse()
                .doOn(
                  listen: () => loadingGetEBooController.add(true),
                  cancel: () => loadingGetEBooController.add(false),
                )
                .map(
                  (data) => data.fold(
                    ifLeft: (error) =>
                        GetTopEBooFailed(message: error.message, error: error),
                    ifRight: (cData) {
                      eBooController.add(cData.rows as List<EBoo>);
                      return const GetTopEBooSuccess();
                    },
                  ),
                ),
          ),
      getEBoo$
          .where((isValid) => !isValid)
          .map((_) => const GetTopEBooFailed(message: "Data is loading"))
    ]).whereNotNull().share();

    final state$ =
        Rx.merge<MainState>([getTutorState$, getCourseState$, getEBooState$])
            .whereNotNull()
            .share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingTutorController': loadingGetTutorController,
      'loadingCourseController': loadingGetCourseController,
      'loadingEBooController': loadingGetEBooController,
    }.debug();

    return MainBloc._(
      state$: state$,
      loadingGetTutors: loadingGetTutorController,
      loadingGetCourse: loadingGetCourseController,
      loadingGetEBoos: loadingGetEBooController,
      courses$: courseController,
      tutors$: tutorController,
      eBoos$: eBooController,
      getTopEBoos: () => getEBooController.add(null),
      getTopCourse: () => getCourseController.add(null),
      getTopTutors: () => getTutorController.add(null),
      dispose: () async => await DisposeBag([
        loadingGetTutorController,
        tutorController,
        getTutorController,
        //----------------------------
        loadingGetCourseController,
        courseController,
        getCourseController,
        //----------------------------
        loadingGetEBooController,
        eBooController,
        getEBooController,
        ...subscriptions,
      ]).dispose(),
    );
  }
}
