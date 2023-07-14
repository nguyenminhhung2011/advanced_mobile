enum TabBarType {
  indicatorTabBar,
  dotTabBar,
  animationTabBar,
  rowTabBar,
  titleTabBar;

  bool get isIndicatorTabBar => this == TabBarType.indicatorTabBar;
  bool get isDotTabBar => this == TabBarType.dotTabBar;
  bool get isTitleTabBar => this == TabBarType.titleTabBar;
  bool get isAnimationTabBar => this == TabBarType.animationTabBar;
  bool get isRowTabBar => this == TabBarType.rowTabBar;
}
