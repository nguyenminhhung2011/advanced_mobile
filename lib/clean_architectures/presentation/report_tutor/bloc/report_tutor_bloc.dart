import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@immutable
abstract class ReportTutorState {}

class ReportTutorSuccess implements ReportTutorState {
  const ReportTutorSuccess();
}

class ReportTutorFailed implements ReportTutorState {
  final String? message;
  final Object? error;

  const ReportTutorFailed({this.message, this.error});

  @override
  String toString() => "[Report tutor failed] message $message error $error";
}

@injectable
class ReportTutorBloc extends DisposeCallbackBaseBloc {
  ///[Functions] input function

  final Function1<String, void> reportTutor;

  ///[Streams]

  final Stream<bool?> loading$;

  final Stream<ReportTutorState> state$;

  ReportTutorBloc._({
    required Function0<void> dispose,
    required this.reportTutor,
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory ReportTutorBloc(@factoryParam String userId,
      {required TutorDetailUseCase tutorDetailUseCase}) {
    ///[Values controller]

    final loadingController = BehaviorSubject<bool?>.seeded(false);

    final contentController = BehaviorSubject<String>.seeded("");

    ///[Actions controller]

    final reportTutorController = PublishSubject<void>();

    ///[Handle actions]

    final isValid$ = Rx.combineLatest2(
        loadingController.stream,
        contentController.stream,
        (bool? loading, String content) =>
            !(loading ?? false) && content.isNotEmpty).shareValueSeeded(false);

    final reportTutor$ = reportTutorController.stream
        .withLatestFrom(isValid$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<ReportTutorState>([
      reportTutor$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(contentController.stream, (_, content) => content)
          .exhaustMap((content) {
        try {
          return tutorDetailUseCase
              .reportTutor(userId: userId, content: content)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => ReportTutorFailed(
                      message: error.message, error: error.code),
                  ifRight: (_) => const ReportTutorSuccess(),
                ),
              );
        } catch (e) {
          return Stream<ReportTutorState>.error(
            ReportTutorFailed(message: e.toString()),
          );
        }
      }),
      reportTutor$
          .where((isValid) => !isValid)
          .map((_) => const ReportTutorFailed(message: 'Invalid data'))
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
      'isValid': isValid$,
    }.debug();

    return ReportTutorBloc._(
      dispose: () async => await DisposeBag([
        loadingController,
        reportTutorController,
        contentController,
        ...subscriptions
      ]).dispose(),
      reportTutor: (content) {
        contentController.add(content);
        reportTutorController.add(null);
      },
      loading$: loadingController,
      state$: state$,
    );
  }
}
