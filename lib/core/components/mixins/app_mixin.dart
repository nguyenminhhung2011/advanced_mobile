import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/config/app_config.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:jumping_dot/jumping_dot.dart';

enum LoadingType { jumpingDot, circular }

enum SplashType { animationSplash, normalSplash }

mixin AppMixin<T extends StatefulWidget> on State<T> {
  //style
  Color get _primaryColor => Theme.of(context).primaryColor;
  void onComplete() {}

  AppConfig? get appConfig => null;

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  // Splash

  Widget loadingWidget([
    LoadingType loadingType = LoadingType.circular,
    Color? loadingColor,
    Duration? animaDuration,
    double dotRadius = 8,
  ]) =>
      switch (loadingType) {
        LoadingType.circular =>
          CircularProgressIndicator(color: loadingColor ?? _primaryColor),
        _ => JumpingDots(
            radius: dotRadius,
            animationDuration:
                animaDuration ?? const Duration(milliseconds: 300),
            innerPadding: 2,
            color: loadingColor ?? _primaryColor,
          ),
      };

  Widget imageShowWidget({
    SplashType splashType = SplashType.animationSplash,
    bool isAssetImage = false,
    double height = 100.0,
    double width = 100.0,
  }) =>
      switch (splashType) {
        SplashType.animationSplash => AnimationSplash(
            imageUrl: appConfig?.imageUrl ?? ImageConst.baseImageView,
            isAssetImage: isAssetImage,
            width: width,
            height: height,
          ),
        _ => ImageCustom(
            imageUrl: appConfig?.imageUrl ?? ImageConst.baseImageView,
            isNetworkImage: !isAssetImage,
            width: width,
            height: height,
          )
      };

  Widget textApp({
    List<String> title = const <String>[],
    List<TextStyle> style = const <TextStyle>[],
    TextStyle? parentStyle,
  }) {
    final styleSet = List.generate(title.length,
        (index) => (index >= title.length) ? style.last : style[index]);

    return RichText(
      text: TextSpan(
        style: parentStyle ??
            context.titleSmall.copyWith(fontWeight: FontWeight.w600),
        children: [
          ...title.mapIndexed(
            (index, e) => TextSpan(text: e, style: styleSet[index]),
          )
        ],
      ),
    );
  }

  // on boarding

  Widget _onBoardHeadingText({required String text, TextStyle? style}) => Text(
        text,
        textAlign: TextAlign.center,
        style: style ??
            context.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
      );

  Widget _onBoardDescriptionText({required String text, TextStyle? style}) =>
      Text(
        text,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: style ??
            context.titleSmall.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
      );

  Widget _dotAnimated(bool isSelect) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: isSelect ? 10.0 : 6.0,
      height: isSelect ? 10.0 : 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelect ? Theme.of(context).primaryColor : Colors.grey,
      ),
    );
  }
}

class AnimationSplash extends StatefulWidget {
  final String imageUrl;
  final bool isAssetImage;
  final double hPadding;
  final double vPadding;
  final Duration? duration;
  final double height;
  final double width;
  const AnimationSplash({
    super.key,
    this.duration,
    this.vPadding = 10.0,
    this.hPadding = 10.0,
    this.isAssetImage = false,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  State<AnimationSplash> createState() => _AnimationSplashState();
}

class _AnimationSplashState extends State<AnimationSplash>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.reset();
      _animationController!.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 1000),
    );
    if (_animationController != null) {
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInCubic,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
        vertical: widget.vPadding,
      ),
      child: FadeTransition(
        opacity: _animation!,
        child: ImageCustom(
          width: widget.width,
          height: widget.height,
          imageUrl: widget.imageUrl,
          isNetworkImage: !widget.isAssetImage,
        ),
      ),
    );
  }
}
