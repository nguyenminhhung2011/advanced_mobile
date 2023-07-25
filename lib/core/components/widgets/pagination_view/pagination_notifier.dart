import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class PaginationNotifier<T> extends ChangeNotifier {
  final Future<List<T>> Function(int, @Default('') String category) call;
  List<T> preloadedItems;
  String category;
  PaginationNotifier(this.call, this.preloadedItems, {this.category = ''});

  bool _loading = false;
  bool get loading => _loading;

  void fetchPaginationItems(int limit) async {
    if (_loading) {
      return;
    }
    _loading = true;
    notifyListeners();
    preloadedItems.addAll(await call(preloadedItems.length ~/ limit, category));
    _loading = false;
    notifyListeners();
  }

  void refreshItems(int limit) async {
    _loading = true;
    notifyListeners();
    preloadedItems.clear();
    preloadedItems = (await call(0, category));
    _loading = false;
    notifyListeners();
  }
}
