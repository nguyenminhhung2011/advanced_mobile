import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class BadgeIndicatorStyle {
  final double radius;
  final String inSide;
  const BadgeIndicatorStyle({
    this.radius = 50.0,
    this.inSide = '🐼',
  });
}

class LinearProgressIndicatorCustom extends StatefulWidget {
  /// [Style] Customize style for widget
  final double? width;

  final double? height;

  final double initData;

  final double progressData;

  final double radius;

  final Color? fillColor;

  final Color? progressColor;

  final EdgeInsets? padding;

  ///[Badge] badge indicator style
  final BadgeIndicatorStyle? badgeIndicator;

  ///[isShowText] true => show percent of progress
  final bool isShowText;

  final TextStyle? textStyle;

  ///[Animation] Customize animation for widget

  ///[isAnimation] true => active animation of progress indicator
  final bool isAnimation;

  /// [milliSeconds] default [300 ms]
  final int? animationDuration;

  /// [animationCompleted] call when animation end
  final Function()? animationCompleted;

  ///Curve of animation with default [Curve.linear]
  final Curve? curve;
  const LinearProgressIndicatorCustom({
    Key? key,
    this.width,
    this.curve,
    this.height,
    this.padding,
    this.fillColor,
    this.textStyle,
    this.progressColor,
    this.badgeIndicator,
    this.animationDuration,
    this.animationCompleted,
    this.radius = 10.0,
    this.isShowText = false,
    this.isAnimation = true,
    required this.initData,
    required this.progressData,
  })  : assert(
          progressData <= initData,
          'ProgressData must be less than initData',
        ),
        super(key: key);

  @override
  State<LinearProgressIndicatorCustom> createState() =>
      _LinearProgressIndicatorCustomState();
}

class _LinearProgressIndicatorCustomState
    extends State<LinearProgressIndicatorCustom> with TickerProviderStateMixin {
  /// Recall value
  bool get _isAnimation => widget.isAnimation;

  bool get _isShowText => widget.isShowText;

  Color get _primaryColor => Theme.of(context).primaryColor;

  Color get _fillColor => widget.fillColor ?? _primaryColor.withOpacity(0.2);

  Color get _progressColor => widget.progressColor ?? _primaryColor;

  Curve get _curve => widget.curve ?? Curves.linear;

  EdgeInsets get _padding => widget.padding ?? EdgeInsets.zero;

  TextStyle get _textStyle => widget.textStyle ?? context.titleSmall;

  int get _animationDuration => widget.animationDuration ?? 300;

  double get _progressData => widget.progressData;

  double get _initData => widget.initData;

  double get _percent => _progressData / _initData;

  Function()? get _animationCompleted => widget.animationCompleted;

  BadgeIndicatorStyle? get _headerProgressWidget => widget.badgeIndicator;

  // App controller
  late AnimationController _animationController;
  late Animation _animation;

  double _percentDisplay = 0.0;

  ///[indicator size]
  double _indicatorWidth = 0.0;
  double _indicatorHeight = 0.0;

  ///[true size of parent]
  double _trueHeight = 0.0;
  double _trueWidth = 0.0;

  final _indicatorKey = GlobalKey();
  final _fillKey = GlobalKey();

  Widget get _indicatorWidget => _headerProgressWidget != null
      ? BadgeIndicator(
          borderColor: _progressColor,
          inSide: _headerProgressWidget!.inSide,
          globalKey: _indicatorKey,
          radius: _headerProgressWidget!.radius,
        )
      : const SizedBox();

  @override
  void initState() {
    // Call when built up UI completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          if (_headerProgressWidget != null) {
            _indicatorWidth = _indicatorKey.currentContext?.size?.width ?? 0.0;
            _indicatorHeight =
                _indicatorKey.currentContext?.size?.height ?? 0.0;
          }
          _trueWidth = _fillKey.currentContext?.size?.width ?? 0.0;
          _trueHeight = _fillKey.currentContext?.size?.height ?? 0.0;
        });
      }
    });
    if (_isAnimation) {
      _initAnimation();
    } else {
      setState(() {
        _percentDisplay = _percent;
      });
    }
    super.initState();
  }

  /// [initAnimation] is called when isAnimation == true
  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    );
    _animation = Tween(begin: 0.0, end: _percent).animate(
      /// open animation with parent is [CurvedAnimation]
      CurvedAnimation(parent: _animationController, curve: _curve),
    );
    _animation.addListener(_listenAnimation);

    if (_animationCompleted != null) {
      _animationController.addStatusListener(_listenAnimationStatus);
    }

    ///[forward] start running animation
    _animationController.forward();
  }

  ///[didChangeDependencies] function call before dispose
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _listenAnimationStatus(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      _animationCompleted!.call();
    }
  }

  /// Support [_percent] for display on text
  void _listenAnimation() {
    setState(() {
      _percentDisplay = _animation.value;
    });
  }

  /// [didUpdateWidget] function call after dev hot reload with new percent
  @override
  void didUpdateWidget(LinearProgressIndicatorCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initData == oldWidget.initData &&
        widget.progressData == oldWidget.progressData) {
      return;
    }
    if (!widget.isAnimation) {
      setState(() {
        _percentDisplay = _progressData / _initData;
      });
      return;
    }
    if (!oldWidget.isAnimation) {
      return _initAnimation();
    }

    ///Restart animation
    _animationController.duration = Duration(milliseconds: _animationDuration);
    _animation = Tween(begin: 0.0, end: _percent)
        .animate(CurvedAnimation(parent: _animationController, curve: _curve));
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    if (_isAnimation) {
      if (_animationCompleted != null) {
        _animationController.removeStatusListener(_listenAnimationStatus);
      }
      _animation.removeListener(_listenAnimation);
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _fillKey,
      width: widget.width ?? double.infinity,
      height: widget.height ?? 15.0,
      color: Colors.transparent,
      margin: _padding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: widget.height ?? 15.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: _fillColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: _percentDisplay * _trueWidth,
              height: widget.height ?? 15.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                color: _progressColor,
              ),
            ),
          ),
          if (_isShowText)
            Center(
              child: Text(
                ((_percent * 100).round()).toString(),
                style: _textStyle.copyWith(
                  color: _progressColor.fontColorByBackground,
                ),
              ),
            ),
          if (_headerProgressWidget != null)
            Positioned(
              top: _trueHeight / 2 - _indicatorHeight / 2,
              left: _percentDisplay * _trueWidth - _indicatorWidth / 2,
              child: _indicatorWidget,
            ),
        ],
      ),
    );
  }
}

class BadgeIndicator extends StatelessWidget {
  final GlobalKey? globalKey;
  final double radius;
  final Color? borderColor;

  ///[inSide] is text
  final String? inSide;
  const BadgeIndicator({
    super.key,
    this.globalKey,
    this.radius = 50.0,
    this.borderColor,
    this.inSide,
  }) : assert(radius >= 20.0, 'Size must be more 40');

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
        border: Border.all(
          width: 1,
          color: borderColor ?? Theme.of(context).primaryColor,
        ),
      ),
      child: Center(
        child: Text(inSide ?? '🐼'),
      ),
    );
  }
}
