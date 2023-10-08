import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/ratting_usecase/ratting_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/bloc/ratting_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class ReviewTutorRequest {
  final String booId;
  final String userId;
  final double ratting;
  final String content;

  ReviewTutorRequest({
    required this.booId,
    required this.userId,
    required this.ratting,
    required this.content,
  });

  Map<String, dynamic> get toMap => {
        "bookingId": booId,
        "userId": userId,
        "rating": ratting,
        "content": content
      };
}

@injectable
class RattingBloc extends DisposeCallbackBaseBloc {
  ///[function call]
  final Function3<String, String, double, void> rattingTutor;

  ///[Stream]

  final Stream<bool> loading$;

  final Stream<RattingState> state$;

  RattingBloc._({
    required Function0<void> dispose,
    required this.rattingTutor,
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory RattingBloc(@factoryParam String booId,
      {required RattingUseCase rattingUseCase}) {
    final rattingTutorController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final userIdController = BehaviorSubject<String>.seeded("");

    final rattingController = BehaviorSubject<double>.seeded(1.0);

    final contentController = BehaviorSubject<String>.seeded("");

    final rattingTutor$ = rattingTutorController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final state$ = Rx.merge<RattingState>([
      rattingTutor$
          .where((isValid) => isValid)
          .withLatestFrom(
              Rx.combineLatest3(
                  userIdController.stream,
                  rattingController.stream,
                  contentController.stream,
                  (userId, ratting, content) => ReviewTutorRequest(
                        booId: booId,
                        userId: userId,
                        ratting: ratting,
                        content: content,
                      )),
              (_, request) => request)
          .exhaustMap((request) {
        try {
          return rattingUseCase
              .rattingTutor(reviewTutorRequest: request)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                    ifLeft: (error) => RattingFailed(
                        message: error.message, error: error.code),
                    ifRight: (cData) => const RattingSuccess()),
              );
        } catch (e) {
          return Stream.error(RattingFailed(message: e.toString()));
        }
      }),
      rattingTutor$
          .where((isValid) => !isValid)
          .map((_) => RattingFailed(message: "Invalid value"))
    ]).whereNotNull().share();

    final subscriptions = <String, Stream>{
      'state': state$,
      'loadingController': loadingController,
    }.debug();

    return RattingBloc._(
      dispose: () async => await DisposeBag([
        rattingTutorController,
        loadingController,
        userIdController,
        rattingController,
        contentController,
        ...subscriptions,
      ]).dispose(),
      rattingTutor: (userId, content, ratting) {
        userIdController.add(userId);
        rattingController.add(ratting);
        contentController.add(content);
        rattingTutorController.add(null);
      },
      state$: state$,
      loading$: loadingController,
    );
  }
}
