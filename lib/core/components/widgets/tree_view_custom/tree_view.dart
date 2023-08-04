import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/controller/tree_view_controller.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/node/node_model.dart';
import 'package:provider/provider.dart';

typedef GetNode<T> = Future<List<T>> Function(NodeModel<T>? parentNode);

class TreeView<T> extends StatefulWidget {
  final Widget Function(BuildContext, NodeModel<T>) itemBuilder;
  final GetNode<T> onTapNode;
  final TreeViewController<T>? treeViewController;
  final EdgeInsets? padding;
  final EdgeInsets? paddingItem;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverse;
  final double spacingItem;
  final Color? selectedColor;
  final Color? unSelectedColor;

  const TreeView({
    super.key,
    this.physics,
    this.padding,
    this.paddingItem,
    this.selectedColor,
    this.unSelectedColor,
    this.reverse = false,
    this.spacingItem = 5.0,
    this.shrinkWrap = false,
    this.treeViewController,
    required this.itemBuilder,
    required this.onTapNode,
  });

  @override
  State<TreeView<T>> createState() => _TreeViewState<T>();
}

class _TreeViewState<T> extends State<TreeView<T>> {
  late TreeViewController<T> _treeViewController;

  @override
  void initState() {
    _treeViewController = widget.treeViewController ??
        TreeViewController<T>(call: widget.onTapNode)
      ..generateToTreeNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTap(NodeModel<T> parentNode) {
    if (parentNode.childCount != 0) {
      _treeViewController.removeSomeNode(parentNode);
    } else {
      _treeViewController.getSomeNode(parentNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _treeViewController,
      child: Consumer<TreeViewController<T>>(
        builder: (context, modal, child) {
          return _customField(modal);
        },
      ),
    );
  }

  Widget _customField(TreeViewController<T> modal) {
    final padding = widget.padding ?? EdgeInsets.zero;
    final paddingItem = widget.paddingItem ?? const EdgeInsets.all(10.0);
    final physics = widget.physics ?? const BouncingScrollPhysics();
    final selectedColor =
        widget.selectedColor ?? Theme.of(context).primaryColor;
    final unSelectedColor =
        widget.unSelectedColor ?? Theme.of(context).cardColor;
    return Container(
      padding: padding,
      child: ListView.builder(
        physics: physics,
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        itemCount: modal.data.length,
        itemBuilder: (BuildContext context, int index) {
          NodeModel<T> node = modal.data[index];
          return Padding(
            padding: EdgeInsets.only(
              left: node.level * 20,
              top: widget.spacingItem / 2,
              bottom: widget.spacingItem / 2,
            ),
            child: InkWell(
              onTap: () => _onTap(node),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: double.infinity,
                padding: paddingItem,
                decoration: BoxDecoration(
                  color: node.isSelected
                      ? selectedColor.withOpacity(0.4)
                      : unSelectedColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    width: 1,
                    color: node.isSelected ? selectedColor : Colors.transparent,
                  ),
                ),
                child: widget.itemBuilder(context, node),
              ),
            ),
          );
        },
      ),
    );
  }
}
