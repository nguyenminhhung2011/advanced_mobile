part of 'dashboard_bloc.dart';

@immutable
abstract class DashBoarEvent {
  const DashBoarEvent();
}

class ChangeTabEvent extends DashBoarEvent {
  final int index;
  const ChangeTabEvent(this.index);
}

class ChangeShowMenuEvent extends DashBoarEvent {
  const ChangeShowMenuEvent();
}
