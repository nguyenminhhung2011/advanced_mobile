import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textEditingController;

  final String? hingText;

  final TextStyle? hintStyle;

  final TextStyle? textStyle;

  final FocusNode? focusNode;

  final FocusNode? nextNode;

  final int maxLines;

  final int? minLines;

  final bool isShowPasswordIcon;

  final bool isShowCancelIcon;

  final Widget? suffix;

  final Widget? prefix;

  final bool? obscureText;

  final Function(String)? onChanged;

  final Function(String)? onSubmitted;

  final Function()? onEditingCompleted;

  final Function()? onCancel;

  final Function()? onTapSuffix;

  final Function()? onTapPrefix;

  final Function()? onTap;

  final TextInputType? textInputType;

  final EdgeInsets? contentPadding;

  ///[Border of input field]

  final bool? isShowBorder;

  final double? borderRadius;

  final Color? borderColor;

  final double? borderWidth;

  const CustomTextField({
    super.key,
    this.onTap,
    this.suffix,
    this.prefix,
    this.minLines,
    this.hingText,
    this.nextNode,
    this.focusNode,
    this.hintStyle,
    this.textStyle,
    this.onChanged,
    this.onCancel,
    this.obscureText,
    this.onSubmitted,
    this.onTapSuffix,
    this.onTapPrefix,
    this.textInputType,
    this.contentPadding,
    this.onEditingCompleted,
    this.textEditingController,
    this.maxLines = 1,
    this.isShowPasswordIcon = false,
    this.isShowCancelIcon = false,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.isShowBorder,
  }) : assert(
          /// Support for 3 options suffix [cancel], [password], [normal icon]
          (!isShowCancelIcon && !isShowPasswordIcon) ||
              !(isShowCancelIcon == isShowPasswordIcon),
          'Only one suffix option',
        );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController get _textEditingController =>
      widget.textEditingController ?? TextEditingController();

  String? get _hintText => widget.hingText;

  FocusNode? get _focusNode => widget.focusNode;

  FocusNode? get _nextNode => widget.nextNode;

  TextStyle get _hintStyle =>
      widget.hintStyle ??
      context.titleMedium.copyWith(
        color: Theme.of(context).hintColor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get _textStyle =>
      widget.textStyle ??
      context.titleMedium.copyWith(
        fontWeight: FontWeight.w500,
      );

  int get _maxLines => _isShowPasswordIcon == true ? 1 : widget.maxLines;

  int get _minLines => widget.minLines ?? 1;

  int get _applyMinLines => _minLines > _maxLines ? _maxLines : _minLines;

  bool get _isShowPasswordIcon => widget.isShowPasswordIcon;

  bool get _isShowCancelIcon => widget.isShowCancelIcon;

  bool showPassWordState = false;

  bool showCancelState = false;

  bool? get _obscureText => widget.obscureText;

  Widget? get _suffixIcon => widget.suffix;

  Widget? get _prefixIcon => widget.prefix;

  Function(String)? get _onSubmitted => widget.onSubmitted;

  Function(String)? get _onChanged => widget.onChanged;

  Function()? get _onEditingCompleted => widget.onEditingCompleted;

  Function()? get _onCancel => widget.onCancel;

  Function()? get _onTap => widget.onTap;

  Function()? get _onTapSuffix => widget.onTapSuffix;

  Function()? get _onTapPrefix => widget.onTapPrefix;

  TextInputType? get _textInputType => widget.textInputType;

  EdgeInsets get _contentPadding =>
      widget.contentPadding ??
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0);

  InputBorder? get _inputBurBorder => (widget.isShowBorder ?? false)
      ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.grey[300]!,
            width: widget.borderWidth ?? 1.0,
          ))
      : null;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_listenText);
  }

  void _listenText() {
    if (_isShowCancelIcon) {
      if (_textEditingController.text.isNotEmpty && !showCancelState) {
        setState(() {
          showCancelState = true;
        });
        return;
      }
      if (_textEditingController.text.isEmpty && showCancelState) {
        setState(() {
          showCancelState = false;
        });
        return;
      }
      return;
    }
  }

  void _cancelFunction() {
    if (_isShowCancelIcon) {
      _textEditingController.clear();
      _onCancel?.call();
    }
  }

  void _changeTypeView() {
    if (_isShowPasswordIcon) {
      setState(() {
        showPassWordState = !showPassWordState;
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_listenText);
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: _textInputType,
      controller: _textEditingController,
      maxLines: _maxLines,
      minLines: _applyMinLines,
      style: _textStyle,
      focusNode: _focusNode,
      onChanged: _onChanged,
      onTap: _onTap,
      readOnly: false,
      textInputAction:
          _nextNode == null ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: _onEditingCompleted,
      obscureText: _obscureText ?? showPassWordState,
      onSubmitted: _nextNode == null
          ? _onSubmitted
          : (_) {
              FocusScope.of(context).requestFocus(_nextNode);
              _onSubmitted?.call(_) ?? () {};
            },
      textAlign: TextAlign.start,
      cursorWidth: 1.5,
      decoration: InputDecoration(
        hintText: _hintText,
        contentPadding: _contentPadding,
        hintStyle: _hintStyle,
        prefix: _renderPrefixIcon(),
        suffix: _renderSuffixIcon(),
        border: _inputBurBorder,
      ),
    );
  }

  Widget? _renderPrefixIcon() {
    if (_prefixIcon == null) {
      return null;
    }
    return InkWell(
      onTap: _onTapPrefix,
      child: _prefixIcon,
    );
  }

  Widget? _renderSuffixIcon() {
    if (_isShowCancelIcon) {
      if (showCancelState) {
        return InkWell(
          onTap: _cancelFunction,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: _textStyle.color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 12.0,
              color: _textStyle.color?.fontColorByBackground,
            ),
          ),
        );
      }
      return null;
    }
    if (_isShowPasswordIcon) {
      return InkWell(
        onTap: _changeTypeView,
        child: Container(
          color: Colors.transparent,
          child: Icon(
            showPassWordState ? Icons.visibility_off : Icons.visibility,
            size: 14.0,
            color: Colors.grey,
          ),
        ),
      );
    }
    if (_suffixIcon == null) {
      return null;
    }
    return InkWell(
      onTap: _onTapSuffix,
      child: _suffixIcon,
    );
  }
}
