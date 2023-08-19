import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../skeleton_custom.dart';

const _kDefaultWidth = 100.0;
const _kDefaultHeight = 150.0;
const _kDefaultAutoPlayDurationInSecond = 3;
const _kDefaultItemsPerPage = 1;
const _kDefaultIndicatorSize = 10.0;
const _kDefaultHPadding = 4.0;
const _kRadius = 3.0;

enum TypeLoading { circular, skelton }

class BannerSliderWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final List<String>? images;
  final bool autoPlay;
  final int autoPlayDurationInSecond;
  final int itemsPerPage;
  final double indicatorSize;
  final double hPadding;
  final double radius;
  final MainAxisAlignment? dotPosition;
  final Color? dotColor;
  final TypeLoading typeLoading;

  const BannerSliderWidget({
    super.key,
    this.height = _kDefaultHeight,
    this.width = _kDefaultWidth,
    this.images,
    this.dotColor,
    this.autoPlay = true,
    this.radius = _kRadius,
    this.hPadding = _kDefaultHPadding,
    this.autoPlayDurationInSecond = _kDefaultAutoPlayDurationInSecond,
    this.itemsPerPage = _kDefaultItemsPerPage,
    this.indicatorSize = _kDefaultIndicatorSize,
    this.typeLoading = TypeLoading.circular,
    this.dotPosition,
  });

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;

  void onPageChange(int index) {
    setState(() {
      _currentPage = index;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    final itemsPerPage = widget.itemsPerPage;
    final width = widget.width ?? _kDefaultWidth;
    final height = widget.height ?? _kDefaultHeight;
    final images = widget.images ?? [];
    final imageCount = images.length;
    final dotPosition = widget.dotPosition ?? MainAxisAlignment.end;
    final dotColor =
        widget.dotColor ?? Theme.of(context).colorScheme.background;
    if (itemsPerPage < 1 || imageCount < 1) {
      return const SizedBox();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            enlargeCenterPage: false,
            viewportFraction: 1,
            autoPlay: widget.autoPlay,
            height: height,
            autoPlayAnimationDuration:
                Duration(seconds: widget.autoPlayDurationInSecond),
            onPageChanged: (index, _) => onPageChange(index),
          ),
          carouselController: _controller,
          itemCount: (imageCount / itemsPerPage).ceil(),
          itemBuilder: (_, index, __) {
            final startIndex = index * itemsPerPage;
            return Row(
              children: [
                for (var i = 0; i < itemsPerPage; i++)
                  Expanded(
                    flex: 1,
                    child: startIndex + i < imageCount
                        ? _imageItemView(height, images, startIndex, i, width)
                        : const SizedBox(),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: dotPosition,
          children: images.mapIndexed(
            (index, entry) {
              return GestureDetector(
                onTap: () =>
                    _controller.animateToPage((index / itemsPerPage).floor()),
                child: Container(
                  width: widget.indicatorSize,
                  height: widget.indicatorSize,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor.withOpacity(
                      _currentPage * itemsPerPage <= index &&
                              (_currentPage + 1) * itemsPerPage > index
                          ? 0.6
                          : 0.2,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Container _imageItemView(
    double height,
    List<String> images,
    int startIndex,
    int i,
    double width,
  ) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Image.network(
            images[startIndex + i],
            width: width,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return switch (widget.typeLoading) {
                TypeLoading.circular => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                _ => SkeletonContainer.rounded(
                    height: height,
                    width: width,
                    borderRadius: BorderRadius.circular(widget.radius),
                  )
              };
            },
          ),
        ),
      ),
    );
  }
}
