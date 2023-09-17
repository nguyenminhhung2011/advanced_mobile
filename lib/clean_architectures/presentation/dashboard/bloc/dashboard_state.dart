part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  final List<TabItem> tabItems;
  final int index;
  final bool isShowMenu;

  const DashboardState(
    this.tabItems,
    this.index,
    this.isShowMenu,
  );
}

class DashboardInitial extends DashboardState {
  const DashboardInitial(
    List<TabItem> tabItems,
    int index,
    bool isShowMenu,
  ) : super(tabItems, index, isShowMenu);

  @override
  List<Object?> get props => [tabItems];
}

class ChangeTab extends DashboardInitial {
  const ChangeTab(super.tabItems, super.index, super.isShowMenu);

  @override
  List<Object?> get props => [index, isShowMenu];
}

class ChangeShowMenu extends DashboardInitial {
  const ChangeShowMenu(super.tabItems, super.index, super.isShowMenu);
  @override
  List<Object?> get props => [index, isShowMenu];
}
