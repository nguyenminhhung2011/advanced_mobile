import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';

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
    this.hPadding = 30.0,
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: listStringtoColors(widget.colors),
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: widget.hPadding, vertical: widget.vPadding),
          child: TextField(
            cursorColor: Colors.white,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              fillColor: Colors.white.withOpacity(0.25),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none),
              hintText: widget.hintText,
            ),
          ),
        ),
      ),
    );
  }
}
