import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/search_layout/model/filter_model.dart';

import '../model/filter_response.dart';

const _kRadius = 14.0;

class HeaderSearch extends StatefulWidget {
  final List<String> colors;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double vPadding;
  final double hPadding;
  final double? searchRadius;
  final Widget? prefixIcon;
  final Function(String)? textChange;
  final bool isShowAction;
  final Widget? actionIcon;
  final Function()? onPress;
  final Function(List<FilterResponse>)? filterCall;
  final Function(String)? onSubmittedText;
  final TextEditingController? textEditingController;
  final EdgeInsets? contentPadding;
  final List<FilterModel> listFilter;
  final List<FilterResponse> initResponse;
  const HeaderSearch({
    super.key,
    this.onPress,
    this.hintStyle,
    this.textStyle,
    this.actionIcon,
    this.textChange,
    this.prefixIcon,
    this.filterCall,
    this.searchRadius,
    this.contentPadding,
    this.onSubmittedText,
    this.vPadding = 10.0,
    this.hPadding = 20.0,
    this.hintText = 'Search',
    this.isShowAction = true,
    this.textEditingController,
    this.colors = const ["992195F3", "CA2195F3"],
    this.listFilter = const <FilterModel>[],
    this.initResponse = const <FilterResponse>[],
  });

  @override
  State<HeaderSearch> createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  // style
  Color get textColor => Theme.of(context).scaffoldBackgroundColor;
  TextStyle get hintStyle =>
      widget.hintStyle ?? context.titleMedium.copyWith(color: textColor);
  TextStyle get textStyle =>
      widget.textStyle ??
      context.titleMedium.copyWith(
          fontWeight: FontWeight.w600, fontSize: 16, color: textColor);
  Widget get prefixIcon =>
      widget.prefixIcon ?? Icon(Icons.search, color: textColor);

  Widget get actionIcon =>
      widget.actionIcon ??
      Icon(Icons.filter_list_outlined, size: 30, color: textColor);
  double get searchRadius => widget.searchRadius ?? _kRadius;
  EdgeInsets get contentPadding =>
      widget.contentPadding ??
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0);

  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    _textEditingController.addListener(_listTextChange);
    super.initState();
  }

  List<Color> listStringToColors(List<String> colors) {
    List<Color> result = [];
    for (var i = 0; i < colors.length; i++) {
      result.add(colors[i].toColor());
    }
    return result;
  }

  void _listTextChange() {
    if (widget.textChange != null) {
      widget.textChange!(_textEditingController.text);
    }
  }

  void _filterOnTap() async {
    final data = await context.bottomFilter(
      body: widget.listFilter,
      initData: widget.initResponse,
    );
    if (data.isNotEmpty && widget.filterCall != null) {
      widget.filterCall?.call(data);
    }
  }

  void _onClearText() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_listTextChange);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: listStringToColors(widget.colors),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.3),
                blurRadius: 10.0,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.hPadding,
                vertical: widget.vPadding,
              ),
              child: Row(
                children: [
                  _textField(),
                  const SizedBox(width: 10),
                  if (widget.isShowAction)
                    GestureDetector(
                      onTap: _filterOnTap,
                      child: actionIcon,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Expanded _textField() {
    return Expanded(
      child: TextField(
        controller: _textEditingController,
        cursorColor: textColor,
        // onChanged: widget.textChange,
        onSubmitted: widget.onSubmittedText,
        style: textStyle,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          contentPadding: contentPadding,
          fillColor: textColor.withOpacity(0.25),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(searchRadius),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          hintStyle: hintStyle,
          suffix: InkWell(
            onTap: _onClearText,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: textStyle.color,
              ),
              child: Icon(
                Icons.close,
                size: 10,
                color: textStyle.color!.fontColorByBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
