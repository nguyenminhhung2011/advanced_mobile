import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_paint.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../constant/image_const.dart';
import 'field_tab_bar.dart';

// Animated tab style format
class AnimatedTabStyle {
  // width of top
  final double posWidth;
  // height of top
  final double posHeight;
  // icon Size
  final double iconSize;
  // Curve of animation with default is linear
  final Curve curves;
  const AnimatedTabStyle({
    this.posWidth = 70,
    this.posHeight = 15,
    this.iconSize = 50.0,
    this.curves = Curves.linear,
  });
}

class TabBarCustom extends StatefulWidget {
  // Default is card color
  final Color? tabBarColor;

  final Color? iconSelectedColor;
  final Color? usSelectedColor;
  // Support for dot tabBar
  final bool? isCircleDot;
  // Support for svg asset
  final bool isSvgIcon;
  // Support for Animated TabBar support for [circle, pyramid]
  final TabBarPainterType painterType;
  //Support style for Animated TabBar
  final AnimatedTabStyle animatedTabStyle;
  // Margin
  final double? hMargin;
  final double? vMargin;
  // Padding
  final double? hPadding;
  final double? vPadding;
  // elevation for shadow of tabBar
  final double? elevation;
  //Radius for shadow of tabBar
  final double blurShadowRadius;
  // Radius for tabBar and radius for animated tabBar{pyramid}
  final double? radius;
  // Format size and padding for icon
  final double iconSize;
  final double? paddingIcon;
  // list tabs
  final List<TabBarItemStyle> items;
  // Current support 4 types
  final TabBarType tabBarType;
  // Event change tab
  final Function(int) onChangeTab;
  // Duration for animation with default is 150 milSeconds
  final int duration;

  const TabBarCustom({
    super.key,
    this.tabBarColor,
    this.iconSelectedColor,
    this.isCircleDot,
    this.hMargin,
    this.vMargin,
    this.hPadding,
    this.vPadding,
    this.tabBarType = TabBarType.indicatorTabBar,
    this.painterType = TabBarPainterType.circle,
    this.animatedTabStyle = const AnimatedTabStyle(),
    this.isSvgIcon = true,
    this.duration = 150,
    this.iconSize = 25.0,
    this.blurShadowRadius = 5.0,
    this.radius,
    this.usSelectedColor,
    this.paddingIcon,
    this.elevation,
    required this.onChangeTab,
    required this.items,
  });

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom> {
  Color get iconSelectedColor =>
      widget.iconSelectedColor ?? Theme.of(context).primaryColor;
  Color get tabBarColor => widget.tabBarColor ?? Theme.of(context).cardColor;

  Color selectedColor(index) => _indexSelect.value == index
      ? iconSelectedColor
      : widget.usSelectedColor ?? tabBarColor.fontColorByBackground;
  double get elevation => widget.elevation != null
      ? widget.elevation! > 1
          ? 1
          : widget.elevation!
      : 0.1;

  final ValueNotifier<int> _indexSelect = ValueNotifier<int>(0);

  void _onTap(int index) {
    _indexSelect.value = index;
    widget.onChangeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox();
    }
    return switch (widget.tabBarType) {
      TabBarType.rowTabBar => _rowTabBar(),
      TabBarType.animationTabBar => _animationTabBar(),
      TabBarType.indicatorTabBar => _tabIndicatorTabBar(context),
      _ => _dotTabBar(context)
    };
  }

