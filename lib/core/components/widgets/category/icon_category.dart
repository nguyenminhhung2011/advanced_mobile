import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/image_const.dart';
import '../image_custom.dart';
import 'category_custom.dart';

class IconCategory extends StatelessWidget {
  const IconCategory({
    super.key,
    required this.category,
  });

  final CategoryStyle category;

  @override
  Widget build(BuildContext context) {
    String imageUrl = category.iconUrl ??
        switch (category.typeImage) {
          TypeImage.assetImage => '', // add assets image,
          TypeImage.assetSvg => ImageConst.homeIcon,
          _ => ImageConst.baseImageView,
        };
    if (category.isIcon) {
      return Icon(
        category.iconWidget,
        color: category.color,
        size: category.iconSize,
      );
    }
    return category.typeImage == TypeImage.assetSvg
        ? SvgPicture.asset(
            imageUrl,
            color: category.color,
            width: category.iconSize,
            height: category.iconSize,
          )
        : ImageCustom(
            imageUrl: imageUrl,
            isNetworkImage: false,
            color: category.color,
            width: category.iconSize,
            height: category.iconSize,
          );
  }
}
