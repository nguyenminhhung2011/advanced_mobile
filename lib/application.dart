import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/routes/main_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'core/dependency_injection/di.dart';
import 'generated/l10n.dart';

class Application extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final GlobalKey<NavigatorState> navigationKey;
  final List<BlocProvider> providers;
  final String initialRoute;
  final bool isMobile;

  const Application({
    super.key,
    required this.providers,
    required this.initialRoute,
    required this.navigationKey,
    required this.savedThemeMode,
    required this.isMobile,
  });

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _listStateChange(_, SettingState state) {}

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(brightness: Brightness.light),
      dark: ThemeData(brightness: Brightness.dark),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          ...widget.providers,
          BlocProvider<SettingBloc>(create: (_) => injector.get()),
        ],
        child: BuildMaterialApp(
          widget: widget,
          light: theme,
          dark: darkTheme,
        ),
      ),
    );
  }
}

class BuildMaterialApp extends StatefulWidget {
  const BuildMaterialApp({
    super.key,
    required this.widget,
    required this.light,
    required this.dark,
  });

  final Application widget;
  final ThemeData? light;
  final ThemeData dark;

  @override
  State<BuildMaterialApp> createState() => _BuildMaterialAppState();
}

class _BuildMaterialAppState extends State<BuildMaterialApp> {
  SettingBloc get _settingController => BlocProvider.of<SettingBloc>(context);

  @override
  void initState() {
    _settingController.add(const SettingEvent.started());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_settingController.data.appearance.isDark) {
        AdaptiveTheme.of(context).setDark();
      } else {
        AdaptiveTheme.of(context).setLight();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (_, __) {},
      builder: (context, state) {
        return MaterialApp(
          title: 'Flight booking',
          navigatorKey: widget.widget.navigationKey,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MainRoutes.getRoute,
          initialRoute: widget.widget.initialRoute,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: widget.light?.copyWith(
                primaryColor: '#07AEAF'.toColor(),
                primaryColorDark: '#07AEAF'.toColor(),
                // fontFamily: 'Montserrat',
              ) ??
              ThemeData(),
          darkTheme: widget.dark.copyWith(
            primaryColor: '#07AEAF'.toColor(),
          ),
          locale: state.data.currentLocale,
        );
      },
    );
  }
}
