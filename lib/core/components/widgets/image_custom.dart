import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';

class ImageCustom extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final bool isNetworkImage;
  final Color? color;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  const ImageCustom({
    super.key,
    this.fit,
    this.width,
    this.color,
    this.radius,
    this.height,
    this.loadingWidget,
    this.errorWidget,
    required this.imageUrl,
    required this.isNetworkImage,
  });

  double get _width => width ?? 50.0;

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        width: _width,
        height: _width,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (_, __, ____) =>
            errorWidget ??
            Image.network(ImageConst.baseImageView,
                width: _width, height: _width, fit: BoxFit.cover),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ??
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
        },
      );
    }
    return Image.asset(
      imageUrl,
      width: width ?? 50.0,
      height: width ?? 50.0,
      fit: BoxFit.cover,
      color: color,
    );
  }
}
