import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/expansion_panel_list/expansion_panel_list.dart';

class ExpansionNotifier<T, B> extends ChangeNotifier {
  final List<T> preItem;
  final BodyLoad<B> loadBody;
  final List<String> listId;
  ExpansionNotifier({
    required this.preItem,
    required this.loadBody,
    required this.listId,
  });

  final List<int> _loading = <int>[];
  List<int> get loading => _loading;

  final List<ExpansionModel<T, B>> _listExpansion = <ExpansionModel<T, B>>[];
  List<ExpansionModel<T, B>> get listExpansion => _listExpansion;

  void generateExpansionData() {
    _listExpansion.addAll(
        preItem.mapIndexed((index, e) => ExpansionModel<T, B>(data: e)));
    notifyListeners();
  }

  Future<void> getBodyData(int index) async {
    _loading.add(index);
    notifyListeners();
    final load = await loadBody(index);
    _listExpansion[index].bodyData = load;
    _loading.removeWhere((element) => element == index);
    notifyListeners();
  }

  void onSelected(int index, bool isExpanded){
    _listExpansion[index].isExpanded = !isExpanded;
    notifyListeners();
  }
}
