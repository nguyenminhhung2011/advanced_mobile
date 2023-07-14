import 'package:flutter/material.dart';

class FieldTabBar extends StatelessWidget {
  final double? hMargin;
  final double? vMargin;
  final double? hPadding;
  final double? vPadding;
  final double? radius;
  final double elevation;
  final Widget child;
  final Color tabBarColor;

  const FieldTabBar({
    super.key,
    required this.child,
    required this.hMargin,
    required this.vMargin,
    required this.hPadding,
    required this.vPadding,
    required this.tabBarColor,
    this.radius,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: hMargin ?? 0.0,
        vertical: vMargin ?? 0.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPadding ?? 5.0,
        vertical: vPadding ?? 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? 15.0),
          topRight: Radius.circular(radius ?? 15.0),
        ),
        color: tabBarColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(elevation),
            blurRadius: 5.0,
            offset: const Offset(0, -10),
          )
        ],
      ),
      child: child,
    );
  }
}
