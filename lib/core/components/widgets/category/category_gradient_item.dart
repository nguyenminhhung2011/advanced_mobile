import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/category/category_custom.dart';

class CategoryGradientItem extends StatelessWidget {
  final Widget? iconWidget;
  final Widget? nameWidget;
  final CategoryStyle e;
  final Color? selectedColor;
  final double width;
  final bool isRow;

  const CategoryGradientItem({
    super.key,
    this.iconWidget,
    this.nameWidget,
    this.width = 90.0,
    required this.e,
    this.selectedColor,
    this.isRow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: e.onPress,
      child: Container(
        width: width,
        padding: EdgeInsets.only(
          left: e.paddingLeft ?? 10.0,
          right: e.paddingRight ?? 10.0,
          top: e.paddingTop ?? 5.0,
          bottom: e.paddingBottom ?? 5.0,
        ),
        decoration: BoxDecoration(
          gradient: e.backgroundGradientColor != null && e.isSelected == false
              ? LinearGradient(
                  colors: e.backgroundGradientColor!,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: e.isSelected
              ? selectedColor ?? Theme.of(context).primaryColor
              : e.backgroundGradientColor != null
                  ? null
                  : Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(e.radius ?? 10.0),
          ),
          border: Border.all(
            width: 1.5,
            color: selectedColor ?? Theme.of(context).primaryColor,
          ),
        ),
        child: isRow
            ? Row(
                children: [
                  if (iconWidget != null) iconWidget!,
                  const SizedBox(width: 5.0),
                  if (nameWidget != null) nameWidget!,
                ],
              )
            : Column(
                children: [
                  if (iconWidget != null) iconWidget!,
                  const SizedBox(height: 15.0),
                  if (nameWidget != null) nameWidget!,
                ],
              ),
      ),
    );
  }
}
