class NodeModel<T> {
  T? data;
  int level = -1;
  int parentIndex = -1;
  int currentIndex = -1;
  bool isSelected = false;
  List<NodeModel> children;
  NodeModel() : children = [];
}
