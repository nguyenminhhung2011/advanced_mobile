import 'package:flutter/material.dart';

import 'category_layout.dart';

class CategoryLayoutNotifier<T> extends ChangeNotifier {
  final List<ProductModel<T>> items;
  final Future<List<ProductModel<T>>> Function(
      List<CategoryLayoutModel> categoryIds) call;
  CategoryLayoutNotifier(this.items, this.call);
  bool _loading = false;
  bool get loading => _loading;

  final Map<String, List<T>> _autoScrollItems = {};
  Map<String, List<T>> get autoScrollItems => _autoScrollItems;
  int _countItem = 0;
  int get countItem => _countItem;

  CategoryLayoutModel? _categorySelected;
  CategoryLayoutModel? get categorySelected => _categorySelected;

  void onSelectedCategory(CategoryLayoutModel? newCategory) {
    _categorySelected = newCategory;
    notifyListeners();
  }

  void fetchProductItem(
    List<CategoryLayoutModel> categoryIds, {
    bool isAuto = false,
    int numberColumn = 2,
  }) async {
    if (_loading) {
      return;
    }
    _loading = true;
    notifyListeners();
    final items = await call(categoryIds);
    if (isAuto) {
      _autoScrollItems.clear();
      _countItem = categoryIds.length;
      for (var element in categoryIds) {
        _autoScrollItems.addAll({element.id: []});
      }
      for (var element in items) {
        if (_autoScrollItems.containsKey(element.categoryId)) {
          _autoScrollItems[element.categoryId]!.add(element.data);
        }
      }
    } else {
      items.clear();
      items.addAll(items);
    }
    _loading = false;
    notifyListeners();
  }
}
