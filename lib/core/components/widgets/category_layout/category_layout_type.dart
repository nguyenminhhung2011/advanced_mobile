enum CategoryLayoutType {
  top, // done
  grid,
  both, // done
  card, 
  autoScroll; // done
}

extension CheckCategoryLayout on CategoryLayoutType {
  bool get isTop => this == CategoryLayoutType.top;
  bool get isGrid => this == CategoryLayoutType.grid;
  bool get isBoth => this == CategoryLayoutType.both;
  bool get isCard => this == CategoryLayoutType.card;
  bool get isAutoScroll => this == CategoryLayoutType.autoScroll;
}
