import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/config/app_config.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/network/isolate/isolate_run.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category/category_model.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category_layout/category_layout.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category_layout/category_layout_type.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/custom_text_field.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/expansion_panel_list/expansion_panel_list.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_stack_view/image_stac_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_base_clean_architecture/core/components/config/setting_config.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_button.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/tree_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/video_player.dart';
import '../../../../core/components/constant/image_const.dart';
import '../../../../core/components/layout/setting_layout/views/setting_screen.dart';
import '../../../../core/components/mixins/app_mixin.dart';
import '../../../../core/components/widgets/banner/banner_slider.dart';
import '../../../../core/components/widgets/category/category_custom.dart';
import '../../../../core/components/widgets/category/category_type.dart';
import '../../../../core/components/layout/search_layout/header_search/header_search.dart';
import '../../../../core/components/layout/search_layout/model/filter_model.dart';
import '../../../../core/components/layout/search_layout/views/search_layou.dart';
import '../../../../core/components/widgets/tab_bar/tab_bar_type.dart';
import '../../../../core/components/widgets/tab_bar/tabbar_custom.dart';
import '../../../../core/components/widgets/progress_indicator/linear_percent_indicator.dart';

class ModelTest {
  final String userName;
  final String bio;
  ModelTest({required this.userName, required this.bio});
}

class ModelImageTest {
  final String imageUrl;
  final String title;
  final String subTitle;
  ModelImageTest({
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });
}

class TestUi extends StatefulWidget {
  const TestUi({super.key});

  @override
  State<TestUi> createState() => _TestUiState();
}

class _TestUiState extends State<TestUi> with AppMixin {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  final dashboardItem = <TabBarModel>[
    TabBarModel(
        svgAsset: ImageConst.homeIcon,
        title: 'Home',
        screen: const PageTest1()),
    TabBarModel(
      svgAsset: ImageConst.searchIcon,
      title: 'Search',
      screen: const PageTest7(),
    ),
    TabBarModel(
      svgAsset: ImageConst.documentIcon,
      title: 'Favorite',
      screen: const PageTest5(),
    ),
    TabBarModel(
      svgAsset: ImageConst.personIcon,
      title: 'Profile',
      screen: const PageTest6(),
    )
  ];

  @override
  void onComplete() async {
    await Future.delayed(const Duration(seconds: 3));
    log("hahahah");
  }

  @override
  AppConfig? get appConfig => AppConfig();

  @override
  Widget build(BuildContext context) {
    // onComplete.call();
    // return Scaffold(
    //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   body: Column(
    //     children: [
    //       const Spacer(),
    //       imageShowWidget(splashType: SplashType.normalSplash),
    //       const SizedBox(height: 10.0),
    //       textApp(
    //         title: <String>['Weather', ' App'],
    //         style: [
    //           context.titleMedium.copyWith(fontWeight: FontWeight.w700),
    //           context.titleMedium.copyWith(
    //             color: Theme.of(context).primaryColor,
    //             fontWeight: FontWeight.w700,
    //           )
    //         ],
    //       ),
    //       const SizedBox(height: 20.0),
    //       loadingWidget(LoadingType.jumpingDot),
    //       const Spacer(),
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: TabBarCustom(
        radius: 15,
        elevation: 0.1, // => elevation
        tabBarType: TabBarType
            .dotTabBar, //if you want display test change to textTabBar
        // tabBarColor: Colors.black,
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
        onChangeTab: (index) => _index.value = index,
      ),
      body: ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, index, child) {
          return IndexedStack(
            index: index,
            sizing: StackFit.expand,
            children: dashboardItem.map((e) => e.screen).toList(),
          );
        },
      ),
    );
  }
}

class PageTest7 extends StatefulWidget {
  const PageTest7({super.key});

  @override
  State<PageTest7> createState() => _PageTest7State();
}

