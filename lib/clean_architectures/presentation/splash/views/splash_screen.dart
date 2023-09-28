import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/splash/bloc/slash_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc get _bloc => BlocProvider.of<SplashBloc>(context);
  Object? listen;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listen ??= _bloc.state$.flatMap(handleState).collect();
    _bloc.checkAuth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<bool?>(
        stream: _bloc.loading$,
        builder: (context, snapShot) {
          if (snapShot.data ?? false) {
            return Center(
              child: StyleLoadingWidget.foldingCube.renderWidget(
                color: Theme.of(context).primaryColor,
                size: 80.0,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Stream handleState(state) async* {
    if (state is IsAuth) {
      log("[Splash message] isAuth");
      await delay(500);
      yield null;

      // ignore: use_build_context_synchronously
      context.pushAndRemoveAll(Routes.dashboard);
    }
    if (state is IsNotAuth) {
      log("[Splash message] isNotAuth");
      await delay(500);
      yield null;

      // ignore: use_build_context_synchronously
      context.pushAndRemoveAll(Routes.auth);
    }
    if (state is InValid) {
      log("[Splash error] Invalid ");
    }
  }
}
