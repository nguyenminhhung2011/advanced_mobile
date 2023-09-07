import 'dart:async';

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

  AuthBloc._({
    required Function0<void> dispose,
    required this.emailedChanged,
    required this.passwordChanged,
    required this.submitSignIn,
    required this.submitRegister,
    required this.emailError$,
    required this.passwordError$,
    required this.loading$,
  }) : super(dispose);

  factory AuthBloc() {
    ///[controllers]
    final emailController = PublishSubject<String>();
    final passwordController = PublishSubject<String>();
    final submitSignInController = PublishSubject<void>();
    final loadingController = BehaviorSubject<bool>.seeded(false);

    final controllers = [
      emailController,
      passwordController,
      submitSignInController,
      loadingController</bool>
    ];


  }
}