class _PageTest7State extends State<PageTest7> {
  Future<void> _test(int dataCall) async {
    log(dataCall.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          const SizedBox(height: 10.0),
          ButtonCustom(
            onPress: () {
              IsolateRunT<int>(
                data: 0,
                progressCall: (event) => _test(event.data),
              ).updateEventCallAndInit(event: () {
                int countable = 0;
                for (var i = 0; i < 100000000; i++) {
                  countable += i;
                }
                log(countable.toString());
                return countable;
              });
            },
            enableWidth: false,
            child: const Text('Test'),
          )
        ],
      ),
    );
  }
}

class PageTest6 extends StatelessWidget {
  const PageTest6({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingScreen(
      settingConfig: SettingConfig.fromJson({
        'enable_user': true,
        'setting_layout': 'view1',
        'app_bar_color': '07AEAF',
        'hPadding': 10.0,
        'vPadding': 10.0,
        'shadow_elevation': 0.2,
        'behindBackground':
            'https://wallpapers.com/images/featured/panda-background-ymceqx76sixgb2ni.jpg',
        'list_view': [
          'security',
          'lang',
          'currencies',
          'appearance',
          'notifications',
          'about',
        ],
      }),
    );
  }
}

class PageTest5 extends StatelessWidget {
  const PageTest5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchLayout<ModelImageTest>(
      searchCall: (text, filters, currentPage) async {
        // log('hhdhdhdhhhh');
        await Future.delayed(const Duration(seconds: 3));
        return <ModelImageTest>[
          for (int t = 0; t < 10; t++)
            ModelImageTest(
              imageUrl: ImageConst.baseImageView,
              title: 'Product t$text',
              subTitle: 'This is product $t of page $currentPage',
            ),
        ];
      },
      itemBuilder: (_, data) {
        return _itemBuilder(data);
      },
      groupHeaderStyle: GroupHeaderStyle(
        contentHeaderSearchPadding: const EdgeInsets.all(10.0),
        listFilter: _listFilter,
      ),
    );
  }

  Padding _itemBuilder(ModelImageTest data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data.imageUrl),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title),
                Text(data.subTitle),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<FilterModel> get _listFilter {
    return [
      PriceModel(
        header: 'By price',
        maxPrice: 10000,
        minPrice: 0.0,
      ),
      PriceModel(
        header: 'By Sale',
        maxPrice: 10000,
        minPrice: 0.0,
      ),
      CompareModel(compares: [
        Compare(
          headerCategory: 'Date',
          left: 'Latest',
          right: 'Oldest',
        ),
        Compare(
          headerCategory: 'Price',
          left: 'Low to Hight',
          right: 'Hight to Low',
        ),
      ], header: 'Compares'),
      CategoryModelSearch(
        header: 'Categories',
        categories: const [
          'Hahaha',
          'Hihihihihi',
          'Hohohoho',
          'Hehehe',
          'Huhuhu'
        ],
      )
    ];
  }
}

class PageTest4 extends StatefulWidget {
  const PageTest4({super.key});

  @override
  State<PageTest4> createState() => _PageTest4State();
}

class _PageTest4State extends State<PageTest4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: TreeView<String>(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (_, node) => Text(
          'level ${node.level} parent ${node.parentIndex} data ${node.data} currentIndex ${node.currentIndex}',
          style: context.titleMedium.copyWith(overflow: TextOverflow.ellipsis),
        ),
        onTapNode: (parentNode) async => (parentNode == null)
            ? ['sTest', 'sTest', 'sTest']
            : parentNode.level >= 3
                ? List.empty()
                : ['test', 'test'],
      ),
    );
  }
}

class PageTest3 extends StatefulWidget {
  const PageTest3({super.key});

  @override
  State<PageTest3> createState() => _PageTest3State();
}

class _PageTest3State extends State<PageTest3> {
  List<ModelTest> items = [
    ...[0, 1, 2, 3, 4].map(
      (e) => ModelTest(userName: 'Min hun $e', bio: 'Minh Hung socute'),
    )
  ];

