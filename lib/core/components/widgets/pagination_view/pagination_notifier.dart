import 'package:flutter/material.dart';

class PaginationNotifier<T> extends ChangeNotifier {
  final Future<List<T>> Function(int) call;
  final List<T> preloadedItems;
  PaginationNotifier(this.call, this.preloadedItems);

  bool _loading = false;
  bool get loading => _loading;

  void fetchPaginationItems(int limit) async {
    if (_loading) {
      return;
    }
    _loading = true;
    notifyListeners();
    preloadedItems.addAll(await call(preloadedItems.length ~/ limit));
    _loading = false;
    notifyListeners();
  }
}
