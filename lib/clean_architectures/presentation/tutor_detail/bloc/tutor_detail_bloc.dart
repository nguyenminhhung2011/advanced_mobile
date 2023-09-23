import 'package:flutter/material.dart';
import 'package:disposebag/disposebag.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';

@injectable
class TutorDetailBloc extends DisposeCallbackBaseBloc {
  ///[Functions] input
  final Function0<void> getTutorBydId;

  ///[Streams]

  final Stream<TutorDetailState> state$;

  final Stream<bool?> loading$;

  final Stream<TutorDetail> tutor$;

  TutorDetailBloc._({
    required Function0<void> dispose,
    required this.getTutorBydId,
    required this.loading$,
    required this.state$,
    required this.tutor$,
  }) : super(dispose);

  factory TutorDetailBloc(@factoryParam String userId,
      {required TutorDetailUseCase tutorDetailUseCase}) {
    ///[Define value]

    final getTutorByIdController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final tutorController =
        BehaviorSubject<TutorDetail>.seeded(const TutorDetail());

    ///[Handle]

    final getTutor$ = getTutorByIdController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final getTutorState$ = Rx.merge<TutorDetailState>([
      getTutor$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return tutorDetailUseCase
              .getTutorById(userId: userId)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                    ifLeft: (error) => GetTutorByIdFailed(
                        error: error.code, message: error.message),
                    ifRight: (tData) {
                      if (tData != null) {
                        tutorController.add(tData);
                        return const GetTutorByIdSuccess();
                      }
                      return GetTutorByIdFailed(message: "Data null");
                    }),
              );
        } catch (e) {
          return Stream<TutorDetailState>.error(
            GetTutorByIdFailed(message: e.toString()),
          );
        }
      }),
      getTutor$.where((isValid) => !isValid).map(
            (_) => const InvalidTutorDetail(),
          )
    ]).whereNotNull().share();

    final state$ =
        Rx.merge<TutorDetailState>([getTutorState$]).whereNotNull().share();

    return TutorDetailBloc._(
      dispose: () async => await DisposeBag(
              [getTutorByIdController, tutorController, loadingController])
          .dispose(),
      getTutorBydId: () => getTutorByIdController.add(null),
      state$: state$,
      loading$: loadingController,
      tutor$: tutorController,
    );
  }
}
