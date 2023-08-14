import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_notifier.dart';
import 'package:provider/provider.dart';
import '../controller/search_controller.dart';
import '../header_search/header_search.dart';
import '../model/filter_model.dart';
import '../model/filter_response.dart';
import '../model/search_utils.dart';

typedef SearchCall<T> = Future<List<T>> Function(
    String value, List<FilterResponse> filter, int currentPage);

class GroupHeaderStyle {
  final String hintText;
  final double searchRadius;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final List<String> headerColors;
  final List<FilterModel> listFilter;
  final EdgeInsets? contentHeaderSearchPadding;
  const GroupHeaderStyle({
    this.textStyle,
    this.hintStyle,
    this.hintText = 'Search',
    this.searchRadius = 10.0,
    this.contentHeaderSearchPadding,
    this.listFilter = const <FilterModel>[],
    this.headerColors = const ["992195F3", "CA2195F3"],
  });
}

class PaginationStyle {
  final int limit;
  const PaginationStyle({
    this.limit = 10,
  });
}

class SearchLayout<T> extends StatefulWidget {
  final bool isReverse;
  final bool shrinkWrap;
  final bool leadingAuto;
  final EdgeInsets? padding;
  final SearchCall<T> searchCall;
  final ScrollPhysics scrollPhysics;
  final PaginationStyle paginationStyle;
  final GroupHeaderStyle groupHeaderStyle;
  final Widget Function(BuildContext, T) itemBuilder;
  final SearchLayoutController<T>? searchLayoutController;
  const SearchLayout({
    super.key,
    this.padding,
    this.shrinkWrap = true,
    this.isReverse = false,
    this.leadingAuto = false,
    this.searchLayoutController,
    this.paginationStyle = const PaginationStyle(),
    this.groupHeaderStyle = const GroupHeaderStyle(),
    this.scrollPhysics = const BouncingScrollPhysics(),
    required this.itemBuilder,
    required this.searchCall,
  });

  @override
  State<SearchLayout<T>> createState() => _SearchLayoutState<T>();
}

class _SearchLayoutState<T> extends State<SearchLayout<T>>
    with SingleTickerProviderStateMixin {
  late PaginationNotifier<T> _paginationNotifier;
  late TextEditingController _searchTextController;
  late SearchLayoutController<T> _searchController;

  //Data

  //style
  Color get backgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  void initState() {
    _paginationNotifier = PaginationNotifier<T>(
      (currentPage, category) async => paginationCall(currentPage: currentPage),
      List.empty(),
    );
    _searchController = SearchLayoutController<T>(searchCall: widget.searchCall)
      ..onGetRecommendSearch();
    _searchTextController = TextEditingController();
    super.initState();
  }
  // pagination function

  Future<List<T>> paginationCall({required int currentPage}) async {
    return await _searchController.onSearch(currentPage: currentPage);
  }

  void _onRefreshPagination() {
    _paginationNotifier.refreshItems(widget.paginationStyle.limit);
  }

  ////////////////////////

  void _onSubmitted(String text) {
    if (text.isEmpty) {
      return;
    }
    _searchController.onSetNewRecommendSearch(text);
    _onRefreshPagination();
  }

  void _onRemoveRecommendSearch(String textRemove) {
    _searchController.onRemoveRecommendSearch(textRemove);
  }

  void _onSelectedRecommendText(String text) {
    _searchTextController.text = text;
  }

  void _onTextChange(String text) {
    _searchController.onTextChange(text);
    if (text.isNotEmpty) {
      _onRefreshPagination();
    }
  }

  void _onFilterCall(List<FilterResponse> listFilters) {
    _searchController.onApplyFilter(listFilters);
    _onRefreshPagination();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
    final recommendSearch = searchLayoutController.recommendSearch;
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      bottomNavigationBar: Row(
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
            textChange: _onTextChange,
            filterCall: _onFilterCall,
            colors: widget.groupHeaderStyle.headerColors,
            actionIcon: const Icon(Icons.filter_list, color: Colors.white),
            onSubmittedText: _onSubmitted,
            textEditingController: _searchTextController,
            contentPadding: widget.groupHeaderStyle.contentHeaderSearchPadding,
            listFilter: [...widget.groupHeaderStyle.listFilter],
            initResponse: _searchController.listFilterResponse,
          ),
          const SizedBox(height: 10.0),
          if (searchLayoutController.searchText.isNotEmpty)
            ..._displayItemField
          else
            ..._recommendField(recommendSearch),
        ],
      ),
    );
  }

  List<Widget> get _displayItemField {
    return [
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10.0),
            ..._searchController.listFilterResponse.map<Widget>(
              (e) {
                if (e.filterType.isCompare) {
                  if (e.compareSelected?.isEmpty ?? false) {
                    return const SizedBox();
                  }
                  return Row(
                    children: [
                      ...e.compareSelected!.map((e) => _filterItem(title: e))
                    ]
                        .expand(
                          (e) => [e, const SizedBox(width: 10.0)],
                        )
                        .toList()
                      ..removeLast(),
                  );
                }
                return _filterItem(title: SearchUtils.getTextFilter(e));
              },
            )
          ].expand((e) => [e, const SizedBox(width: 10.0)]).toList(),
        ),
      ),
      const Divider(thickness: 0.5),
      Expanded(
        child: RefreshIndicator(
          onRefresh: () async => _onRefreshPagination(),
          child: PaginationViewCustom<T>(
            paginationNotifier: _paginationNotifier,
            paginationDataCall: (currentPage, category) async => <T>[],
            items: const [],
            limitFetch: widget.paginationStyle.limit,
            itemBuilder: (context, data, _) =>
                widget.itemBuilder(context, data),
            physics: widget.scrollPhysics,
            isReverse: widget.isReverse,
            initWidget: Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
            shrinkWrap: widget.shrinkWrap,
          ),
        ),
      ),
    ];
  }

  List<Widget> _recommendField(List<String> recommendSearch) {
    return [
      const SizedBox(height: 5.0),
      if (recommendSearch.isNotEmpty)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.05),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...recommendSearch.map(
                (e) => GestureDetector(
                  onTap: () => _onSelectedRecommendText(e),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(e,
                            style: context.titleSmall.copyWith(
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(2.0),
                        onPressed: () => _onRemoveRecommendSearch(e),
                        icon: const Icon(CupertinoIcons.clear_circled_solid,
                            size: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  Container _changeTypeViewField(
      SearchLayoutController<dynamic> searchLayoutController) {
    bool isSelected(int index) =>
        searchLayoutController.typeView.value == index;
    context.titleLarge.color;

    Color colorSelected(int index) =>
        isSelected(index) ? Colors.white : context.titleLarge.color!;

    return Container(
      width: context.widthDevice * 0.4,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ...SearchUtils.viewType
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: isSelected(index)
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.3),
                                blurRadius: 5.0,
                              )
                            ],
                          )
                        : null,
                    child: Row(
                      children: [
                        Icon((e['icon'] as IconData),
                            color: colorSelected(index), size: 14.0),
                        const SizedBox(width: 5.0),
                        Expanded(
                          child: Text(
                            e['title'].toString(),
                            style: context.titleSmall.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colorSelected(index),
                            ),
                          ),
                        ),
                      ],
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.8, color: primaryColor),
        color: primaryColor.withOpacity(0.1),
      ),
      child: Text(
        title,
        style: context.titleSmall.copyWith(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }

  Widget _renderItem() {
    return const SizedBox();
  }
}
