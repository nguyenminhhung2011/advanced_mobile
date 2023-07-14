// painter support for animation tabBar
import 'package:flutter/material.dart';

enum TabBarPainterType {
  circle,
  pyramid;

  bool get isCircle => this == TabBarPainterType.circle;
}

class TabBarPainter extends CustomPainter {
  final Color color;
  final TabBarPainterType type;
  TabBarPainter({
    required this.color,
    this.type = TabBarPainterType.circle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    Path path = Path();
    path.lineTo(0, size.height);
    if (type.isCircle ) {
      path.cubicTo(
          0, size.height, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width * 0.94, size.height, size.width * 0.83,
          size.height * 0.65, size.width * 0.72, size.height * 0.31);
      path.cubicTo(size.width * 0.67, size.height * 0.12, size.width * 0.59,
          size.height * 0.01, size.width * 0.51, 0);
      path.cubicTo(
          size.width * 0.51, 0, size.width * 0.51, 0, size.width * 0.51, 0);
      path.cubicTo(size.width * 0.42, -0.01, size.width * 0.34,
          size.height * 0.11, size.width * 0.27, size.height * 0.31);
      path.cubicTo(size.width * 0.17, size.height * 0.65, size.width * 0.06,
          size.height, 0, size.height);
      path.cubicTo(0, size.height, 0, size.height, 0, size.height);
      canvas.drawPath(path, paint);
    } else {
      paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
      final roundedRect = RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      );
      canvas.drawRRect(roundedRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
