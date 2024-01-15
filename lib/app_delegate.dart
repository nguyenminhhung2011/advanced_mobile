import 'dart:async';
// import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/firebase_options.dart';
import 'package:lettutor/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'application.dart';
import 'clean_architectures/data/datasource/local/preferences.dart';
import 'clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart';
import 'core/components/configurations/configurations.dart';
import 'core/dependency_injection/di.dart';

class Mutable<T> {
  Mutable(this.value);
  T value;
}

class AppDelegate {
  Future<Widget> build(Map<String, dynamic> environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Configurations().setConfigurationValues(environment);

    configureDependencies(environment: Environment.prod);
    var isMobile = Configurations.isMobileMode;
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    return Application(
      navigationKey: GlobalKey<NavigatorState>(),
      providers: [
        BlocProvider<TestUiBloc>(create: (_) => injector.get()),
      ],
      initialRoute: Routes.splash,
      savedThemeMode: savedThemeMode,
      isMobile: isMobile,
    );
  }

  Future<void> run(Map<String, dynamic> environment) async {
    final app = await build(environment);
    await Preferences.ensureInitedPreferences();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(app);
  }
}
