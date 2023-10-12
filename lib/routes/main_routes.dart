import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/register_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/reset_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/sign_in_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/views/become_tutor_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/before_meeting/views/before_meeting_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/views/course_detail_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/views/pdf_view_page.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/views/dashboard_views.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/views/e_boo_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/views/home_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/meeting/view/meeting_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/bloc/ratting_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/views/ratting_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/schedule/bloc/schedule_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/schedule/views/schedule_screen.dart';
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
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/user_info/bloc/user_infoo_view.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/user_info/views/user_info_bloc.dart';
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
      case Routes.pdfView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return PdfViewerPage(pdfUrl: settings.arguments.toString());
            }
            return const SizedBox();
          },
        );
      case Routes.schedule:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider<ScheduleBloc>(
              initBloc: (_) => injector.get<ScheduleBloc>(),
              child: const ScheduleScreen(),
            );
          },
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider<ResetPassBloc>(
              initBloc: (_) => injector.get<ResetPassBloc>(),
              child: const ResetPasswordScreen(),
            );
          },
        );
      case Routes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider<RegisterBloc>(
              initBloc: (_) => injector.get<RegisterBloc>(),
              child: const RegisterScreen(),
            );
          },
        );
      case Routes.courseDetail:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return BlocProvider<CourseDetailBloc>(
                initBloc: (_) =>
                    injector.get<CourseDetailBloc>(param1: settings.arguments),
                child: const CourseDetailScreen(),
              );
            }
            return const SizedBox();
          },
        );
      case Routes.eBoo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider<EBooBloc>(
              initBloc: (_) => injector.get(),
              child: const EBooScreen(),
            );
          },
        );
      case Routes.userInfo:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider<UserInfoBloc>(
              initBloc: (_) => injector.get<UserInfoBloc>(),
              child: const UserInfoView(),
            );
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
      case Routes.ratting:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return BlocProvider<RattingBloc>(
                initBloc: (_) =>
                    injector.get(param1: settings.arguments.toString()),
                child: const RattingView(),
              );
            }
            return const SizedBox();
          },
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

      case Routes.becomeTutor:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<BecomeTutorBloc>(
            initBloc: (_) => injector.get(),
            child: const BecomeTutorView(),
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
      case Routes.beforeMeeting:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is BooInfo) {
              return BeforeMeetingView(booInfo: settings.arguments as BooInfo);
            }
            return const SizedBox();
          },
        );

      case Routes.meeting:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.arguments is String) {
              return MeetingView(serverUrl: settings.arguments.toString());
            }
            return const SizedBox();
          },
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
