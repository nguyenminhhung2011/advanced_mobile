import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';

import 'model_bottom_sheet.dart';

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
  final Function(dynamic)? filterCall;

  const HeaderSearch({
    super.key,
    this.colors = const ["992195F3", "CA2195F3"],
    this.hintText = 'Search',
    this.vPadding = 10.0,
    this.hPadding = 20.0,
    this.hintStyle,
    this.textStyle,
    this.textChange,
    this.prefixIcon,
    this.searchRadius,
    this.isShowAction = true,
    this.actionIcon,
    this.onPress,
    this.filterCall,
  });

  @override
  State<HeaderSearch> createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  List<Color> listStringToColors(List<String> colors) {
    List<Color> result = [];
    for (var i = 0; i < colors.length; i++) {
      result.add(colors[i].toColor());
    }
    return result;
  }

  void _filterOnTap() async {
    final data = await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return const ModelBottomSheet();
      },
    );
    if (data != null && widget.filterCall != null) {
      widget.filterCall?.call(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).scaffoldBackgroundColor;
    final hintStyle = widget.hintStyle ?? TextStyle(color: textColor);
    final textStyle = widget.textStyle ??
        TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: textColor);
    final prefixIcon =
        widget.prefixIcon ?? Icon(Icons.search, color: textColor);

    final searchRadius = widget.searchRadius ?? _kRadius;
    final actionIcon = widget.actionIcon ??
        Icon(Icons.filter_list_outlined, size: 30, color: textColor);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: listStringToColors(widget.colors),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.hPadding,
                vertical: widget.vPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: textColor,
                      onChanged: widget.textChange,
                      style: textStyle,
                      decoration: InputDecoration(
                        prefixIcon: prefixIcon,
                        fillColor: textColor.withOpacity(0.25),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(searchRadius),
                          borderSide: BorderSide.none,
                        ),
                        hintText: widget.hintText,
                        hintStyle: hintStyle,
                      ),
                    ),
                  ),
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
}
