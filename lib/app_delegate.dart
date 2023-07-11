import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:injectable/injectable.dart';

import 'application.dart';
import 'core/components/configurations/configurations.dart';
import 'core/dependency_injection/di.dart';
import 'data/datasource/local/preferences.dart';

class AppDelegate {
  Future<Widget> build(Map<String, dynamic> environment) async {
    WidgetsFlutterBinding.ensureInitialized();

    Configurations().setConfigurationValues(environment);

    configureDependencies(environment: Environment.prod);
    var isMobile = Configurations.isMobileMode;
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    return Application(
      navigationKey: GlobalKey<NavigatorState>(),
      providers: [],
      initialRoute: Routes.auth,
      savedThemeMode: savedThemeMode,
      isMobile: isMobile,
    );
  }

  Future<void> run(Map<String, dynamic> environment) async {
    final app = await build(environment);

    await Preferences.ensureInitedPreferences();

    WidgetsFlutterBinding.ensureInitialized();
    runZonedGuarded(
      () => {runApp(app)},
      (error, stack) {
        if (kDebugMode) {
          //Do nothing
        }
      },
    );
  }
}
