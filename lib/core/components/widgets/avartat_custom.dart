import 'package:flutter/material.dart';
import 'package:lettutor/core/components/constant/image_const.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.radius,
    this.isNetworkImage = true,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final Color? color;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    Widget assetImage() => Image.asset(
          imageUrl,
          width: width ?? 50.0,
          height: width ?? 50.0,
          fit: BoxFit.cover,
          color: color,
        );

    Widget networkImage() => Image.network(
          imageUrl,
          width: width ?? 50.0,
          height: width ?? 50.0,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (_, __, ____) => Image.network(ImageConst.baseImageView,
              width: width, height: width, fit: BoxFit.cover),
          color: color,
        );
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? 100),
      ),
      child: isNetworkImage ? networkImage() : assetImage(),
    );
  }
}
