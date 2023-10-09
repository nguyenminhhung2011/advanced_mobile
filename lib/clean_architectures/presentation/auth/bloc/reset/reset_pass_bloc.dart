import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/reset_pass/reset_pass_usecase.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@immutable
abstract class ResetPassState {}

class ResetPassSuccess implements ResetPassState {
  const ResetPassSuccess();
}

class ResetPassFailed implements ResetPassState {
  final String? message;
  ResetPassFailed({this.message});

  @override
  String toString() => "🐛[ Reset password failed] $message";
}

@injectable
class ResetPassBloc extends DisposeCallbackBaseBloc {
  ///[Functions]
  final Function0<void> submitReset;

  final Function1<String, void> emailedChanged;

  ///[Streams]
  final Stream<String?> emailError$;

  final Stream<bool?> loading$;

  final Stream<ResetPassState> state$;

  ResetPassBloc._({
    required Function0<void> dispose,
    required this.submitReset,
    required this.emailedChanged,
    //-----------------------------------
    required this.emailError$,
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory ResetPassBloc({required ResetPassUseCase resetPassUseCase}) {
    final loadingController = BehaviorSubject<bool>.seeded(false);

    //----------------------------------------

    final emailController = PublishSubject<String>();

    final submitResetController = PublishSubject<void>();

    ///[Handle actions]

    final isValidSubmit$ = Rx.combineLatest2(
      emailController.stream.map(Validator.isValidEmail),
      loadingController.stream,
      (isValidEmail, loading) => isValidEmail && !loading,
    ).shareValueSeeded(false);

    final submit$ = submitResetController.stream
        .withLatestFrom(isValidSubmit$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<ResetPassState>([
      submit$
          .where((isValid) => isValid)
          .debug(log: debugPrint)
          .withLatestFrom(emailController.stream, (_, email) => email)
          .exhaustMap((email) {
        try {
          return resetPassUseCase
              .resetPassword(email: email)
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) => ResetPassFailed(message: error.message),
                  ifRight: (_) => const ResetPassSuccess(),
                ),
              );
        } catch (e) {
          return Stream.error(ResetPassFailed(message: e.toString()));
        }
      }),
      submit$
          .where((isValid) => !isValid)
          .map((_) => ResetPassFailed(message: "Invalid format"))
    ]).whereNotNull().share();

    final emailError$ = emailController.stream
        .map((email) {
          if (Validator.isValidEmail(email)) return null;
          return "Invalid email address";
        })
        .distinct()
        .share();
    final subscriptions = <String, Stream>{
      'state': state$,
      'emailError': emailError$,
      'loading': loadingController,
      'isValidSubmit': isValidSubmit$,
    }.debug();

    return ResetPassBloc._(
      state$: state$,
      dispose: () async => await DisposeBag([
        emailController,
        loadingController,
        submitResetController,
        ...subscriptions,
      ]).dispose(),
      submitReset: () => submitResetController.add(null),
      emailError$: emailError$,
      loading$: loadingController,
      emailedChanged: trim.pipe(emailController.add),
    );
  }
}
