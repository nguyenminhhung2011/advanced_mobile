import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/usecase/login/login_usecase.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_state.dart';
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

  final Function2<String, String, void> rePasswordChanged;

  ///[Streams] response

  final Stream<bool?> loading$;

  final Stream<RegisterState?> state$;

  final Stream<String?> emailError$;

  final Stream<String?> passwordError$;

  final Stream<String?> rePasswordError$;

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
    required this.rePasswordError$,
  }) : super(dispose);

  factory RegisterBloc({required LoginUseCase login}) {
    ///[controllers]
    final emailController = PublishSubject<String>();

    final passwordController = PublishSubject<String>();

    final rePasswordController = PublishSubject<String>();

    final submitRegisterController = PublishSubject<String>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    ///[seeded] add init value is false

    ///[check function] check input is in format

    final isValidSubmit$ = Rx.combineLatest4(
      emailController.stream.map(Validator.isValidEmail),
      passwordController.stream.map(Validator.isValidPassword),
      rePasswordController.stream.map(Validator.isValidPassword),
      loadingController.stream,
      (isValidEmail, isValidPassword, isValidRePassword, loading) =>
          isValidEmail && isValidPassword && isValidRePassword && !loading,
    );

    final submit$ = submitRegisterController.stream
        .withLatestFrom(isValidSubmit$, (_, isValid) => isValid)
        .share();

    final state$ = Rx.merge<RegisterState>(
      [
        submit$
            .where((isValid) => isValid)
            .withLatestFrom(Rx.combineLatest3(
              emailController.stream,
              passwordController.stream,
              rePasswordController.stream,
              (a, b, c) => {'email': a, 'pass': b, 'rePass': c},
            ))
            .exhaustMap((groupData) {
          final email = groupData['email'].toString();
          final password = groupData['pass'].toString();
          final rePass = groupData['rePass'].toString();
          if (password != rePass) {
            return InvalidFormatMessage(message: message);
          }
          return login(
            email: groupData['email'].toString(),
            password: groupData['pass'].toString(),
          )
              .doOn(
                listen: () => loadingController.add(true),
                cancel: () => loadingController.add(false),
              )
              .map(_responseState);
        }),
      ],
    ).whereNotNull().share();

    return RegisterBloc();
  }

  static RegisterState _responseState(SResult<User?> data) => data.fold(
        ifRight: (_) => RegisterSuccess(),
        ifLeft: (error) => RegisterError(error.code!, message: error.message),
      );
}
