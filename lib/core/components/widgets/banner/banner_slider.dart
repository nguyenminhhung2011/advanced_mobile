import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const _kDefaultWidth = 100.0;
const _kDefaultHeight = 150.0;
const _kDefaultAutoPlayDurationInSecond = 3;
const _kDefaultItemsPerPage = 1;
const _kDefaultIndicatorSize = 10.0;

class BannerSliderWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final List<String>? images;
  final bool autoPlay;
  final int autoPlayDurationInSecond;
  final int itemsPerPage;
  final double indicatorSize;

  const BannerSliderWidget({
    super.key,
    this.height = _kDefaultHeight,
    this.width = _kDefaultWidth,
    this.images,
    this.autoPlay = true,
    this.autoPlayDurationInSecond = _kDefaultAutoPlayDurationInSecond,
    this.itemsPerPage = _kDefaultItemsPerPage,
    this.indicatorSize = _kDefaultIndicatorSize,
  });

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  final CarouselController _controller = CarouselController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final itemsPerPage = widget.itemsPerPage;
    final width = widget.width ?? _kDefaultWidth;
    final height = widget.height ?? _kDefaultHeight;
    final images = widget.images ?? [];
    final imageCount = images.length;

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
            onPageChanged: (index, _) {
              setState(() {
                _currentPage = index;
              });
            },
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
                        ? Container(
                            height: height,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                  images[startIndex + i],
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: images.asMap().entries.map(
            (entry) {
              final index = entry.key;

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
                    color: Theme.of(context).colorScheme.background.withOpacity(
                        _currentPage * itemsPerPage <= index &&
                                (_currentPage + 1) * itemsPerPage > index
                            ? 0.6
                            : 0.2),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
