import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/presentation/tes_ui/views/test_ui.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

class MainRoutes {
  static Map<String, WidgetBuilder> getRoutesWithSettings() {
    final routes = {Routes.auth: (context) => const SizedBox()};
    return routes;
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const SizedBox();
          },
        );
      case Routes.testUi:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const TestUi();
          },
        );


      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}
