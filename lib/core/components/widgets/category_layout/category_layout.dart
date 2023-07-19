
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category_layout/category_layout_notifier.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

class ScrollFormat {
  final int numberColumns;
  final double mainSpacing;
  final double crossSpacing;
  const ScrollFormat({
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
  // Style format
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  // Style support for auto scroll layout
  final AutoScrollCategoryStyle autoScrollCategoryStyle;
  final List<CategoryLayoutModel> categoryLayoutModel;
  final ScrollFormat scrollFormat;
  // Setup widget for item
  final Widget Function(T data) itemBuilder;
  final Widget Function(CategoryLayoutModel data)? itemCategoryBuilder;
  const CategoryLayoutView({
    super.key,
    required this.itemCall,
    this.hPadding = 10.0,
    this.vPadding = 10.0,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.itemCategoryBuilder,
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
            milliseconds: widget.autoScrollCategoryStyle.animatedDuration),
        length: widget.categoryLayoutModel.length,
        vsync: this,
      );
      _itemScrollController = ItemScrollController();
      _itemPositionsListener = ItemPositionsListener.create();
      _itemPositionsListener!.itemPositions.addListener(_itemScrollListener);
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
          if (modal.items.isEmpty && modal.loading) {
            return const SizedBox();
          }
          if (widget.categoryLayoutType.isAutoScroll) {
            return _autoScrollCategory();
          }
          return const Placeholder();
        },
      ),
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
                    child: Text(
                      categoryModel.title,
                      style: context.titleMedium,
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