  Future<List<ModelImageTest>> load(int index) async {
    await Future.delayed(const Duration(seconds: 3));
    return <ModelImageTest>[
      for (int i = 0; i < 3; i++)
        ModelImageTest(
          imageUrl:
              'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
          title: 'Id t${items[index].userName}',
          subTitle: 'This is product',
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionPanelCustom<ModelTest, List<ModelImageTest>>(
          parentItems: items,
          parentItemBuilder: (_, data, isExpanded) => Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            child: ListTile(
              title: Text(data.userName),
              subtitle: Text(data.bio),
            ),
          ),
          expandPanelColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0.0),
          bodyItem: (_, items) => Column(
            children: [
              ...items.map(
                (e) => Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(e.imageUrl),
                    ),
                  ),
                  child: Text(e.title, style: context.titleLarge),
                ),
              )
            ],
          ),
          loadBody: load,
        )
      ],
    );
  }
}

class PageTest2 extends StatefulWidget {
  const PageTest2({super.key});

  @override
  State<PageTest2> createState() => _PageTest2State();
}

class _PageTest2State extends State<PageTest2> {
  List<CategoryLayoutModel> categoryTest = <CategoryLayoutModel>[
    for (int i = 1; i <= 4; i++)
      CategoryLayoutModel(id: i.toString(), title: 'Category $i'),
  ];

  Future<List<ProductModel<ModelImageTest>>> fetchCategoryCall(
      List<CategoryLayoutModel> categoryIds) async {
    await Future.delayed(const Duration(seconds: 3));
    return <ProductModel<ModelImageTest>>[
      for (int i = 1; i <= 4; i++)
        for (int t = 0; t < i * 6; t++)
          ProductModel(
            data: ModelImageTest(
              imageUrl: ImageConst.baseImageView,
              title: 'Product t$t',
              subTitle: 'This is product $t of category i$i',
            ),
            categoryId: i.toString(),
          )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CategoryLayoutView<ModelImageTest>(
      hPadding: 10,
      vPadding: 10,
      categoryLayoutType: CategoryLayoutType.both,
      selectedTextStyle: context.titleSmall.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
      ),
      unselectedTextStyle: context.titleSmall.copyWith(
        // color: Theme.of(context).hintColor,
        fontSize: 11.0,
      ),
      // autoScrollCategoryStyle: const AutoScrollCategoryStyle(
      //   animatedDuration: 350,
      //   radius: 5.0,
      //   categoryItemHeight: 40,
      //   indicatorPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      // ),
      bothCategoryStyle: BothCategoryStyle(
        firstSiteColor: Theme.of(context).primaryColor,
        isGroupFormat: true,
      ),
      categoryLayoutModel: categoryTest,
      scrollFormat: const ScrollFormat(
        numberColumns: 3,
        mainSpacing: 10.0,
        crossSpacing: 10.0,
      ),
      itemCall: fetchCategoryCall,
      paginationDataCall: (currentPage, category) async {
        // log(category);
        await Future.delayed(const Duration(seconds: 3));
        return <ModelImageTest>[
          for (int t = 0; t < 6; t++)
            ModelImageTest(
              imageUrl: ImageConst.baseImageView,
              title: 'Product t$t',
              subTitle: 'This is product $t of category $category',
            ),
        ];
      },
      itemBuilder: (ModelImageTest data) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(data.imageUrl),
                ),
                // borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Text(
              data.title,
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              data.subTitle,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: Theme.of(context).hintColor,
              ),
            ),
          ]
              .expand((element) => [element, const SizedBox(height: 2.0)])
              .toList(),
        ),
      ),
      itemCategoryBuilder: (data) => const SizedBox(),
    );
  }
}

class PageTest1 extends StatefulWidget {
  const PageTest1({super.key});

  @override
  State<PageTest1> createState() => _PageTest1State();
}

class _PageTest1State extends State<PageTest1> {
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

