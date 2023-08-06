import 'package:flutter/material.dart';

enum SearchEnum {
  list(0),
  grid(1);

  final num value;
  const SearchEnum(this.value);
}

class SearchLayoutController<T> extends ChangeNotifier {
  final List<T> itemsView;
  SearchLayoutController() : itemsView = [];

  SearchEnum _typeView = SearchEnum.list;
  SearchEnum get typeView => _typeView;

  String _searchText = '';
  String get searchText => _searchText;

  void onChangeView(SearchEnum searchEnum) {
    _typeView = searchEnum;
    notifyListeners();
  }

  void onTextChange(String text) {
    _searchText = text;
    notifyListeners();
  }
}
