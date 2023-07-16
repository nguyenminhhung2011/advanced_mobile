import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';

import '../../../../core/components/constant/image_const.dart';
import '../../../../core/components/widgets/tab_bar/tab_bar_type.dart';
import '../../../../core/components/widgets/tab_bar/tabbar_custom.dart';

class ModelTest {
  final String userName;
  final String bio;
  ModelTest({required this.userName, required this.bio});
}

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

  Future<List<ModelTest>> paginationCall(int currentPage) async {
    // Get items by calling function get data with currentPage + 1
    await Future.delayed(const Duration(seconds: 3));
    return <ModelTest>[
      ModelTest(userName: 'Hung', bio: 'Nguyen Minh Hung'),
      ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
      ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
      ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination view'),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabBarCustom(
        elevation: 0.05, // => elevation
        tabBarType: TabBarType
            .animationTabBar, //if you want display test change to textTabBar
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
      body: PaginationViewCustom<ModelTest>(
        paginationViewType: PaginationViewType.grid,
        paginationDataCall: paginationCall,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        hPadding: 10,
        vPadding: 10,
        typeIndicatorLoading: TypeIndicatorLoading.skeltonIndicator,
        gridViewFormat: const GridViewFormat(
          crossAxisCount: 3,
        ),
        skeltonFormat: const SkeltonFormat(
          columns: [4, 1],
        ),
        limitFetch: 15,
        items: <ModelTest>[
          ModelTest(userName: 'Hung', bio: 'Nguyen Minh Hung'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
          // ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        ],
        itemBuilder: (BuildContext context, ModelTest data, int index) {
          // return ListTile(
          //   title: Text(data.userName),
          //   subtitle: Text(data.bio),
          //   leading: Container(
          //     padding: const EdgeInsets.all(10.0),
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       shape: BoxShape.circle,
          //     ),
          //     child: const Icon(Icons.person),
          //   ),
          // );
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data.userName),
                Text(data.bio),
              ],
            ),
          );
        },
      ),
    );
  }
}
