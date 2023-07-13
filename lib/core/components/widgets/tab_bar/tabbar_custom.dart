// ignore_for_file: deprecated_member_use

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_paint.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../constant/image_const.dart';
import 'field_tab_bar.dart';

class AnimatedTabStyle {
  final double posWidth;
  final double posHeight;
  final double iconSize;
  final Curve curves;
  const AnimatedTabStyle({
    this.posWidth = 70,
    this.posHeight = 15,
    this.iconSize = 50.0,
    this.curves = Curves.linear,
  });
}

class TabBarCustom extends StatefulWidget {
  final Color? tabBarColor;
  final Color? iconColor;
  final Color? usSelectedColor;
  final bool? isCircleDor;
  final TabBarPainterType painterType;
  final AnimatedTabStyle animatedTabStyle;
  final double? hMargin;
  final double? vMargin;
  final double? hPadding;
  final double? vPadding;
  final double? elevation;
  final double? radius;
  final double? paddingIcon;
  final List<TabBarItemStyle> items;
  final TabBarType tabBarType;
  final Function(int) onChangeTab;
  final int duration;

  const TabBarCustom({
    super.key,
    this.tabBarColor,
    this.iconColor,
    this.isCircleDor,
    this.hMargin,
    this.vMargin,
    this.hPadding,
    this.vPadding,
    this.tabBarType = TabBarType.indicatorTabBar,
    this.painterType = TabBarPainterType.circle,
    this.animatedTabStyle = const AnimatedTabStyle(),
    this.duration = 150,
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
  Color get iconColor => widget.iconColor ?? Theme.of(context).primaryColor;
  Color get tabBarColor => widget.tabBarColor ?? Theme.of(context).cardColor;

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
    if (widget.tabBarType.isRowTabBar) {
      return _rowTabBar();
    }
    if (widget.tabBarType.isAnimationTabBar) {
      return _animationTabBar();
    }
    if (widget.tabBarType.isIndicatorTabBar) {
      return _tabIndicatorTabBar(context);
    }
    // if (widget.tabBarType.isDotTabBar) {
    return _dotTabBar(context);
  }

  Widget _rowTabBar() {
    return ValueListenableBuilder<int>(
      valueListenable: _indexSelect,
      builder: (context, indexSelect, child) {
        Color selectedColor(index) => indexSelect == index
            ? iconColor
            : widget.usSelectedColor ?? tabBarColor.fontColorByBackground;
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
                blurRadius: 5.0,
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
                        iconColor.withOpacity(0.0),
                        iconColor.withOpacity(0.3),
                        t,
                      ),
                      borderRadius:
                          BorderRadius.circular(widget.radius ?? 15.0),
                      child: InkWell(
                        customBorder: const StadiumBorder(),
                        focusColor: iconColor.withOpacity(0.4),
                        highlightColor: iconColor.withOpacity(0.4),
                        splashColor: iconColor.withOpacity(0.4),
                        hoverColor: iconColor.withOpacity(0.4),
                        onTap: () => _onTap(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            children: [
                              IconTheme(
                                data:
                                    IconThemeData(color: selectedColor(index)),
                                child: SvgPicture.asset(
                                  element.assetIcon ?? ImageConst.homeIcon,
                                  color: selectedColor(index),
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
                                      padding: Directionality.of(context) ==
                                              TextDirection.ltr
                                          ? const EdgeInsets.only(
                                              left: 5,
                                              right: 10,
                                            )
                                          : const EdgeInsets.only(
                                              left: 10,
                                              right: 5,
                                            ),
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
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
                        blurRadius: 5.0,
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
                              color: iconColor.withOpacity(0.4),
                            ),
                          )
                        : Container(
                            width: widget.animatedTabStyle.posWidth * 0.85,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: iconColor),
                              color: iconColor.withOpacity(0.4),
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
                          borderRadius: BorderRadius.circular(100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: index == indexSelect
                                        ? widget.iconColor
                                        : tabBarColor.fontColorByBackground,
                                  ),
                                  child: SvgPicture.asset(
                                    e.assetIcon ?? ImageConst.homeIcon,
                                    color: indexSelect == index
                                        ? iconColor
                                        : widget.usSelectedColor ??
                                            tabBarColor.fontColorByBackground,
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
                        SvgPicture.asset(
                          e.assetIcon ?? ImageConst.homeIcon,
                          color: indexSelect == index
                              ? iconColor
                              : widget.usSelectedColor ??
                                  tabBarColor.fontColorByBackground,
                        ),
                        if (widget.tabBarType.isTitleTabBar &&
                            indexSelect == index)
                          Text(
                            e.title ?? '',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: iconColor,
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
                      color: iconColor,
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
              indicatorColor: iconColor,
              tabs: <Widget>[
                ...widget.items.mapIndexed((index, e) => Padding(
                      padding: EdgeInsets.all(widget.paddingIcon ?? 10.0),
                      child: SvgPicture.asset(
                        e.assetIcon ?? ImageConst.homeIcon,
                        color: indexSelect == index
                            ? iconColor
                            : widget.usSelectedColor ??
                                tabBarColor.fontColorByBackground,
                      ),
                    )),
              ],
              labelColor: Colors.white,
              onTap: _onTap,
              unselectedLabelColor: iconColor.withOpacity(0.2),
              indicator: RectangularIndicator(
                bottomLeftRadius: widget.radius ?? 10.0,
                bottomRightRadius: widget.radius ?? 10.0,
                topLeftRadius: widget.radius ?? 10.0,
                topRightRadius: widget.radius ?? 10.0,
                color: iconColor.withOpacity(0.3),
              ),
            ),
          );
        },
      ),
    );
  }

  AnimatedPositioned _animatedPositioned(Widget child, double animatedWidth) {
    return AnimatedPositioned(
      curve: Curves.linear,
      duration: Duration(milliseconds: widget.duration),
      bottom: 0.0,
      left: animatedWidth * _indexSelect.value,
      top: 0.0,
      width: animatedWidth,
      child: child,
    );
  }
}

class TabBarItemStyle {
  final String? assetIcon;
  final String? title;
  final Widget? screen;
  final Widget? widgetIcon;
  TabBarItemStyle({
    this.assetIcon,
    this.title,
    this.screen,
    this.widgetIcon,
  });
}

class FollowIcon extends StatelessWidget {
  final IconData iconData;
  final String svg;
  final bool isSvg;

  const FollowIcon({
    super.key,
    this.iconData = Icons.home,
    this.svg = ImageConst.homeIcon,
    this.isSvg = true,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
