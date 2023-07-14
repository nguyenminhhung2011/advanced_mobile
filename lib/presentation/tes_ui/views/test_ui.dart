import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_paint.dart';

import '../../../core/components/constant/image_const.dart';
import '../../../core/components/widgets/tab_bar/tab_bar_type.dart';
import '../../../core/components/widgets/tab_bar/tabbar_custom.dart';

class TestUi extends StatefulWidget {
  const TestUi({super.key});

  @override
  State<TestUi> createState() => _TestUiState();
}

class _TestUiState extends State<TestUi> {
  final dashboardItem = <TabBarModel>[
    TabBarModel(svgAsset: ImageConst.homeIcon, title: 'Home'),
    TabBarModel(svgAsset: ImageConst.searchIcon, title: 'Search'),
    TabBarModel(svgAsset: ImageConst.documentIcon, title: 'Favorite'),
    TabBarModel(svgAsset: ImageConst.personIcon, title: 'Profile')
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabBarCustom(
        elevation: 0.05, // => elevation
        tabBarType: TabBarType.dotTabBar, //if you want display test change to textTabBar
        iconSize: 23.0,
        iconSelectedColor: Colors.red,
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
        onChangeTab: (index) {},
      ),
    );
  }
}
