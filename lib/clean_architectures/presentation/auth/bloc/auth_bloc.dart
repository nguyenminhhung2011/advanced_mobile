import 'dart:async';

import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/login/login_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/stream_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';

import 'package:rxdart/rxdart.dart';

import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';

enum AuthState { none, loading }

class AuthBloc extends DisposeCallbackBaseBloc {
  ///[functions] input
  final Function1<String, void> emailedChanged;

  final Function1<String, void> passwordChanged;

  final Function0<void> submitSignIn;

  final Function0<void> submitRegister;

  ///[Streams] response

  final Stream<String?> emailError$;

  final Stream<String?> passwordError$;

  final Stream<bool?> loading$;

  final Stream<AuthState> message$;

  AuthBloc._({
    required Function0<void> dispose,
    required this.emailedChanged,
    required this.passwordChanged,
    required this.submitSignIn,
    required this.submitRegister,
    required this.emailError$,
    required this.passwordError$,
    required this.message$,
    required this.loading$,
  }) : super(dispose);

  factory AuthBloc({required LoginUseCase login}) {
    ///[controllers]
    final emailController = PublishSubject<String>();
    final passwordController = PublishSubject<String>();
    final submitSignInController = PublishSubject<void>();
    final loadingController = BehaviorSubject<bool>.seeded(false);

    final controllers = [
      emailController,
      passwordController,
      submitSignInController,
      loadingController
    ];

    ///
    ///[Streams]
    ///

    final isValidSubmit$ = Rx.combineLatest3(
      emailController.stream.map(Validator.isValidEmail),
      passwordController.stream.map(Validator.isValidPassword),
      loadingController.stream,
      (isValidEmail, isValidPassword, loading) =>
          isValidEmail && isValidPassword && !loading,
    ).shareValueSeeded(false);

    final credential$ = Rx.combineLatest2(
      emailController.stream,
      passwordController.stream,
      (String email, String password) =>
          Credential(email: email, password: password),
    );

    final submit$ = submitSignInController.stream
        .withLatestFrom(isValidSubmit$, (_, isValid) => isValid)
        .share();

    final message$ = Rx.merge([
      submit$
          .where((isValid) => isValid)
          .withLatestFrom(credential$, (_, Credential credential) => credential)
          .exhaustMap(
            (credential) => login
                .loginS(
                  userName: credential.email,
                  password: credential.password,
                )
                .doOnListen(() => loadingController.add(true))
                .doOnCancel(() => loadingController.add(false)),
          ),
      submit$.where((isValid) => !isValid).map((event) => null),
    ]).whereNotNull().share();

    final emailError$ = emailController.stream
        .map((email) {
          if (Validator.isValidEmail(email)) return null;
          return 'Invalid email address';
        })
        .distinct()
        .share();

    final passwordError$ = passwordController.stream
        .map((password) {
          if (Validator.isValidPassword(password)) return null;
          return 'Invalid password address';
        })
        .distinct()
        .share();

    void _onDispose() {
      controllers.map((e) {
        if (e is PublishSubject) {
          e.clear();
          e.close();
        } else if (e is BehaviorSubject) {
          e.clear();
          e.close();
        }
      });
    }

    return AuthBloc._(
      dispose: _onDispose,
      emailedChanged: trim.pipe(emailController.add),
      passwordChanged: trim.pipe(passwordController.add),
      submitSignIn: () => submitSignInController.add(null),
      submitRegister: () => submitSignInController.add(null),
      emailError$: emailError$,
      passwordError$: passwordError$,
      message$: null,
      loading$: loadingController,
    );
  }

  static AuthState? _responseToMessage(SResult<User> data) {
    return data.fold(
      ifLeft: (error) =>
          SignInErrorMessage(error.code!, error.message) as AuthState,
      ifRight: (_) => const SignInSuccessMessage() as AuthState,
    );
  }
}