  Widget _rowTabBar() {
    final padding = Directionality.of(context) == TextDirection.ltr
        ? const EdgeInsets.only(left: 5, right: 10)
        : const EdgeInsets.only(left: 10, right: 5);
        
    return ValueListenableBuilder<int>(
      valueListenable: _indexSelect,
      builder: (context, indexSelect, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: widget.hPadding ?? 10.0,
            vertical: widget.vPadding ?? 10.0,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: widget.hMargin ?? 15.0,
            vertical: widget.vMargin ?? 15.0,
          ),
          decoration: BoxDecoration(
            color: tabBarColor,
            borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(elevation),
                blurRadius: widget.blurShadowRadius,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...widget.items.mapIndexed(
                (index, element) => TweenAnimationBuilder<double>(
                  tween: Tween(
                    end: indexSelect == index ? 1.0 : 0.0,
                  ),
                  duration: Duration(milliseconds: widget.duration),
                  builder: (context, t, _) {
                    return Material(
                      color: Color.lerp(
                        iconSelectedColor.withOpacity(0.0),
                        iconSelectedColor.withOpacity(0.3),
                        t,
                      ),
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 15.0),
                      child: InkWell(
                        customBorder: const StadiumBorder(),
                        focusColor: iconSelectedColor.withOpacity(0.4),
                        highlightColor: iconSelectedColor.withOpacity(0.4),
                        splashColor: iconSelectedColor.withOpacity(0.4),
                        hoverColor: iconSelectedColor.withOpacity(0.4),
                        onTap: () => _onTap(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: [
                              IconTheme(
                                data:
                                    IconThemeData(color: selectedColor(index)),
                                child: FollowIcon(
                                  iconData: element.iconData,
                                  svg: element.assetIcon,
                                  color: selectedColor(index),
                                  isSvg: widget.isSvgIcon,
                                  size: widget.iconSize,
                                ),
                              ),
                              ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  height: 20.0,
                                  child: Align(
                                    alignment: const Alignment(-0.3, 0),
                                    widthFactor: t,
                                    child: Padding(
                                      padding: padding,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: selectedColor(index),
                                        ),
                                        child: Text(element.title.toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _animationTabBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _indexSelect,
      builder: (context, indexSelect, child) {
        return LayoutBuilder(builder: (context, constraints) {
          final animatedWidth =
              (constraints.biggest.width - (widget.hMargin ?? 0)) /
                  widget.items.length;
          return Container(
            height:
                kBottomNavigationBarHeight + widget.animatedTabStyle.posHeight,
            width: double.infinity,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(
              horizontal: widget.hMargin ?? 0.0,
              vertical: widget.vMargin ?? 0.0,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: kBottomNavigationBarHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tabBarColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(widget.radius ?? 0.0),
                      // bottom: Radius.circular(widget.radius ?? 15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .shadowColor
                            .withOpacity(elevation),
                        blurRadius: widget.blurShadowRadius,
                        offset: const Offset(0, -10),
                      )
                    ],
                  ),
                ),
                AnimatedPositioned(
                  curve: widget.animatedTabStyle.curves,
                  duration: Duration(milliseconds: widget.duration),
                  left: animatedWidth * _indexSelect.value,
                  top: 0,
                  width: animatedWidth,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: widget.duration),
                    width: animatedWidth,
                    child: Center(
                      child: CustomPaint(
                        painter: TabBarPainter(
                          type: widget.painterType,
                          color: tabBarColor,
                        ),
                        size: Size(
                          widget.animatedTabStyle.posWidth,
                          widget.animatedTabStyle.posHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: widget.animatedTabStyle.curves,
                  duration: Duration(milliseconds: widget.duration),
                  bottom: 0.0,
                  left: animatedWidth * _indexSelect.value,
                  top: 0.0,
                  width: animatedWidth,
                  child: Center(
                    child: widget.painterType.isCircle
                        ? Container(
                            height: widget.animatedTabStyle.iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: iconSelectedColor.withOpacity(0.4),
                            ),
                          )
                        : Container(
                            width: widget.animatedTabStyle.posWidth * 0.85,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: iconSelectedColor),
                              color: iconSelectedColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                  ),
                ),
                Row(
                  children: [
                    ...widget.items.mapIndexed(
                      (index, e) => Expanded(
                        child: InkWell(
                          onTap: () => _onTap(index),
                          splashColor: Colors.transparent,
                          // borderRadius: BorderRadius.circular(100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: index == indexSelect
                                        ? widget.iconSelectedColor
                                        : tabBarColor.fontColorByBackground,
                                  ),
                                  child: FollowIcon(
                                    svg: e.assetIcon,
                                    size: widget.iconSize,
                                    iconData: e.iconData,
                                    isSvg: widget.isSvgIcon,
                                    color: selectedColor(index),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  FieldTabBar _dotTabBar(BuildContext context) {
    return FieldTabBar(
      elevation: elevation,
      hMargin: widget.hMargin,
      hPadding: widget.hPadding,
      tabBarColor: tabBarColor,
      vMargin: widget.vMargin,
      vPadding: widget.vPadding,
      child: ValueListenableBuilder<int>(
        valueListenable: _indexSelect,
        builder: (context, indexSelect, child) {
          return DefaultTabController(
            length: widget.items.length,
            child: TabBar(
              indicatorColor: widget.tabBarType.isTitleTabBar
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              tabs: <Widget>[
                ...widget.items.mapIndexed(
                  (index, e) => Padding(
                    padding: EdgeInsets.all(widget.paddingIcon ?? 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FollowIcon(
                          color: selectedColor(index),
                          iconData: e.iconData,
                          size: widget.iconSize,
                          svg: e.assetIcon,
                          isSvg: widget.isSvgIcon,
                        ),
                        if (widget.tabBarType.isTitleTabBar &&
                            indexSelect == index)
                          Text(
                            e.title,
                            maxLines: 1,
                            style: context.titleSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: iconSelectedColor,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
              labelColor: Colors.white,
              onTap: _onTap,
              indicator: widget.tabBarType.isDotTabBar
                  ? DotIndicator(
                      color: iconSelectedColor,
                      distanceFromCenter: 16,
                      radius: 2,
                      paintingStyle: PaintingStyle.fill,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Container _tabIndicatorTabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.hMargin ?? 10.0,
        vertical: widget.vMargin ?? 5.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding ?? 10.0,
        vertical: widget.vPadding ?? 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius ?? 15.0),
        color: tabBarColor,
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: _indexSelect,
        builder: (context, indexSelect, child) {
          return DefaultTabController(
            length: widget.items.length,
            child: TabBar(
              indicatorColor: iconSelectedColor,
              tabs: <Widget>[
                ...widget.items.mapIndexed(
                  (index, e) => Padding(
                    padding: EdgeInsets.all(widget.paddingIcon ?? 10.0),
                    child: FollowIcon(
                      color: selectedColor(index),
                      iconData: e.iconData,
                      svg: e.assetIcon,
                      isSvg: widget.isSvgIcon,
                      size: widget.iconSize,
                    ),
                  ),
                ),
              ],
              labelColor: Colors.white,
              onTap: _onTap,
              unselectedLabelColor: iconSelectedColor.withOpacity(0.2),
              indicator: RectangularIndicator(
                bottomLeftRadius: widget.radius ?? 10.0,
                bottomRightRadius: widget.radius ?? 10.0,
                topLeftRadius: widget.radius ?? 10.0,
                topRightRadius: widget.radius ?? 10.0,
                color: iconSelectedColor.withOpacity(0.3),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TabBarItemStyle {
  final String assetIcon;
  final String title;
  final Widget screen;
  final IconData iconData;
  TabBarItemStyle({
    this.assetIcon = ImageConst.homeIcon,
    this.title = 'Base title',
    this.screen = const SizedBox(),
    this.iconData = Icons.home,
  });
}

class FollowIcon extends StatelessWidget {
  final IconData iconData;
  final String svg;
  final double size;
  final bool isSvg;
  final Color color;

  const FollowIcon({
    super.key,
    this.iconData = Icons.home,
    this.svg = ImageConst.homeIcon,
    this.isSvg = true,
    this.size = 10,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(svg, color: color, width: size, height: size);
    }
    return Icon(iconData, size: size, color: color);
  }
}
