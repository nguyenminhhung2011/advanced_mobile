import 'package:flutter/material.dart';

typedef BodyLoad<B> = Future<B> Function(int index);

class ExpansionPanelCustom<T, B> extends StatefulWidget {
  final List<T> parentItems;
  final Widget Function(BuildContext, T, bool isExpanded) parentItemBuilder;
  final Widget Function(BuildContext, B) bodyItem;
  final BodyLoad<B> loadBody;
  final double elevation;
  final int animationDuration; // milliSeconds
  const ExpansionPanelCustom({
    super.key,
    this.elevation = 0,
    this.animationDuration = 300,
    required this.parentItems,
    required this.parentItemBuilder,
    required this.bodyItem,
    required this.loadBody,
  });

  @override
  State<ExpansionPanelCustom<T, B>> createState() =>
      _ExpansionPanelCustomState<T, B>();
}

class _ExpansionPanelCustomState<T, B>
    extends State<ExpansionPanelCustom<T, B>> {
  Future<void> _expansionsCall(int index, bool isExpanded) async {
    if (isExpanded) {
      //do some thing here
      widget.loadBody(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.parentItems.isEmpty) {
      return const SizedBox();
    }
    return ExpansionPanelList(
      elevation: widget.elevation,
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 10.0),
      animationDuration: Duration(milliseconds: widget.animationDuration),
      expansionCallback: _expansionsCall,
      children: [
        ...widget.parentItems.map(
          (e) => ExpansionPanel(
            headerBuilder: (_, isExpanded) =>
                widget.parentItemBuilder(_, e, isExpanded),
            body: const Column(
              children: [],
            ),
          ),
        )
      ],
    );
  }
}
