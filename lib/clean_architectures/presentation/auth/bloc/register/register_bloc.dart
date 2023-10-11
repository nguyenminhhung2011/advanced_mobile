import 'package:disposebag/disposebag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/login/login_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@injectable
class RegisterBloc extends DisposeCallbackBaseBloc {
  ///[functions]

  final Function0<void> submitRegister;

  final Function1<String, void> emailChanged;

  final Function1<String, void> passwordChanged;

  final Function1<String, void> rePasswordChanged;

  ///[Streams] response

  final Stream<bool?> loading$;

  final Stream<RegisterState> state$;

  final Stream<String?> emailError$;

  final Stream<String?> passwordError$;

  RegisterBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.submitRegister,
    required this.emailChanged,
    required this.passwordChanged,
    required this.rePasswordChanged,

    ///[Streams]
    required this.state$,
    required this.loading$,
    required this.emailError$,
    required this.passwordError$,
  }) : super(dispose);

  factory RegisterBloc({required LoginUseCase login}) {
    ///[controllers]
    final emailController = PublishSubject<String>();

    final passwordController = PublishSubject<String>();

    final rePasswordController = PublishSubject<String>();

    final submitRegisterController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    ///[seeded] add init value is false

    ///[check function] check input is in format

    final isValidSubmit$ = Rx.combineLatest3(
      emailController.stream.map(Validator.isValidEmail),
      passwordController.stream.map(Validator.isValidPassword),
      loadingController.stream,
      (isValidEmail, isValidPassword, loading) =>
          isValidEmail && isValidPassword && !loading,
    ).shareValueSeeded(false);

    final submit$ = submitRegisterController.stream
        .withLatestFrom(isValidSubmit$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<RegisterState>([
      submit$
          .where((isValid) => isValid)
          .withLatestFrom(
              Rx.combineLatest2(
                emailController.stream,
                passwordController.stream,
                (email, pass) => CredentialState(email: email, password: pass),
              ),
              (_, CredentialState credential) => credential)
          .exhaustMap((groupData) {
        final email = groupData.email.toString();
        final password = groupData.password.toString();
        try {
          return login
              .register(email: email, password: password)
              .doOn(
                ///[Change state] update loading value when register complete
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(
                (data) => data.fold(
                  ifLeft: (error) =>
                      RegisterError(error, message: error.message),
                  ifRight: (_) => RegisterSuccess(),
                ),
              );
        } catch (e) {
          return Stream<RegisterState>.error(
            RegisterError(null, message: e.toString()),
          );
        }
      }),
      submit$
          .where((isValid) => !isValid)
          .map((_) => const InvalidFormatRegisterMessage())
    ])
        .debug(identifier: "Register", log: debugPrint)
        .whereNotNull()

        ///[check] in list group stream have a stream is not null => listen => and connect with UI activities
        .share();

    ///[Share] share stream with another stream listen {in this function share state to UI}

    final emailError$ = emailController.stream
        .map((text) {
          if (Validator.isValidEmail(text)) return null;
          return "Invalid email";
        })
        .distinct()

        ///[distinct] don't get exists data
        .share();

    final passError$ = passwordController.stream
        .map((text) {
          if (Validator.isValidPassword(text)) return null;
          return "Invalid password";
        })
        .distinct()
        .share();

    final subscriptions = <String, Stream>{
      "state": state$,
      "isValidSubmit": isValidSubmit$,
      "loadingController": loadingController,
      "emailError": emailError$,
      "passError": passError$,
    }.debug();

    return RegisterBloc._(
      dispose: () async => await DisposeBag([
        emailController,
        passwordController,
        rePasswordController,
        submitRegisterController,
        loadingController,
        ...subscriptions,
      ]).dispose(),
      submitRegister: () => submitRegisterController.add(null),
      emailChanged: trim.pipe(emailController.add),

      ///[Format] trim string then submit text change function
      passwordChanged: trim.pipe(passwordController.add),
      rePasswordChanged: trim.pipe(rePasswordController.add),
      state$: state$,
      loading$: loadingController,
      emailError$: emailError$,
      passwordError$: passError$,
    );
  }
}
