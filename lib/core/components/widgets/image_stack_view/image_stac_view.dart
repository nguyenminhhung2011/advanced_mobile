import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class ImageStackView extends StatefulWidget {
  final List<String> images;
  final double itemViewSize;
  final int itemsDisplay;
  final double shadowOpacity;
  final double blurRadius;
  final bool isAssetImage;
  final Color actionColor;
  const ImageStackView({
    super.key,
    this.blurRadius = 5.0,
    this.itemsDisplay = 3,
    this.shadowOpacity = 0.2,
    this.itemViewSize = 28.0,
    this.actionColor = Colors.white,
    required this.images,
    required this.isAssetImage,
  });

  @override
  State<ImageStackView> createState() => _ImageStackViewState();
}

class _ImageStackViewState extends State<ImageStackView> {
  @override
  Widget build(BuildContext context) {
    if (widget.itemsDisplay > widget.images.length) {
      return const SizedBox();
    }
    final imagesDisplay =
        List.generate(widget.itemsDisplay, (index) => widget.images[index]);
    final shadows = [
      BoxShadow(
        color: Theme.of(context).shadowColor.withOpacity(widget.shadowOpacity),
        blurRadius: widget.blurRadius,
      )
    ];
    return Stack(
      children: [
        ...imagesDisplay.mapIndexed(
          (index, element) {
            return Container(
              width: widget.itemViewSize,
              height: widget.itemViewSize,
              margin:
                  EdgeInsets.only(left: (index * (widget.itemViewSize / 2))),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: widget.isAssetImage
                    ? DecorationImage(
                        image: AssetImage(element), fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage(element), fit: BoxFit.cover),
                boxShadow: shadows,
              ),
            );
          },
        ),
        if (widget.itemsDisplay < widget.images.length)
          Container(
            width: widget.itemViewSize,
            height: widget.itemViewSize,
            margin: EdgeInsets.only(
              left: (widget.itemsDisplay * (widget.itemViewSize / 2)),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.actionColor,
              boxShadow: shadows,
            ),
            child: Center(
              child: Text(
                '+${widget.images.length - widget.itemsDisplay}',
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: widget.actionColor.fontColorByBackground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