  Future<List<ModelTest>> paginationCall(
    int currentPage,
    String category,
  ) async {
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
    return Column(
      children: [
        HeaderSearch(
          textStyle: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
          hintStyle: context.titleMedium.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 10.0),
        ProgressButton(
          call: () async {
            await Future.delayed(const Duration(seconds: 3));
            return true;
          },
          width: 300,
          isAnimation: true,
          textInside: 'Tap me',
          radius: 10.0,
        ),
        const SizedBox(height: 10.0),
        const LinearProgressIndicatorCustom(
          initData: 100,
          progressData: 70,
          isShowText: true,
          animationDuration: 2200,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          badgeIndicator: BadgeIndicatorStyle(radius: 25.0),
          radius: 5.0,
        ),
        const SizedBox(height: 20.0),
        const VideoPlayerUI(
          url:
              "https://sandbox.api.lettutor.com/video/af5df96e-53d4-433b-9f4a-59e736d05796video1641220103635.mp4",
          width: 200,
          height: 200,
          autoPlay: true,
        )
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: CustomTextField(
        //     isShowCancelIcon: true,
        //     isShowBorder: true,
        //     borderRadius: 10.0,
        //   ),
        // ),
        // const SizedBox(height: 30.0),
        // CategoryField(
        //   categoryType: CategoryType.selectedCategory, // => Change here
        //   selectedColor: Theme.of(context).primaryColor,
        //   numberColumn: 2,
        //   spacingItem: 15.0,
        //   marginLeft: 10.0,
        //   marginRight: 10.0,
        //   isIconOut: false,
        //   categoryGridFormat:
        //       const CategoryGridFormat(crossSpacing: 10.0, mainSpacing: 10.0),
        //   unselectedColor: Theme.of(context).hintColor,
        //   categoryTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
        //         fontWeight: FontWeight.w400,
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //   categories: <CategoryStyle>[
        //     ...listCategory.mapIndexed(
        //       (index, e) => CategoryStyle(
        //         isSelected: index == 0,
        //         text: e.title,
        //         typeImage: TypeImage.assetSvg,
        //         iconUrl: e.iconUrl,
        //         color: e.color,
        //         iconSize: 30,
        //         isIcon: e.isIconData,
        //         radius: 10,
        //         paddingBottom: 10.0,
        //         paddingRight: 15.0,
        //         paddingTop: 10.0,
        //         paddingLeft: 15.0,
        //         backgroundGradientColor: [
        //           "992195F3".toColor(),
        //           "112195F3".toColor()
        //         ],
        //         onPress: () {},
        //       ),
        //     )
        //   ],
        // ),
        // const SizedBox(height: 30.0),
        // const BannerSliderWidget(
        //   images: [
        //     'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
        //     'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
        //     'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
        //     'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg'
        //   ],
        // ),
        // ImageStackView(
        //   images: const [
        //     'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
        //     'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
        //     'https://imgv3.fotor.com/images/blog-richtext-image/part-blurry-image.jpg',
        //     'https://imgv3.fotor.com/images/blog-cover-image/Image-Upscaler-2.jpg'
        //   ],
        //   isAssetImage: false,
        //   itemsDisplay: 3,
        //   actionColor: Theme.of(context).scaffoldBackgroundColor,
        // ),
        // const SizedBox(height: 10.0),
        // Expanded(
        //   child: PaginationViewCustom<ModelTest>(
        //     paginationViewType: PaginationViewType.masonryGrid,
        //     paginationDataCall: paginationCall,
        //     physics: const AlwaysScrollableScrollPhysics(
        //       parent: BouncingScrollPhysics(),
        //     ),
        //     hPadding: 10,
        //     vPadding: 10,
        //     typeIndicatorLoading: TypeIndicatorLoading.skeltonIndicator,
        //     gridViewFormat: const GridViewFormat(
        //       crossAxisCount: 3,
        //     ),
        //     skeltonFormat: const SkeltonFormat(
        //       columns: [4, 1],
        //     ),
        //     limitFetch: 15,
        //     items: <ModelTest>[
        //       ModelTest(userName: 'Hung', bio: 'Nguyen Minh Hung'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //       ModelTest(userName: 'MinHun', bio: 'Minhungsocute'),
        //     ],
        //     itemBuilder: (BuildContext context, ModelTest data, int index) {
        //       return Container(
        //         height: index * 5 + 70, // support for masonry layout
        //         width: index * 1, // support for masonry layout
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).primaryColor,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Text(data.userName),
        //             Text(data.bio),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}


