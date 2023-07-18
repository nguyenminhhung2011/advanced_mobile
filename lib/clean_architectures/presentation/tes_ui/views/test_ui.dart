import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';

import '../../../../core/components/constant/image_const.dart';
import '../../../../core/components/widgets/category/category_custom.dart';
import '../../../../core/components/widgets/category/category_type.dart';
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
  List<Map<String, dynamic>> mockCategory = [
    {
      'text': 'Hotels',
      'icon': ImageConst.homeIcon,
      'color': '#ffd3b5ff'.toColor(),
      'route': '',
    },
    {
      'text': 'Flight',
      'icon': ImageConst.personIcon,
      'color': '#ffffc0ee'.toColor(),
      'route': '',
    },
    {
      'text': 'Airports',
      'icon': ImageConst.documentIcon,
      'color': '#ffffdab5'.toColor(),
      'route': '',
    },
    {
      'text': 'Ticket',
      'icon': ImageConst.searchIcon,
      'color': '#ff97d5ff'.toColor(),
      'route': '',
    },
    {
      'text': 'Ticket',
      'icon': ImageConst.searchIcon,
      'color': '#ff9735ff'.toColor(),
      'route': '',
    },
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
        onChangeTab: (index) {},
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          CategoryField(
            categoryType: CategoryType.expandCategory,
            spacingItem: 10.0,
            marginLeft: 10.0,
            marginRight: 10.0,
            numberColumn: 2,
            isIconOut: false,
            selectedColor: Colors.red,
            categories: <CategoryStyle>[
              ...mockCategory.mapIndexed(
                (index, e) => CategoryStyle(
                  isSelected: index == 0,
                  text: e['text'],
                  icon: e['icon'],
                  color: e['color'],
                  iconSize: 20,
                  radius: 10,
                  paddingBottom: 10.0,
                  paddingRight: 15.0,
                  paddingTop: 10.0,
                  paddingLeft:15.0,
                  textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                  onPress: () {},
                ),
              )
            ],
          ),
          Expanded(
            child: PaginationViewCustom<ModelTest>(
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
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
                ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
              ],
              itemBuilder: (BuildContext context, ModelTest data, int index) {
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
          ),
        ],
      ),
    );
  }
}
