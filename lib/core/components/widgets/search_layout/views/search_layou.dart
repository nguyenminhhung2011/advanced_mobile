import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_search/header_search.dart';
import 'package:provider/provider.dart';

import '../controller/search_controller.dart';

typedef TextChangeCall<T> = Future<List<T>> Function(String value);

class GroupHeaderStyle {
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double searchRadius;
  const GroupHeaderStyle({
    this.textStyle,
    this.hintStyle,
    this.hintText = 'Search',
    this.searchRadius = 10.0,
  });
}

class SearchLayout<T> extends StatefulWidget {
  final bool leadingAuto;
  final ScrollPhysics scrollPhysics;
  final EdgeInsets? padding;
  final TextChangeCall<T> textChangeCall;
  final GroupHeaderStyle groupHeaderStyle;
  final SearchLayoutController<T>? searchLayoutController;
  final Widget Function(BuildContext, T) itemBuilder;
  final bool isReverse;
  final bool shrinkWrap;
  const SearchLayout({
    super.key,
    this.padding,
    this.isReverse = false,
    this.shrinkWrap = true,
    this.leadingAuto = false,
    this.searchLayoutController,
    this.groupHeaderStyle = const GroupHeaderStyle(),
    this.scrollPhysics = const BouncingScrollPhysics(),
    required this.itemBuilder,
    required this.textChangeCall,
  });

  @override
  State<SearchLayout<T>> createState() => _SearchLayoutState<T>();
}

class _SearchLayoutState<T> extends State<SearchLayout<T>>
    with SingleTickerProviderStateMixin {
  late SearchLayoutController<T> _searchController;
  late TabController _tabController;

  //Data
  List<T> get _itemViews => _searchController.itemsView;

  //style
  Color get backgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  void initState() {
    _searchController =
        widget.searchLayoutController ?? SearchLayoutController();

    _tabController = TabController(
      animationDuration: const Duration(milliseconds: 300),
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _searchController,
      child: Consumer<SearchLayoutController<T>>(
        builder: (context, modal, child) {
          return _customField(searchLayoutController: modal);
        },
      ),
    );
  }

  Widget _customField({
    required SearchLayoutController<T> searchLayoutController,
  }) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _changeTypeViewField(searchLayoutController),
        ],
      ),
      body: Column(
        children: [
          HeaderSearch(
            hintStyle: widget.groupHeaderStyle.hintStyle,
            textStyle: widget.groupHeaderStyle.textStyle,
            textChange: _searchController.onTextChange,
          ),
          const SizedBox(height: 10.0),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10.0),
                _filterItem(title: 'Filter'),
              ],
            ),
          ),
          Divider(color: primaryColor, thickness: 0.2),
          Expanded(
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: ListView.builder(
                reverse: widget.isReverse,
                physics: widget.scrollPhysics,
                shrinkWrap: widget.shrinkWrap,
                itemCount: _itemViews.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => widget.itemBuilder(
                  context,
                  _itemViews[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _changeTypeViewField(
      SearchLayoutController<dynamic> searchLayoutController) {
    return Container(
      width: context.widthDevice * 0.3,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          ...<Map<String, dynamic>>[
            {'title': 'List', 'icon': const Icon(Icons.list)},
            {'title': 'Grid', 'icon': const Icon(Icons.grid_view_sharp)},
          ]
              .mapIndexed<Widget>(
                (index, e) => GestureDetector(
                  onTap: () {
                    searchLayoutController.onChangeView(
                      index == 0 ? SearchEnum.list : SearchEnum.grid,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 30.0,
                    decoration: searchLayoutController.typeView.value == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.3),
                                blurRadius: 10.0,
                              )
                            ],
                          )
                        : null,
                  ),
                ),
              )
              .expand((e) => [Expanded(child: e)]),
        ],
      ),
    );
  }

  Container _filterItem({required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1, color: primaryColor),
        color: primaryColor.withOpacity(0.3),
      ),
      child: Text(
        title,
        style: context.titleSmall.copyWith(
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
}
