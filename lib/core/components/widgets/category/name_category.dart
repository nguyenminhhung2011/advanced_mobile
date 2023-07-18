import 'package:flutter/material.dart';

import 'category_custom.dart';

class NameCategory extends StatelessWidget {
  const NameCategory({
    super.key,
    required this.category,
    required this.context,
    required this.textStyle,
  });

  final CategoryStyle category;
  final BuildContext context;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(category.text, style: textStyle);
  }
}
