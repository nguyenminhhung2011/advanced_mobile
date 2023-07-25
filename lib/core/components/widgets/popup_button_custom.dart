import 'package:flutter/material.dart';

class PopUpButtonCustom<T> extends StatefulWidget {
  final Function(T) onSelected;
  final List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder;
  final Widget icon;
  final EdgeInsets? padding;
  const PopUpButtonCustom(
      {super.key,
      required this.onSelected,
      required this.itemBuilder,
      required this.icon,
      this.padding});

  @override
  State<PopUpButtonCustom<T>> createState() => _PopUpButtonCustomState<T>();
}

class _PopUpButtonCustomState<T> extends State<PopUpButtonCustom<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      color: Colors.white,
      offset: const Offset(6, 5),
      padding: widget.padding ?? const EdgeInsets.all(5.0),
      position: PopupMenuPosition.under,
      icon: widget.icon,
      onSelected: widget.onSelected,
      itemBuilder: widget.itemBuilder,
    );
  }
}
