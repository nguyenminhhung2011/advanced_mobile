import 'dart:async';
import 'dart:developer';

import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/stream_extension.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/login/login_usecase.dart';

@injectable
class AuthBloc extends DisposeCallbackBaseBloc {
  ///[functions] input

  final Function0<void> submitSignIn;

  final Function0<void> submitRegister;

  final Function0<void> submitGoogleSignIn;

  final Function1<String, void> emailedChanged;

  final Function1<String, void> passwordChanged;

  ///[Streams] response

  final Stream<bool?> loading$;

  final Stream<AuthState> message$;

  final Stream<String?> emailError$;

  final Stream<String?> passwordError$;

  AuthBloc._({
    required Function0<void> dispose,

    ///[Event functions]
    required this.submitSignIn,
    required this.emailedChanged,
    required this.submitRegister,
    required this.passwordChanged,
    required this.submitGoogleSignIn,

    ///[States]
    required this.message$,
    required this.loading$,
    required this.emailError$,
    required this.passwordError$,
  }) : super(dispose);

  factory AuthBloc({required LoginUseCase login}) {
    ///[controllers]
    final emailController = PublishSubject<String>();

    final passwordController = PublishSubject<String>();

    final submitSignInController = PublishSubject<void>();

    final submitGoogleSignInController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final controllers = [
      emailController,
      passwordController,
      submitSignInController,
      loadingController,
      submitGoogleSignInController,
    ];

    ///
    ///[Streams]
    ///

    ///[check function] check input is in format
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

    ///[Google sign in]
    final submitGoogleSignIn$ = submitGoogleSignInController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final message$ = Rx.merge<AuthState>([
      submit$
          .where((isValid) => isValid)
          .withLatestFrom(credential$, (_, Credential credential) => credential)
          .exhaustMap((credential) {
        try {
          return login
              .login(
                email: credential.email,
                password: credential.password,
              )
              .doOn(
                ///[loading state] set loading after submit
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(_responseToMessage);
        } catch (e) {
          return Stream<AuthState>.error(
            SignInErrorMessage(message: e.toString()),
          );
        }
      }),
      submit$
          .where((isValid) => !isValid)
          .map((_) => const InvalidFormatMessage()),
      submitGoogleSignIn$.where((isValid) => isValid).exhaustMap((_) {
        try {
          return login
              .googleSignIn()
              .doOn(
                  listen: () => loadingController.add(true),
                  cancel: () => loadingController.add(false))
              .map(
                (data) => data.fold(
                    ifLeft: (error) => SignInErrorMessage(
                        message: error.message, error: error.code),
                    ifRight: (_) => const SignInSuccessMessage()),
              );
        } catch (e) {
          return Stream.error(SignInErrorMessage(message: e.toString()));
        }
      })
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

    final subscriptions = <String, Stream>{
      'message': message$,
      'emailError': emailError$,
      'loading': loadingController,
      'isValidSubmit': isValidSubmit$,
      'passwordError': passwordError$,
    }.debug();

    subscriptions;

    return AuthBloc._(
      dispose: () async {
        try {
          await DisposeBag([...controllers, ...subscriptions]).dispose();
        } catch (exceptions) {
          log('[Sign in exceptions] ${exceptions.toString()}');
        } finally {
          // super.dispose();
        }
      },
      message$: message$,
      emailError$: emailError$,
      loading$: loadingController,
      passwordError$: passwordError$,
      emailedChanged: trim.pipe(emailController.add),
      passwordChanged: trim.pipe(passwordController.add),
      submitSignIn: () => submitSignInController.add(null),
      submitRegister: () => submitSignInController.add(null),
      submitGoogleSignIn: () => submitGoogleSignInController.add(null),
    );
  }

  static AuthState _responseToMessage(SResult<TokenModel?> data) {
    return data.fold(
      ifRight: (_) => const SignInSuccessMessage(),
      ifLeft: (error) =>
          SignInErrorMessage(error: error.code, message: error.message),
    );
  }
}
