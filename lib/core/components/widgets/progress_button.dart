import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

enum ProgressButtonState { loading, completed, error, normal }

extension ProgressButtonStateExtension on ProgressButtonState {
  bool get isNormal => this == ProgressButtonState.normal;
  bool get isCompleted => this == ProgressButtonState.completed;
  bool get isError => this == ProgressButtonState.error;
  bool get isLoading => this == ProgressButtonState.loading;
}

class ProgressButton extends StatefulWidget {
  ///[isAnimation] true => active animation of progress button
  final bool isAnimation;

  ///[milliSeconds] default [300 ms]
  final int animationDuration;

  ///[Button style]
  final Color? buttonColor;

  final String textInside;

  final TextStyle? textStyle;

  ///[Call]
  final Future<bool> Function() call;

  final Color? loadingColor;

  final double? width;

  final double? height;

  final EdgeInsets? padding;

  final double? radius;
  const ProgressButton({
    Key? key,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.textStyle,
    this.isAnimation = true,
    this.animationDuration = 300,
    this.buttonColor,
    this.loadingColor,
    required this.call,
    required this.textInside,
  })  : assert(animationDuration > 0, 'animationDuration must be more than 0'),
        assert(
          isAnimation ? width != null : true,
          'If button is animationMode $isAnimation width of button is \'t null',
        ),
        super(key: key);

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  bool get _isAnimation => widget.isAnimation;

  int get _animationDuration => widget.animationDuration;

  Color get _buttonColor =>
      widget.buttonColor ?? Theme.of(context).primaryColor;

  Color get _loadingColor =>
      widget.loadingColor ?? _buttonColor.fontColorByBackground;

  TextStyle get _textStyle =>
      widget.textStyle?.copyWith(overflow: TextOverflow.ellipsis) ??
      context.titleMedium.copyWith(
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
        color: _buttonColor.fontColorByBackground,
      );

  double? get _width {
    if (widget.width == null) {
      return null;
    } else if (widget.width!.isInfinite) {
      return double.maxFinite;
    } else {
      return widget.width!;
    }
  }

  double get _height => widget.height ?? 33.0;

  double get _radius => widget.radius ?? 25.0;

  EdgeInsets get _padding => widget.padding ?? const EdgeInsets.all(5.0);

  ///[Controller]
  late AnimationController _animationController;
  late Animation _animation;

  double? _trueWidth = 0.0;
  double _circularWidth = 0.0;
  ProgressButtonState _progressButtonState = ProgressButtonState.normal;

  @override
  void initState() {
    _setSize();
    if (_isAnimation) {
      _setAnimationController();
    }
    super.initState();
  }

  void _listenAnimation() {
    setState(() {
      _trueWidth = _animation.value;
    });
  }

  void _setSize() {
    setState(() {
      _trueWidth = _width;
      _circularWidth = _height + (_padding.left + _padding.right);
    });
  }

  void _listenAnimationStatus(AnimationStatus animationStatus) async {
    if (animationStatus == AnimationStatus.completed) {
      final functionCall = await widget.call();
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        _animationController.reverse();
      });
      _changeState(functionCall);
    }
  }

  void _setAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    );
    _setAnimation();
    _animation.addListener(_listenAnimation);
    _animationController.addStatusListener(_listenAnimationStatus);
  }

  void _setAnimation() {
    _animation = Tween(begin: _width, end: _circularWidth).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setSize();
    if (widget.isAnimation) {
      if (oldWidget.isAnimation) {
        _animationController.duration =
            Duration(milliseconds: _animationDuration);
        _setAnimation();
      } else {
        _setAnimationController();
      }
    } else {
      if (oldWidget.isAnimation) {
        setState(() {
          _trueWidth = _width;
        });
      }
    }
    setState(() {
      _progressButtonState = ProgressButtonState.normal;
    });
  }

  void _cancelAnimation(bool isRemove) {
    if (isRemove) {
      _animation.removeListener(_listenAnimation);
      _animationController.removeStatusListener(_listenAnimationStatus);
      _animationController.dispose();
    }
  }

  @override
  void dispose() {
    _cancelAnimation(_isAnimation);
    super.dispose();
  }

  void _onTap() async {
    if (_progressButtonState.isLoading) {
      return;
    }
    setState(() {
      _progressButtonState = ProgressButtonState.loading;
    });
    if (_isAnimation) {
      _animationController.forward();
    } else {
      final call = await widget.call();
      _changeState(call);
    }
  }

  void _changeState(bool call) {
    if (call) {
      setState(() {
        _progressButtonState = ProgressButtonState.completed;
      });
    } else {
      setState(() {
        _progressButtonState = ProgressButtonState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: _padding,
        width: _trueWidth,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            _trueWidth == _circularWidth ? 50 : _radius,
          ),
          color: _buttonColor,
        ),
        child: SizedBox(
          height: _height,
          child: Center(
            child: switch (_progressButtonState) {
              ProgressButtonState.loading => CircularProgressIndicator(
                  color: _loadingColor,
                  strokeWidth: 1.5,
                ),
              _ => Text(
                  widget.textInside,
                  textAlign: TextAlign.center,
                  style: _textStyle,
                ),
            },
          ),
        ),
      ),
    );
  }
}
