import 'package:flutter/material.dart';

import 'category_custom.dart';
import 'icon_category.dart';
import 'name_category.dart';

class CategoryItem extends StatelessWidget {
  final CategoryStyle category;
  final TextStyle categoryTextStyle;
  final bool isExpand;
  final bool isIconOut;
  const CategoryItem({
    super.key,
    required this.category,
    this.isIconOut = true,
    this.isExpand = false,
    required this.categoryTextStyle,
  });

  @override
  Widget build(BuildContext context) {
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
                ? category.iconUrl != null || category.iconWidget != null
                    ? IconCategory(category: category)
                    : const SizedBox()
                : Row(
                    children: [
                      if (category.iconUrl != null)
                        IconCategory(category: category),
                      isExpand
                          ? Expanded(
                              child: NameCategory(
                                category: category,
                                context: context,
                                textStyle: categoryTextStyle,
                              ),
                            )
                          : NameCategory(
                              category: category,
                              context: context,
                              textStyle: categoryTextStyle,
                            )
                    ],
                  ),
          ),
          if (isIconOut) ...[
            const SizedBox(height: 5.0),
            NameCategory(
              category: category,
              context: context,
              textStyle: categoryTextStyle,
            ),
          ]
        ],
      ),
    );
  }
}
