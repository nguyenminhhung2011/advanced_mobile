import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../image_custom.dart';
import 'category_type.dart';

class CategoryGridFormat {
  final double mainSpacing;
  final double crossSpacing;

  const CategoryGridFormat({
    this.crossSpacing = 10,
    this.mainSpacing = 10,
  });
}

class CategoryField extends StatefulWidget {
  final CategoryType categoryType;
  final double? marginLeft;
  final double? marginRight;
  final double? marginTop;
  final double? marginBottom;
  final double? spacingItem;
  final int? numberColumn;
  final List<CategoryStyle> categories;
  final bool isCategoryIcon;
  final bool isIconOut;
  final Color? selectedColor;
  final Color? unselectedColor;
  final CategoryGridFormat categoryGridFormat;
  const CategoryField({
    super.key,
    this.marginLeft,
    this.marginRight,
    this.marginTop,
    this.marginBottom,
    this.isCategoryIcon = false,
    this.isIconOut = false,
    this.spacingItem = 5.0,
    this.categoryGridFormat = const CategoryGridFormat(),
    this.numberColumn,
    this.selectedColor,
    this.unselectedColor,
    required this.categoryType,
    required this.categories,
  });

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  int get numberColumn => widget.numberColumn ?? 1;
  @override
  Widget build(BuildContext context) {
    if (widget.categoryType.isExpandCategory) {
      return _expandedCategoryField();
    }
    if (widget.categoryType.isTextCategory) {
      return _textCategory(context);
    }
    if (widget.categoryType.isSelectedCategory) {
      return _selectedCategory(context);
    }
    return _listCategory();
  }

