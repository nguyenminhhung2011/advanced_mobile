import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category_layout/category_layout_notifier.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_notifier.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../generated/l10n.dart';
import 'category_layout_type.dart';

class CategoryLayoutModel {
  final String id;
  final String imageUrl;
  final String title;
  CategoryLayoutModel({
    required this.id,
    required this.title,
    this.imageUrl = ImageConst.baseImageView,
  });
}

class ProductModel<T> {
  final T data;
  final String categoryId;
  ProductModel({
    required this.data,
    required this.categoryId,
  });
}

// Style support for AutoScroll
class AutoScrollCategoryStyle {
  final bool isScrollable;
  final double radius;
  final Color? selectColor;
  final double categoryItemHeight;
  // scroll category physics
  final ScrollPhysics physics;
  // scroll item physics
  final ScrollPhysics scrollPhysics;
  final EdgeInsets indicatorPadding;
  final EdgeInsets categoryPadding;
  // animation default 300
  final int animatedDuration;
  final BoxBorder? border;
  const AutoScrollCategoryStyle({
    this.selectColor,
    this.radius = 10.0,
    this.border,
    this.isScrollable = true,
    this.animatedDuration = 300, // milliSeconds
    this.categoryItemHeight = 45.0,
    this.physics = const BouncingScrollPhysics(),
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.indicatorPadding = const EdgeInsets.all(0.0),
    this.categoryPadding = const EdgeInsets.all(10.0),
  });
}

// Style support for both
class BothCategoryStyle {
  final Color? secondSiteColor;
  final Color? firstSiteColor;
  final double? hPaddingSecondSite;
  final double? vPaddingSecondSite;
  final ScrollPhysics? physics;
  const BothCategoryStyle({
    this.hPaddingSecondSite,
    this.vPaddingSecondSite,
    this.secondSiteColor,
    this.firstSiteColor,
    this.physics,
  });
}

class ScrollFormat {
  final int numberColumns;
  final double mainSpacing;
  final double crossSpacing;
  final int limitFetch;
  const ScrollFormat({
    this.limitFetch = 10,
    this.numberColumns = 2,
    this.mainSpacing = 10.0,
    this.crossSpacing = 10.0,
  });
}

typedef CategoryItemData<T> = Future<List<ProductModel<T>>> Function(
    List<CategoryLayoutModel> categoryIds);

class CategoryLayoutView<T> extends StatefulWidget {
  // current support for auto scroll layout
  final CategoryLayoutType categoryLayoutType;
  // Call when fetch data
  final CategoryItemData<T> itemCall;
  // Padding
  final double hPadding;
  final double vPadding;
  //Pagination call support for pull to load more
  final PaginationData<T>? paginationDataCall;
  // Style format
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  // Style support for auto scroll layout
  final AutoScrollCategoryStyle autoScrollCategoryStyle;
  final List<CategoryLayoutModel> categoryLayoutModel;
  final ScrollFormat scrollFormat;
  final BothCategoryStyle bothCategoryStyle;
  // Setup widget for item
  final Widget Function(T data) itemBuilder;
  final Widget Function(CategoryLayoutModel data)? itemCategoryBuilder;
  final Function(String categoryId)? seeAllCall;
  const CategoryLayoutView({
    super.key,
    this.seeAllCall,
    this.hPadding = 10.0,
    this.vPadding = 10.0,
    required this.itemCall,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.itemCategoryBuilder,
    this.paginationDataCall,
    this.bothCategoryStyle = const BothCategoryStyle(),
    required this.itemBuilder,
    required this.categoryLayoutModel,
    this.scrollFormat = const ScrollFormat(),
    this.categoryLayoutType = CategoryLayoutType.autoScroll,
    this.autoScrollCategoryStyle = const AutoScrollCategoryStyle(),
  });

  @override
  State<CategoryLayoutView<T>> createState() => _CategoryLayoutViewState<T>();
}

