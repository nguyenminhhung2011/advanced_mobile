import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/controller/tree_view_controller.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/node/node_model.dart';
import 'package:provider/provider.dart';

typedef GetNode<T> = Future<List<NodeModel<T>>> Function(
    {NodeModel<T>? parentNode});

class TreeView<T> extends StatefulWidget {
  final Widget Function(BuildContext, NodeModel<T>) itemBuilder;
  final GetNode<T> onTapNode;
  final List<T> parentNodesData;
  final TreeViewController<T>? treeViewController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final bool reverse;

  const TreeView({
    super.key,
    this.padding,
    this.physics,
    this.treeViewController,
    this.shrinkWrap = false,
    this.reverse = false,
    required this.itemBuilder,
    required this.parentNodesData,
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
    final physics = widget.physics ?? const BouncingScrollPhysics();
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
            padding: EdgeInsets.only(left: node.level * 10),
            child: InkWell(
              onTap: () {},
              child: widget.itemBuilder(context, node),
            ),
          );
        },
      ),
    );
  }
}
