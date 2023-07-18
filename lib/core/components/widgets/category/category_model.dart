
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';

import 'category_custom.dart';

class CategoryModel{
  final String iconUrl;
  final String title;
  final TypeImage typeImage;
  final IconData iconData;
  final double iconSize;
  final Color color;
  final bool isIconData;
  CategoryModel({
    this.title = 'Base title',
    this.color = Colors.red, 
    this.iconUrl = ImageConst.homeIcon, 
    this.typeImage = TypeImage.assetImage,
    this.iconData = Icons.home, 
    this.iconSize = 20, 
    this.isIconData = false,
  });
}