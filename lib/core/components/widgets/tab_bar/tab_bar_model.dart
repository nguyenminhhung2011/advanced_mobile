import 'package:flutter/material.dart';

import '../../constant/image_const.dart';

class TabBarModel{
  final IconData iconData;
  final String svgAsset;
  final String title;
  final Widget screen;
  TabBarModel({
    this.iconData = Icons.home,
    this.svgAsset = ImageConst.homeIcon,
    this.title = '',
    this.screen = const SizedBox(),
  });
}