class _CategoryLayoutViewState<T> extends State<CategoryLayoutView<T>>
    with SingleTickerProviderStateMixin {
  bool isAutoScroll = true;
  CategoryLayoutNotifier<T>? _categoryLayoutNotifier;
  // Auto scroll group
  TabController? _tabController;
  ItemScrollController? _itemScrollController;
  ItemPositionsListener? _itemPositionsListener;

  // Support for pagination
  PaginationNotifier<T>? _paginationNotifier;

  //Style
  TextStyle get selectedTextStyle =>
      widget.selectedTextStyle ??
      context.titleMedium.copyWith(fontWeight: FontWeight.w500);
  TextStyle get unselectedTextStyle =>
      widget.unselectedTextStyle ??
      context.titleSmall.copyWith(
        fontWeight: FontWeight.w500,
        color: Theme.of(context).hintColor,
      );

  @override
  void initState() {
    super.initState();
    if (widget.categoryLayoutType.isAutoScroll) {
      _categoryLayoutNotifier = CategoryLayoutNotifier([], widget.itemCall)
        ..fetchProductItem(
          widget.categoryLayoutModel,
          isAuto: widget.categoryLayoutType.isAutoScroll,
          numberColumn: widget.scrollFormat.numberColumns,
        );
      _tabController = TabController(
        animationDuration: Duration(
          milliseconds: widget.autoScrollCategoryStyle.animatedDuration,
        ),
        length: widget.categoryLayoutModel.length,
        vsync: this,
      );
      _itemScrollController = ItemScrollController();
      _itemPositionsListener = ItemPositionsListener.create();
      _itemPositionsListener!.itemPositions.addListener(_itemScrollListener);
    } else if (widget.categoryLayoutType.isBoth) {
      if (widget.categoryLayoutModel.isNotEmpty) {
        _paginationNotifier = PaginationNotifier<T>(
          widget.paginationDataCall ?? (p0, category) async => <T>[],
          [],
          category: widget.categoryLayoutModel.first.id,
        )..refreshItems(
            widget.scrollFormat.limitFetch,
          ); //

        _categoryLayoutNotifier = CategoryLayoutNotifier([], widget.itemCall)
          ..onSelectedCategory(
            widget.categoryLayoutModel.isNotEmpty
                ? widget.categoryLayoutModel.first
                : null,
          );
      }
    }
  }

  void _itemScrollListener() async {
    final indices = _itemPositionsListener!.itemPositions.value
        .where(
          (element) {
            final isTopVisible = element.itemLeadingEdge >= 0;
            return isTopVisible;
          },
        )
        .map((e) => e.index)
        .toList();
    // ignore: avoid_print
    print(indices);
    if (indices.isNotEmpty && isAutoScroll) {
      _tabController!.animateTo(indices.first);
    }
  }

  Future autoScroll(
    int index,
  ) async {
    if (_itemScrollController == null) {
      return;
    }
    await _itemScrollController!.scrollTo(
      index: index,
      alignment: 0,
      duration: Duration(
        milliseconds: widget.autoScrollCategoryStyle.animatedDuration,
      ),
    );
  }

  void onTabChange(int index) async {
    isAutoScroll = false;
    await autoScroll(index);
    isAutoScroll = true;
  }

  Future onTabBothChange(CategoryLayoutModel newCategory) async {
    if (_categoryLayoutNotifier == null ||
        (_categoryLayoutNotifier?.loading ?? false)) {
      return;
    }
    _categoryLayoutNotifier!.onSelectedCategory(newCategory);
    _paginationNotifier!.category = newCategory.id;
    _paginationNotifier!.refreshItems(widget.scrollFormat.limitFetch);
  }

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    if (_itemPositionsListener != null) {
      _itemPositionsListener!.itemPositions.removeListener(_itemScrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _categoryLayoutNotifier!,
      child: Consumer<CategoryLayoutNotifier<T>>(
        builder: (context, modal, _) {
          if (widget.categoryLayoutType.isAutoScroll) {
            return _autoScrollCategory();
          }
          if (widget.categoryLayoutType.isBoth) {
            return _bothCategory();
          }
          return const Placeholder();
        },
      ),
    );
  }

  Row _bothCategory() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: widget.bothCategoryStyle.firstSiteColor ??
                Theme.of(context).cardColor,
            child: ListView(
              children: [
                ...widget.categoryLayoutModel.map(
                  (e) {
                    final isSelected =
                        _categoryLayoutNotifier!.categorySelected!.id == e.id;
                    final categoryStyle =
                        isSelected ? selectedTextStyle : unselectedTextStyle;
                    final categoryColor = isSelected
                        ? widget.bothCategoryStyle.secondSiteColor ??
                            Theme.of(context).scaffoldBackgroundColor
                        : Colors.transparent;
                    return InkWell(
                      onTap: () => onTabBothChange(e),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 20.0,
                        ),
                        decoration: BoxDecoration(color: categoryColor),
                        child: Text(e.title, style: categoryStyle),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color:
                widget.bothCategoryStyle.secondSiteColor ?? Colors.transparent,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Theme.of(context).shadowColor.withOpacity(0.3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10.0),
                      Text(
                        _categoryLayoutNotifier!.categorySelected?.title ?? '',
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => widget.seeAllCall!(
                            _categoryLayoutNotifier!.categorySelected!.id),
                        child: Text(
                          S.of(context).seeMore,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: _paginationField()),
              ]
                  .expand((element) => [const SizedBox(height: 10.0), element])
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  PaginationViewCustom<dynamic> _paginationField() {
    return PaginationViewCustom<T>(
      paginationViewType: PaginationViewType.list,
      physics: widget.bothCategoryStyle.physics ??
          const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
      hPadding: widget.bothCategoryStyle.hPaddingSecondSite ?? 10.0,
      vPadding: widget.bothCategoryStyle.vPaddingSecondSite ?? 0.0,
      paginationNotifier: _paginationNotifier,
      initWidget: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
      typeIndicatorLoading: TypeIndicatorLoading.skeltonIndicator,
      skeltonFormat: const SkeltonFormat(
        columns: [1],
        height: 80.0,
        padding: EdgeInsets.all(0.0),
        countable: 3,
      ),
      paginationDataCall:
          widget.paginationDataCall ?? (currentPage, category) async => <T>[],
      items: const [],
      itemBuilder: (context, data, index) => widget.itemBuilder(data),
    );
  }

  Column _autoScrollCategory() {
    final decoration = BoxDecoration(
      border: widget.autoScrollCategoryStyle.border ??
          Border.all(width: 1, color: Theme.of(context).primaryColor),
      borderRadius:
          BorderRadius.circular(widget.autoScrollCategoryStyle.radius),
      color: widget.autoScrollCategoryStyle.selectColor ??
          Theme.of(context).primaryColor,
    );
    return Column(
      children: [
        TabBar(
          onTap: (value) => onTabChange(value),
          padding: widget.autoScrollCategoryStyle.categoryPadding,
          indicatorPadding: widget.autoScrollCategoryStyle.indicatorPadding,
          indicatorSize: TabBarIndicatorSize.tab,
          physics: widget.autoScrollCategoryStyle.physics,
          splashBorderRadius:
              BorderRadius.circular(widget.autoScrollCategoryStyle.radius),
          controller: _tabController,
          isScrollable: widget.autoScrollCategoryStyle.isScrollable,
          unselectedLabelStyle: unselectedTextStyle,
          unselectedLabelColor: unselectedTextStyle.color,
          labelStyle: selectedTextStyle,
          splashFactory: NoSplash.splashFactory,
          labelColor: selectedTextStyle.color,
          indicator: decoration,
          tabs: widget.categoryLayoutModel
              .map(
                (e) => Tab(
                  text: e.title,
                  height: widget.autoScrollCategoryStyle.categoryItemHeight,
                ),
              )
              .toList(),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
            physics: widget.autoScrollCategoryStyle.scrollPhysics,
            itemCount: _categoryLayoutNotifier?.countItem ?? 0,
            itemBuilder: (context, index) {
              final categoryId = _categoryLayoutNotifier!
                  .autoScrollItems.entries
                  .elementAt(index)
                  .key
                  .toString();
              final items = _categoryLayoutNotifier!.autoScrollItems.entries
                  .elementAt(index)
                  .value;
              final categoryModel = widget.categoryLayoutModel
                  .firstWhere((e) => e.id == categoryId);
              final scrollFormat = widget.scrollFormat;

              final maxCountPerRow =
                  (items.length / scrollFormat.numberColumns).ceil();
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryModel.title,
                          style: context.titleMedium,
                        ),
                        TextButton(
                          onPressed: () => widget.seeAllCall!(categoryId),
                          child: Text(
                            S.of(context).seeMore,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.hPadding,
                      vertical: widget.vPadding,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: List.generate(
                        maxCountPerRow,
                        (indexC) {
                          int startRowIndex = indexC;
                          return Row(
                            children: List.generate(
                              scrollFormat.numberColumns,
                              (indexR) {
                                int index = indexR +
                                    (startRowIndex *
                                        scrollFormat.numberColumns);
                                return Expanded(
                                  child: index < items.length
                                      ? widget.itemBuilder(items[index])
                                      : const SizedBox(),
                                );
                              },
                            )
                                .expand((element) => [
                                      element,
                                      SizedBox(width: scrollFormat.crossSpacing)
                                    ])
                                .toList()
                              ..removeLast(),
                          );
                        },
                      )
                          .expand((element) => [
                                element,
                                SizedBox(height: scrollFormat.mainSpacing)
                              ])
                          .toList()
                        ..removeLast(),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              );
            },
            itemPositionsListener: _itemPositionsListener,
            itemScrollController: _itemScrollController,
          ),
        )
      ],
    );
  }
}
