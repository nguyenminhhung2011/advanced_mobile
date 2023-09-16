import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:disposebag/disposebag.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/local/preferences.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/type_defs.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

@immutable
abstract class SplashState {}

class IsAuth implements SplashState {
  const IsAuth();
}

class IsNotAuth implements SplashState {
  const IsNotAuth();
}

class InValid implements SplashState {
  const InValid();
}

@injectable
class SplashBloc extends DisposeCallbackBaseBloc {
  final Function0<void> checkAuth;

  final Stream<bool> loading$;

  final Stream<SplashState> state$;

  SplashBloc._({
    required Function0<void> dispose,
    required this.checkAuth,
    required this.loading$,
    required this.state$,
  }) : super(dispose);

  factory SplashBloc() {
    final checkAuthController = PublishSubject<void>();

    final loadingController = BehaviorSubject<bool>.seeded(false);

    final check$ = checkAuthController.stream
        .withLatestFrom(loadingController.stream, (_, loading) => !loading)
        .share();

    final state$ = Rx.merge<SplashState>([
      check$.where((notLoading) => notLoading).exhaustMap((_) {
        return SingleResult<bool>.fromCallable(() async {
          await delay(3000);
          String accessToken = CommonAppSettingPref.getAccessToken();
          String refreshToken = CommonAppSettingPref.getRefreshToken();
          int expiredTime = CommonAppSettingPref.getExpiredTime();
          log("[Access] $accessToken \n[Refresh] $refreshToken");

          if (accessToken.isNotEmpty ||
              refreshToken.isNotEmpty ||
              expiredTime != -1) {
            final expiredTimeParsed =
                DateTime.fromMillisecondsSinceEpoch(expiredTime);
            final isExpired = DateTime.now().isAfter(expiredTimeParsed);

            if (!isExpired) {
              return const Either.right(true);
            }
          }
          return const Either.right(false);
        })
            .doOn(
              listen: () => loadingController.add(true),
              cancel: () => loadingController.add(false),
            )
            .map(
              (data) => data.fold(
                ifLeft: (_) => const InValid(),
                ifRight: (isAuth) =>
                    isAuth ? const IsAuth() : const IsNotAuth(),
              ),
            );
      }),
      check$.where((notLoading) => !notLoading).map((_) => const InValid())
    ]).whereNotNull().share();

    return SplashBloc._(
      dispose: () async {
        try {
          await DisposeBag([checkAuthController, loadingController]).dispose();
        } catch (e) {
          log("[Splash exception] ${e.toString()}");
        }
      },
      checkAuth: () => checkAuthController.add(null),
      loading$: loadingController,
      state$: state$,
    );
  }
}
