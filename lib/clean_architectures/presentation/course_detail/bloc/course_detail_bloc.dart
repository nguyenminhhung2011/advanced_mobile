import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class CourseDetailBloc extends DisposeCallbackBaseBloc {
  ///[Functions]

  final Function0<void> getCourseDetail;

  ///[Streams]

  final Stream<Course> course$;

  final Stream<bool?> loading$;

  final Stream<CourseDetailState> state$;

  CourseDetailBloc._({
    required Function0<void> dispose,
    required this.getCourseDetail,
    required this.loading$,
    required this.course$,
    required this.state$,
  }) : super(dispose);

  factory CourseDetailBloc(@factoryParam courseId,
      {required CourseDetailUseCase courseDetailUseCase}) {
    final loadingController = BehaviorSubject<bool>.seeded(false);

    final courseController =
        BehaviorSubject<Course>.seeded(const Course(id: ''));

    final getCourseDetailController = PublishSubject<void>();

    ///[Handle actions]

    final getCourseDetail$ = getCourseDetailController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final getCourseState$ = Rx.merge<CourseDetailState>([
      getCourseDetail$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return courseDetailUseCase
              .getCourseDetail(courseId: courseId)
              .doOn(
                  listen: () => loadingController.add(true),
                  cancel: () => loadingController.add(false))
              .map(
                (data) => data.fold(
                  ifLeft: (error) => GetCourseDetailFailed(
                      error: error.code, message: error.message),
                  ifRight: (cData) {
                    courseController.add(cData);
                    return const GetCourseDetailSuccess();
                  },
                ),
              );
        } catch (e) {
          return Stream<CourseDetailState>.error(
            GetCourseDetailFailed(message: e.toString()),
          );
        }
      }),
      getCourseDetail$.where((isValid) => !isValid).map(
            (_) => GetCourseDetailFailed(message: "Invalid value"),
          )
    ]).whereNotNull().share();

    final state$ =
        Rx.merge<CourseDetailState>([getCourseState$]).whereNotNull().share();

    final subscriptions =
        <String, Stream>{'state': state$, 'loading': loadingController}.debug();

    return CourseDetailBloc._(
      dispose: () async => await DisposeBag([
        loadingController,
        courseController,
        getCourseDetailController,
        ...subscriptions
      ]).dispose(),
      getCourseDetail: () => getCourseDetailController.add(null),
      loading$: loadingController,
      course$: courseController,
      state$: state$,
    );
  }
}
