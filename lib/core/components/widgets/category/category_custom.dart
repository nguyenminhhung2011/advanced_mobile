import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'category_item.dart';
import 'category_type.dart';
import 'icon_category.dart';
import 'name_category.dart';

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
  final TextStyle? categoryTextStyle;
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
    this.categoryTextStyle,
    required this.categoryType,
    required this.categories,
  });

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  int get numberColumn => widget.numberColumn ?? 1;

  TextStyle get categoryTextStyle =>
      widget.categoryTextStyle ??
      context.titleSmall.copyWith(
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      );
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
                  (e) => CategoryItem(
                    category: e,
                    isIconOut: widget.isIconOut,
                    categoryTextStyle: categoryTextStyle,
                  ),
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
                          NameCategory(
                            category: e,
                            context: context,
                            textStyle: categoryTextStyle,
                          ),
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
          mainAxisSize: MainAxisSize.min,
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
                        style: categoryTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: e.isSelected
                              ? widget.selectedColor
                              : widget.unselectedColor,
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
                            categoryTextStyle: categoryTextStyle,
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
        color: widget.selectedColor,
      ),
    );
  }
}

enum TypeImage { assetImage, assetSvg, networkImage }

class CategoryStyle {
  final String text;
  final String? iconUrl;
  final Color? color;
  final double? radius;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? iconSize;
  final double? paddingBottom;
  final Function() onPress;
  final bool isSelected;
  final bool isIcon;
  final TypeImage typeImage;
  final IconData? iconWidget;
  CategoryStyle({
    required this.text,
    required this.onPress,
    this.color,
    this.iconUrl,
    this.radius,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.iconSize,
    this.isSelected = false,
    this.isIcon = false,
    this.typeImage = TypeImage.assetImage,
    this.iconWidget,
  });
}
