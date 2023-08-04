import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/node/node_model.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tree_view_custom/tree_view.dart';

class TreeViewController<T> extends ChangeNotifier {
  final GetNode<T> call;
  TreeViewController({required this.call});

  List<NodeModel<T>> _data = <NodeModel<T>>[];
  List<NodeModel<T>> get data => _data;

  void generateToTreeNode() async {
    reBuild();
    final nodes = await call(null);
    _data.addAll(
      List.generate(
        nodes.length,
        (index) => NodeModel<T>()
          ..setCurrentIndex(index)
          ..setData(nodes[index])
          ..setParentIndex(0)
          ..setLevel(0),
      ),
    );
    reBuild();
  }

  void reBuild() {
    notifyListeners();
  }

  Map<String, List<NodeModel<T>>> subTwoArray(NodeModel<T> parentNode) {
    final beforeNodes = _data.sublist(0, parentNode.currentIndex)
      ..add(parentNode);
    final afterNodes = _data.sublist(parentNode.currentIndex);
    if (afterNodes.isEmpty) {
      afterNodes.clear();
    } else {
      afterNodes.removeAt(0);
    }
    return {'before': beforeNodes, 'after': afterNodes};
  }

  void removeSomeNode(NodeModel<T> parentNode) async {
    final level = parentNode.level;

    if (parentNode.isSelected) {
      removeAllSelected(parentNode);
    }

    final sub = subTwoArray(parentNode);
    final beforeNodes = sub['before'] ?? <NodeModel<T>>[];
    final preAfterNodes = sub['after'] ?? <NodeModel<T>>[];

    final afterNodes = <NodeModel<T>>[];
    bool isAdd = false;

    for (var i = 0; i < preAfterNodes.length; i++) {
      final node = preAfterNodes[i];
      if (node.level <= level && !isAdd) {
        isAdd = true;
      }
      if (isAdd) {
        afterNodes.add(node);
      }
    }

    final rangeCounter =
        _data.length - (beforeNodes.length + afterNodes.length);
    beforeNodes.last = parentNode..setChildCount(0);
    _data = [
      ...beforeNodes,
      ...afterNodes.mapIndexed((index, e) {
        final currentIndex = beforeNodes.length + index;
        final parentIndex = e.parentIndex <= parentNode.currentIndex
            ? e.parentIndex
            : e.parentIndex - rangeCounter;
        return e
          ..setCurrentIndex(currentIndex)
          ..setParentIndex(parentIndex);
      }),
    ];
    reBuild();
  }

  void removeAllSelected(NodeModel<T> parentNode) {
    int level = parentNode.level;
    int currentIndex = parentNode.currentIndex;
    if (!parentNode.isSelected) {
      while (level >= 0) {
        _data[currentIndex].setSelected(true);
        currentIndex = _data[currentIndex].parentIndex;
        level--;
      }
    } else {
      int parentIndex = parentNode.parentIndex;
      while (level > 0) {
        int chidCount = _data[parentIndex].childCount;
        int count = 0;
        int isSelectedCount = 0;
        int i = _data[parentIndex].currentIndex + 1;
        while (count < chidCount) {
          final node = _data[i];
          if (level == node.level) {
            count++;
            if (node.isSelected) {
              isSelectedCount++;
              if (isSelectedCount > 1) {
                _data[currentIndex].setSelected(false);
                reBuild();
                return;
              }
            }
          }
          i++;
        }
        _data[currentIndex].setSelected(false);
        currentIndex = parentIndex;
        parentIndex = _data[currentIndex].parentIndex;
        level--;
      }
      if (level == 0) {
        _data[currentIndex].setSelected(false);
      }
    }
    reBuild();
    return;
  }

  void getSomeNode(NodeModel<T> parentNode) async {
    final nodes = await call(parentNode);
    if (nodes.isEmpty) {
      removeAllSelected(parentNode);
    }
    final sub = subTwoArray(parentNode);
    final beforeNodes = sub['before'] ?? <NodeModel<T>>[];
    final afterNodes = sub['after'] ?? <NodeModel<T>>[];

    beforeNodes.last = parentNode..setChildCount(nodes.length);
    final level = parentNode.level + 1;
    final startIndex = parentNode.currentIndex + 1;
    _data = [
      ...beforeNodes,
      ...List.generate(
        nodes.length,
        (index) => NodeModel<T>()
          ..setCurrentIndex(startIndex + index)
          ..setData(nodes[index])
          ..setParentIndex(parentNode.currentIndex)
          ..setLevel(level),
      ),
      ...List.generate(
        afterNodes.length,
        (index) {
          final node = afterNodes[index];
          return node
            ..setParentIndex(node.parentIndex <= parentNode.currentIndex
                ? node.parentIndex
                : node.parentIndex + nodes.length)
            ..setCurrentIndex(node.currentIndex + nodes.length);
        },
      ),
    ];
    reBuild();
  }
}