  Padding _listCategory() {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.marginTop ?? 0.0,
        right: widget.marginRight ?? 0.0,
        bottom: widget.marginBottom ?? 0.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: widget.marginLeft ?? 0.0),
            ...widget.categories
                .map(
                  (e) => CategoryItem(category: e, isIconOut: widget.isIconOut),
                )
                .expand(
                  (element) =>
                      [element, SizedBox(width: widget.spacingItem ?? 5.0)],
                )
                .toList()
              ..removeLast()
          ],
        ),
      ),
    );
  }

  Padding _selectedCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: widget.marginRight ?? 0.0,
        top: widget.marginTop ?? 0.0,
        bottom: widget.marginBottom ?? 0.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: widget.marginLeft ?? 0.0),
            ...widget.categories
                .map(
                  (e) => GestureDetector(
                    onTap: e.onPress,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: e.paddingLeft ?? 10.0,
                        right: e.paddingRight ?? 10.0,
                        top: e.paddingTop ?? 5.0,
                        bottom: e.paddingBottom ?? 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: e.isSelected
                            ? widget.selectedColor ??
                                Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(e.radius ?? 10.0),
                        ),
                        border: Border.all(
                          width: 1.5,
                          color: widget.selectedColor ??
                              Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconCategory(category: e),
                          const SizedBox(width: 5.0),
                          NameCategory(category: e, context: context),
                        ],
                      ),
                    ),
                  ),
                )
                .expand(
                  (element) => [
                    element,
                    SizedBox(width: widget.spacingItem ?? 10.0),
                  ],
                )
          ],
        ),
      ),
    );
  }

  Padding _textCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.marginTop ?? 0.0,
        right: widget.marginRight ?? 0.0,
        left: widget.marginLeft ?? 0.0,
        bottom: widget.marginBottom ?? 15.0,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.categories
              .map(
                (e) => GestureDetector(
                  onTap: e.onPress,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        e.text,
                        style: e.textStyle!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: e.isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      _dotAnimated(e.isSelected),
                    ],
                  ),
                ),
              )
              .toList()
              .expand((element) =>
                  [element, SizedBox(width: widget.spacingItem ?? 5.0)])
              .toList(),
        ),
      ),
    );
  }

  Container _expandedCategoryField() {
    int maxCountPerRow = (widget.categories.length / numberColumn).ceil();
    return Container(
      margin: EdgeInsets.only(
        top: widget.marginTop ?? 0.0,
        right: widget.marginRight ?? 0.0,
        left: widget.marginLeft ?? 0.0,
        bottom: widget.marginBottom ?? 0.0,
      ),
      child: Column(
        children: List.generate(
          numberColumn,
          (indexC) {
            int startRowIndex = indexC;
            return Row(
              children: List.generate(
                maxCountPerRow,
                (indexR) {
                  int index = indexR + (startRowIndex * maxCountPerRow);
                  return Expanded(
                    child: index < widget.categories.length
                        ? CategoryItem(
                            category: widget.categories[
                                indexR + (startRowIndex * maxCountPerRow)],
                            isIconOut: widget.isIconOut,
                            isExpand: widget.categoryType.isExpandCategory,
                          )
                        : const SizedBox(),
                  );
                },
              )
                  .expand((element) => [
                        element,
                        SizedBox(width: widget.categoryGridFormat.crossSpacing)
                      ])
                  .toList()
                ..removeLast(),
            );
          },
        )
            .expand((element) => [
                  element,
                  SizedBox(
                    height: widget.categoryGridFormat.mainSpacing,
                  )
                ])
            .toList()
          ..removeLast(),
      ),
    );
  }

  Widget _dotAnimated(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 6.0 : 0.0,
      height: 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryStyle category;
  final bool isExpand;
  final bool isIconOut;
  const CategoryItem({
    super.key,
    required this.category,
    this.isIconOut = true,
    this.isExpand = false,
  });

  @override
  Widget build(BuildContext context) {
    // if (isIconOut) {
    return GestureDetector(
      onTap: category.onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
              right: category.paddingRight ?? 10.0,
              left: category.paddingLeft ?? 10.0,
              top: category.paddingTop ?? 5.0,
              bottom: category.paddingBottom ?? 5.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(category.radius ?? 10.0),
              color: category.color?.withOpacity(0.1) ??
                  Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: (isIconOut)
                ? category.icon != null || category.iconWidget != null
                    ? IconCategory(category: category)
                    : const SizedBox()
                : Row(
                    children: [
                      if (category.icon != null)
                        IconCategory(category: category),
                      isExpand
                          ? Expanded(
                              child: NameCategory(
                                  category: category, context: context),
                            )
                          : NameCategory(category: category, context: context)
                    ],
                  ),
          ),
          if (isIconOut) ...[
            const SizedBox(height: 5.0),
            NameCategory(category: category, context: context),
          ]
        ],
      ),
    );
  }
}

class IconCategory extends StatelessWidget {
  const IconCategory({
    super.key,
    required this.category,
  });

  final CategoryStyle category;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        category.icon!,
        color: category.color,
        width: category.iconSize,
        height: category.iconSize,
      );
  //  category.isIcon
  //     ? Icon(
  //         category.iconWidget,
  //         color: category.color,
  //         size: category.iconSize,
  //       )
  //     : ImageCustom(
  //         imageUrl: category.icon!,
  //         isNetworkImage: false,
  //         color: category.color,
  //         width: category.iconSize,
  //         height: category.iconSize,
  //       );
}

class NameCategory extends StatelessWidget {
  const NameCategory({
    super.key,
    required this.category,
    required this.context,
  });

  final CategoryStyle category;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(
      category.text,
      style: category.textStyle ??
          context.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}

class CategoryStyle {
  final String text;
  final String? icon;
  final Color? color;
  final double? radius;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? iconSize;
  final double? paddingBottom;
  final TextStyle? textStyle;
  final Function() onPress;
  final bool isSelected;
  final bool isIcon;
  final IconData? iconWidget;
  CategoryStyle({
    required this.text,
    required this.onPress,
    this.color,
    this.icon,
    this.radius,
    this.textStyle,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.iconSize,
    this.isSelected = false,
    this.isIcon = false,
    this.iconWidget,
  });
}
