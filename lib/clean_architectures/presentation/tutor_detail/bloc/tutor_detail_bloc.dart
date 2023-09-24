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

  final Function0<void> favTutor;

  ///[Streams]

  final Stream<TutorDetailState> state$;

  final Stream<bool?> loading$;

  final Stream<bool?> loadingFav$;

  final Stream<TutorDetail> tutor$;

  TutorDetailBloc._({
    required Function0<void> dispose,
    required this.getTutorBydId,
    required this.loadingFav$,
    required this.favTutor,
    required this.loading$,
    required this.state$,
    required this.tutor$,
  }) : super(dispose);

  factory TutorDetailBloc(@factoryParam String userId,
      {required TutorDetailUseCase tutorDetailUseCase}) {
    ///[Define value]

    final getTutorByIdController = PublishSubject<void>();

    final favTutorController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final loadingFavController = BehaviorSubject<bool>.seeded(false);

    final tutorController =
        BehaviorSubject<TutorDetail>.seeded(const TutorDetail());

    ///[Handle]

    final getTutor$ = getTutorByIdController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final favTutor$ = favTutorController.stream
        .withLatestFrom(loadingFavController.stream, (_, loading) => !loading)
        .share();

    final favTutorState$ = Rx.merge<TutorDetailState>([
      favTutor$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .exhaustMap((_) {
        try {
          return tutorDetailUseCase
              .addTutorToFavorite(userId: userId)
              .doOn(
                listen: () => loadingFavController.add(true),
                cancel: () => loadingFavController.add(false),
              )
              .map((data) => data.fold(
                  ifLeft: (error) =>
                      FavTutorFailed(message: error.message, error: error.code),
                  ifRight: (add) {
                    if (add) {
                      final currentTutor = tutorController.value;
                      tutorController.add(
                        currentTutor.copyWith(
                            isFavorite: !(currentTutor.isFavorite ?? false)),
                      );
                      return const FavTutorSuccess();
                    }
                    return FavTutorFailed(message: 'Failed');
                  }));
        } catch (e) {
          return Stream<TutorDetailState>.error(
            const InvalidTutorDetail(),
          );
        }
      })
    ]).whereNotNull().share();

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

    final state$ = Rx.merge<TutorDetailState>([getTutorState$, favTutorState$])
        .whereNotNull()
        .share();

    return TutorDetailBloc._(
      dispose: () async => await DisposeBag([
        getTutorByIdController,
        tutorController,
        loadingController,
        loadingFavController,
        favTutorController
      ]).dispose(),
      getTutorBydId: () => getTutorByIdController.add(null),
      favTutor: () => favTutorController.add(null),
      state$: state$,
      loading$: loadingController,
      loadingFav$: loadingFavController,
      tutor$: tutorController,
    );
  }
}
