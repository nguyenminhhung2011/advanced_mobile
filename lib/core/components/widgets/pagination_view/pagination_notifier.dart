import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:async/async.dart';

class PaginationNotifier<T> extends ChangeNotifier {
  final Future<List<T>> Function(int, @Default('') String category) call;
  CancelableOperation<List<T>>? _currentOperation; // Add this variable
  List<T> preloadedItems;
  String category;

  PaginationNotifier(this.call, this.preloadedItems, {this.category = ''});

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchPaginationItems(int limit) async {
    if (_loading || preloadedItems.isEmpty) {
      return;
    }
    _loading = true;
    notifyListeners();

    if (_currentOperation != null) {
      _currentOperation?.cancel(); // Cancel the current operation if it exists
    }

    _currentOperation = CancelableOperation.fromFuture(
      call(preloadedItems.length ~/ limit, category),
    );

    preloadedItems.addAll(await _currentOperation!.value);
    _loading = false;
    notifyListeners();
  }

  void refreshItems(int limit) async {
    _loading = true;
    notifyListeners();
    preloadedItems.clear();
    preloadedItems = await call(0, category);
    _loading = false;
    notifyListeners();
  }
}
