enum CategoryLayoutType {
  top,
  grid,
  both,
  card,
  autoScroll;

  bool get isTop => this == CategoryLayoutType.top;
  bool get isGrid => this == CategoryLayoutType.grid;
  bool get isBoth => this == CategoryLayoutType.both;
  bool get isCard => this == CategoryLayoutType.card;
  bool get isAutoScroll => this == CategoryLayoutType.autoScroll;
}
