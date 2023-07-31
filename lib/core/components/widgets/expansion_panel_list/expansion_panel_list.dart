import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/expansion_panel_list/expansion_notifier.dart';
import 'package:provider/provider.dart';

typedef BodyLoad<B> = Future<B> Function(int index);

class ExpansionModel<T, B> {
  T data;
  B? bodyData;
  bool isExpanded;
  ExpansionModel({
    this.isExpanded = false,
    this.bodyData,
    required this.data,
  });
}

class ExpansionPanelCustom<T, B> extends StatefulWidget {
  final List<T> parentItems;
  final List<String>? listId;
  final Widget Function(BuildContext, T, bool isExpanded) parentItemBuilder;
  final Widget Function(BuildContext, B) bodyItem;
  final BodyLoad<B> loadBody;
  final EdgeInsets? expandedHeaderPadding;
  final double elevation;
  final Color? expandPanelColor;
  final int animationDuration; // milliSeconds
  const ExpansionPanelCustom({
    super.key,
    this.listId,
    this.elevation = 0,
    this.expandPanelColor,
    this.expandedHeaderPadding,
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
  late ExpansionNotifier<T, B> _expansionNotifier;

  @override
  void initState() {
    _expansionNotifier = ExpansionNotifier<T, B>(
      preItem: widget.parentItems,
      loadBody: widget.loadBody,
      listId: widget.listId ??
          List.generate(widget.parentItems.length, (index) => index.toString()),
    )..generateExpansionData();
    super.initState();
  }

  Future<void> _expansionsCall(int index, bool isExpanded) async {
    _expansionNotifier.onSelected(index, isExpanded);
    if (!isExpanded) {
      await _expansionNotifier.getBodyData(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.parentItems.isEmpty) {
      return const SizedBox();
    }
    return ChangeNotifierProvider.value(
      value: _expansionNotifier,
      child: Consumer<ExpansionNotifier<T, B>>(
        builder: (context, modal, _) {
          return ExpansionPanelList(
            elevation: widget.elevation,
            expandedHeaderPadding: widget.expandedHeaderPadding ??
                const EdgeInsets.symmetric(vertical: 0.0),
            animationDuration: Duration(milliseconds: widget.animationDuration),
            expansionCallback: _expansionsCall,
            children: [
              ...modal.listExpansion.mapIndexed(
                (index, e) => ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor:
                      widget.expandPanelColor ?? Theme.of(context).cardColor,
                  headerBuilder: (_, isExpanded) =>
                      widget.parentItemBuilder(_, e.data, isExpanded),
                  body: Column(
                    children: [
                      if (modal.loading.contains(index)) ...[
                        const SizedBox(height: 10.0),
                        Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ] else if (e.bodyData != null)
                        widget.bodyItem(context, e.bodyData!)
                    ],
                  ),
                  isExpanded: e.isExpanded,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
