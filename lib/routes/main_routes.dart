import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/sign_in_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/views/dashboard_views.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/views/home_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/views/search_tutor_result.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/views/search_tutor_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/splash/bloc/slash_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/splash/views/splash_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/views/tutor_detail_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_schedule/views/tutor_schedule_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/views/tutor_show_screen.dart';
import 'package:flutter_base_clean_architecture/core/dependency_injection/di.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';

import '../clean_architectures/presentation/tes_ui/views/test_ui.dart';
import '../core/components/layout/setting_layout/views/passcode_screen.dart';

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
          builder: (_) => BlocProvider<AuthBloc>(
            initBloc: (_) => injector.get(),
            child: const SignInScreen(),
          ),
        );
      case Routes.searchTutorResult:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is SearchTutorRequest) {
              return BlocProvider<SearchTutorResultBloc>(
                initBloc: (_) => injector.get<SearchTutorResultBloc>(
                    param1: settings.arguments),
                child: const SearchTutorResultView(),
              );
            }
            return const SizedBox();
          },
        );
      case Routes.tutorDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return BlocProvider<TutorDetailBloc>(
                initBloc: (_) =>
                    injector.get<TutorDetailBloc>(param1: settings.arguments),
                child: const TutorDetailScreen(),
              );
            }
            return const SizedBox();
          },
        );
      case Routes.tutorSchedule:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return BlocProvider<TutorScheduleBloc>(
                initBloc: (_) =>
                    injector.get<TutorScheduleBloc>(param1: settings.arguments),
                child: const TutorScheduleScreen(),
              );
            }
            return const SizedBox();
          },
        );
      case Routes.searchTutor:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<SearchTutorBloc>(
            initBloc: (_) => injector.get(),
            child: const SearchTutorScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<HomeBloc>(
            initBloc: (_) => injector.get(),
            child: const HomeScreen(),
          ),
        );
      case Routes.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<DashboardBloc>(
            initBloc: (_) => injector.get(),
            child: const DashboardView(),
          ),
        );
      case Routes.tutorShow:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<TutorShowBloc>(
            initBloc: (_) => injector.get(),
            child: const TutorShowScreen(),
          ),
        );

      case Routes.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<SplashBloc>(
            initBloc: (_) => SplashBloc(),
            child: const SplashScreen(),
          ),
        );

      case Routes.passCode:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return PassCodeScreen(routes: settings.arguments.toString());
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
