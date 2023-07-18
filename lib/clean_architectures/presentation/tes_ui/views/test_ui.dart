import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category/category_model.dart';
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

  List<CategoryModel> listCategory = <CategoryModel>[
    CategoryModel(
      title: 'Hotels',
      iconUrl: ImageConst.homeIcon,
      color: '#ffd3b5ff'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      title: 'Flight',
      iconUrl: ImageConst.personIcon,
      color: '#ffffc0ee'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      title: 'Airports',
      iconUrl: ImageConst.documentIcon,
      color: '#ffffdab5'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      title: 'Ticket',
      iconUrl: ImageConst.searchIcon,
      color: '#ff97d5ff'.toColor(),
      isIconData: true,
    ),
    CategoryModel(
      title: 'Phone',
      iconUrl: ImageConst.searchIcon,
      color: '#ff9735ff'.toColor(),
      isIconData: false,
    ),
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
          const SizedBox(height: 30.0),
          CategoryField(
            categoryType: CategoryType.textCategory,
            spacingItem: 15.0,
            marginLeft: 10.0,
            marginRight: 10.0,
            numberColumn: 2,
            isIconOut: false,
            selectedColor: Theme.of(context).primaryColor,
            unselectedColor: Theme.of(context).hintColor,
            categoryTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
            categories: <CategoryStyle>[
              ...listCategory.mapIndexed(
                (index, e) => CategoryStyle(
                  isSelected: index == 0,
                  text:e.title,
                  typeImage: TypeImage.assetSvg,
                  iconUrl: e.iconUrl,
                  color: e.color,
                  iconSize:e.iconSize,
                  isIcon: e.isIconData,
                  radius: 10,
                  paddingBottom: 10.0,
                  paddingRight: 15.0,
                  paddingTop: 10.0,
                  paddingLeft: 15.0,
                  onPress: () {},
                ),
              )
            ],
          ),
          const SizedBox(height: 30.0),
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
