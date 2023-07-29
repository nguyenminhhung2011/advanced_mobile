import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';

import 'model_bottom_sheet.dart';

class HeaderSearch extends StatefulWidget {
  final List<String> colors;
  final String hintText;
  final double vPadding;
  final double hPadding;

  const HeaderSearch({
    super.key,
    this.colors = const ["992195F3", "CA2195F3"],
    this.hintText = 'Search',
    this.vPadding = 10.0,
    this.hPadding = 20.0,
  });

  @override
  State<HeaderSearch> createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  List<Color> listStringtoColors(List<String> colors) {
    List<Color> result = [];
    for (var i = 0; i < colors.length; i++) {
      result.add(colors[i].toColor());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: listStringtoColors(widget.colors),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.hPadding, vertical: widget.vPadding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: textColor,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: textColor),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: textColor,
                          ),
                          fillColor: textColor.withOpacity(0.25),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none),
                          hintText: widget.hintText,
                          hintStyle: TextStyle(color: textColor)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        builder: (context) {
                          return const ModelBottomSheet();
                        },
                      );
                    },
                    child: Icon(
                      Icons.filter_list_outlined,
                      size: 30,
                      color: textColor,
                    ),
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
