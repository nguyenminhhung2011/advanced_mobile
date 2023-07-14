import 'package:flutter/material.dart';

class PaginationNotifier<T> extends ChangeNotifier {
  PaginationNotifier(this.call, this.preloadedItems);
  final Future<List<T>> Function(int, int) call;
  List<T> preloadedItems;

  bool _loading = false;
  bool get loading => _loading;

  void fetchPaginationItems() async {
    _loading = true;
    notifyListeners();
    preloadedItems = [...preloadedItems, ...await call(10, 0)];
    _loading = false;
    notifyListeners();
  }
}
