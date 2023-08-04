class NodeModel<T> {
  T? data;
  int level = -1;
  int parentIndex = -1;
  int currentIndex = -1;
  bool isSelected = false;
  int childCount = 0;
  NodeModel();

  setLevel(int level) {
    this.level = level;
  }

  setData(T data) {
    this.data = data;
  }

  setParentIndex(int index) {
    this.parentIndex = index;
  }

  setCurrentIndex(int index) {
    this.currentIndex = index;
  }

  setSelected(bool isSelected) {
    this.isSelected = isSelected;
  }

  setChildCount(int count) {
    this.childCount = count;
  }
}
