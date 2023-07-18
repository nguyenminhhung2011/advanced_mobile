import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category_layout/category_layout.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

class AutoScrollCategoryStyle {
  final bool isScrollable;
  final double radius;
  final Color? selectColor;
  final double categoryItemHeight;
  final ScrollPhysics physics;
  final ScrollPhysics scrollPhysics;
  final EdgeInsets indicatorPadding;
  final EdgeInsets categoryPadding;
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

class CategoryLayoutView<T> extends StatefulWidget {
  final CategoryLayoutType categoryLayoutType;
  final List<CategoryLayoutModel> categoryLayoutModel;
  final double hPadding;
  final double vPadding;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final AutoScrollCategoryStyle autoScrollCategoryStyle;
  const CategoryLayoutView({
    super.key,
    this.hPadding = 10.0,
    this.vPadding = 10.0,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.autoScrollCategoryStyle = const AutoScrollCategoryStyle(),
    this.categoryLayoutType = CategoryLayoutType.autoScroll,
    required this.categoryLayoutModel,
  });

  @override
  State<CategoryLayoutView<T>> createState() => _CategoryLayoutViewState<T>();
}

class _CategoryLayoutViewState<T> extends State<CategoryLayoutView<T>>
    with SingleTickerProviderStateMixin {
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

  void _itemScrollListener() {}

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

  void onTabChange() async{
    autoScroll(30);
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
    if (widget.categoryLayoutType.isAutoScroll) {
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.vPadding,
          horizontal: widget.hPadding,
        ),
        child: _autoScrollCategory(),
      );
    }
    return const Placeholder();
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
          onTap: (value) => onTabChange(),
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
            itemCount: 50,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.only(bottom: 10.0),
                width: double.infinity,
                child: Center(child: Text(index.toString())),
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
