import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
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
  List<Map<String, dynamic>> dashboardItem = [
    {
      'icon': ImageConst.homeIcon,
      'tit': 'Home',
      'index': 0,
      'screen': Container(color: Colors.red),
    },
    {
      'icon': ImageConst.searchIcon,
      'tit': 'Search',
      'index': 1,
      'screen': Container(color: Colors.yellow),
    },
    {
      'icon': ImageConst.documentIcon,
      'tit': 'Favorite',
      'index': 2,
      'screen': Container(color: Colors.blue),
    },
    {
      'icon': ImageConst.personIcon,
      'tit': 'Profile',
      'index': 3,
      'screen': Container(color: Colors.brown),
    },
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabBarCustom(
        elevation: 0.05,
        tabBarColor: Colors.black,
        tabBarType: TabBarType.rowTabBar,
        painterType: TabBarPainterType.circle,
        iconColor: Colors.red,
        duration: 300,
        // hMargin: 10,
        // radius: 10,
        animatedTabStyle: const AnimatedTabStyle(posHeight: 5),
        items: <TabBarItemStyle>[
          ...dashboardItem.map(
            (e) => TabBarItemStyle(
              title: e['tit'],
              assetIcon: e['icon'],
              screen: e['screen'],
            ),
          ),
        ],
        onChangeTab: (index) {},
        // iconColor: Colors,
        // usSelectedColor: context.titleLarge.color,
      ),
      // bottomNavigationBar: MoltenBottomNavigationBar(
      //   borderRaduis: BorderRadius.circular(0.0),
      //   barColor: Colors.black,
      //   domeHeight:5,
      //   domeWidth: 100,
      //   domeCircleColor: Theme.of(context).primaryColor.withOpacity(0.5),
      //   selectedIndex: _selectedIndex,
      //   onTabChange: (clickedIndex) {
      //     setState(() {
      //       _selectedIndex = clickedIndex;
      //     });
      //   },
      //   tabs: [
      //     MoltenTab(
      //       icon: Icon(Icons.search),
      //     ),
      //     MoltenTab(
      //       icon: Icon(Icons.search),
      //     ),
      //     MoltenTab(
      //       icon: Icon(Icons.home),
      //     ),
      //     MoltenTab(
      //       icon: Icon(Icons.person),
      //     ),
      //   ],
      // ),
    );
  }
}
