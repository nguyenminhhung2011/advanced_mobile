import 'package:flutter/material.dart';
import 'package:lettutor/clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/home/views/home_screen.dart';
import 'package:lettutor/clean_architectures/presentation/main/bloc/main_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/main/views/main_view.dart';
import 'package:lettutor/clean_architectures/presentation/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/schedule/views/schedule_screen.dart';
import 'package:lettutor/clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart';
import 'package:lettutor/clean_architectures/presentation/tutor_views/views/tutor_show_screen.dart';
import 'package:lettutor/core/components/extensions/bloc_extension.dart';
import 'package:lettutor/core/components/network/soc/app_soc.dart';
import 'package:lettutor/core/components/ui_config/setting_config.dart';
import 'package:lettutor/core/components/constant/image_const.dart';
import 'package:lettutor/core/components/layout/setting_layout/views/setting_screen.dart';
import 'package:lettutor/core/components/widgets/tab_bar/tab_bar_model.dart';
import 'package:lettutor/core/components/widgets/tab_bar/tab_bar_type.dart';
import 'package:lettutor/core/components/widgets/tab_bar/tabbar_custom.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardBloc get _bloc => BlocProvider.of<DashboardBloc>(context);

  AppSoc get _apPSoc => context.readAppSoc;

  Object? listen;
  @override
  void initState() {
    _apPSoc.connect();
    super.initState();
    listen ??= _bloc.state$.flatMap(handleState).collect();
  }

  final dashboardItem = <TabBarModel>[
    TabBarModel(
      svgAsset: ImageConst.homeIcon,
      title: 'Home',
      screen: BlocProvider<MainBloc>(
        initBloc: (_) => injector.get(),
        child: const MainView(),
      ),
    ),
    TabBarModel(
      svgAsset: ImageConst.documentIcon,
      title: 'Home',
      screen: BlocProvider<TutorShowBloc>(
        initBloc: (_) => injector.get(),
        child: const TutorShowScreen(),
      ),
    ),
    TabBarModel(
      svgAsset: ImageConst.searchIcon,
      title: 'Search',
      screen: BlocProvider<HomeBloc>(
        initBloc: (_) => injector.get(),
        child: const HomeScreen(),
      ),
    ),
    TabBarModel(
      svgAsset: ImageConst.calendarIcon,
      title: 'Favorite',
      screen: BlocProvider<ScheduleBloc>(
        initBloc: (_) => injector.get(),
        child: const ScheduleScreen(),
      ),
    ),
    TabBarModel(
      svgAsset: ImageConst.personIcon,
      title: 'Profile',
      screen: SettingScreen(
        settingConfig: SettingConfig.fromJson({
          'enable_user': true,
          'setting_layout': 'view1',
          'app_bar_color': '07AEAF',
          'hPadding': 10.0,
          'vPadding': 10.0,
          'shadow_elevation': 0.2,
          'pop_up_route': Routes.splash,
          'behindBackground':
              'https://wallpapers.com/images/featured/panda-background-ymceqx76sixgb2ni.jpg',
          'list_view': [
            'security',
            'lang',
            'appearance',
            'about',
            'becomeTutor',
          ],
        }),
      ),
    )
  ];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabBarCustom(
        radius: 15,
        elevation: 0.1, // => elevation
        tabBarType: TabBarType
            .dotTabBar, //if you want display test change to textTabBar
        iconSize: 23.0,
        iconSelectedColor: Theme.of(context).primaryColor,
        duration: 200, // => set animation when change tab
        isSvgIcon: true,
        animatedTabStyle: const AnimatedTabStyle(posHeight: 5),
        items: <TabBarItemStyle>[
          ...dashboardItem.map(
            (e) => TabBarItemStyle(
              title: e.title,
              assetIcon: e.svgAsset,
              iconData: e.iconData,
              screen: e.screen,
            ),
          ),
        ],
        onChangeTab: (index) {
          _bloc.changeTabView(index);
        },
      ),
      body: StreamBuilder<int>(
        stream: _bloc.tabIndex$,
        builder: (ctx, sS) {
          final currentIndex = sS.data ?? 0;
          return IndexedStack(
            index: currentIndex,
            sizing: StackFit.expand,
            children: dashboardItem.map((e) => e.screen).toList(),
          );
        },
      ),
    );
  }

  Stream handleState(state) async* {}
}
