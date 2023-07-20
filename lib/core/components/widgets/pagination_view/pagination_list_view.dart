import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

import '../skeleton_custom.dart';

enum PaginationViewType { grid, list }

extension PaginationViewTypeExtension on PaginationViewType {
  bool get isGrid => this == PaginationViewType.grid;
  bool get isList => this == PaginationViewType.list;
}

enum TypeIndicatorLoading { circularIndicator, skeltonIndicator }

extension TypeIndicatorLoadingExtension on TypeIndicatorLoading {
  bool get isSkeltonIndicator => this == TypeIndicatorLoading.skeltonIndicator;
  bool get isCircularIndicator =>
      this == TypeIndicatorLoading.circularIndicator;
}

class SkeltonFormat {
  final int countable;
  final double radius;
  final double height;
  final Color? color;
  final List<int> columns;
  final EdgeInsets padding;
  final EdgeInsets margin;
  const SkeltonFormat({
    this.countable = 2,
    this.radius = 10.0,
    this.height = 35,
    this.color,
    this.padding = const EdgeInsets.all(5.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0),
    this.columns = const <int>[1, 3],
  });
}

class GridViewFormat {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  const GridViewFormat({
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
  });
}

typedef PaginationData<T> = Future<List<T>> Function(
    int currentPag, @Default('') String category);

class PaginationViewCustom<T> extends StatefulWidget {
  // preloads list item
  final List<T> items;
  // Pagination type view current support for [list, grid]
  final PaginationViewType paginationViewType;
  // Call after user scroll to bottom
  final PaginationData<T> paginationDataCall;
  // Type loading in bottom currently support for [circular, skelton]
  final TypeIndicatorLoading typeIndicatorLoading;
  // Controller of scroll
  final ScrollController? scrollController;
  // Notifier
  final PaginationNotifier<T>? paginationNotifier;
  //Padding
  final double hPadding;
  final double vPadding;
  // Spacer between item
  final double spacer;
  // Skelton style
  final SkeltonFormat skeltonFormat;
  //Grid view style
  final GridViewFormat gridViewFormat;
  // Color of type loading circular
  final Color circularIndicatorColor;
  // Reverse list
  final bool isReverse;
  final ScrollPhysics physics;
  // Item display
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatedItem;
  //loading when first appear
  final Widget initWidget;
  //limit item per fetch
  final int limitFetch;

  const PaginationViewCustom({
    Key? key,
    this.scrollController,
    this.separatedItem,
    this.hPadding = 0,
    this.vPadding = 0,
    this.spacer = 5,
    this.limitFetch = 10,
    this.isReverse = false,
    this.paginationNotifier,
    this.skeltonFormat = const SkeltonFormat(),
    this.gridViewFormat = const GridViewFormat(),
    this.initWidget = const Center(
      child: CircularProgressIndicator(color: Colors.blue),
    ),
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.circularIndicatorColor = Colors.blue,
    this.paginationViewType = PaginationViewType.list,
    this.typeIndicatorLoading = TypeIndicatorLoading.circularIndicator,
    required this.paginationDataCall,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<PaginationViewCustom<T>> createState() =>
      _PaginationViewCustomState<T>();
}

class _PaginationViewCustomState<T> extends State<PaginationViewCustom<T>> {
  ScrollController? _scrollController;
  PaginationNotifier<T>? _paginationNotifier;

  @override
  void initState() {
    super.initState();
    _paginationNotifier = widget.paginationNotifier ??
        PaginationNotifier<T>(widget.paginationDataCall, widget.items)
      ..fetchPaginationItems(widget.limitFetch);
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController!.addListener(_listenerScroll);
  }

  void _listenerScroll() {
    // print(_scrollController!.position.pixels);
    // if (_scrollController!.position.atEdge) {
    //   print('Hung');
    //   if (_scrollController!.position.pixels != 0) {
    //     _paginationNotifier!.fetchPaginationItems(widget.limitFetch);
    //   }
    // }
    if ((_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent)) {
      _paginationNotifier!.fetchPaginationItems(widget.limitFetch);
    }
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController!.removeListener(_listenerScroll);
      _scrollController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _paginationNotifier!,
      child: Consumer<PaginationNotifier<T>>(
        builder: (context, modal, _) {
          if (modal.preloadedItems.isEmpty && modal.loading) {
            return widget.initWidget;
          }
          return MediaQuery.removePadding(
            context: context,
            child: widget.paginationViewType.isList
                ? _listPaginationView(modal.loading)
                : _gridPaginationView(modal.loading),
          );
        },
      ),
    );
  }

  Widget _listPaginationView(bool loading) {
    final listItem = _paginationNotifier?.preloadedItems ?? <T>[];
    final itemCount = listItem.length +
        (loading
            ? widget.typeIndicatorLoading.isCircularIndicator
                ? 1
                : widget.skeltonFormat.countable
            : 0);
    if (listItem.isEmpty) {
      return const SizedBox();
    }
    return ListView.separated(
      physics: widget.physics,
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
        vertical: widget.vPadding,
      ),
      reverse: widget.isReverse,
      controller: _scrollController,
      separatorBuilder:
          widget.separatedItem ?? (context, index) => const Divider(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < listItem.length) {
          return widget.itemBuilder(context, listItem[index], index);
        } else if (index >= listItem.length && loading) {
          Timer(const Duration(milliseconds: 30), () {
            _scrollController!.jumpTo(
              _scrollController!.position.maxScrollExtent,
            );
          });
          return _loadingBottom();
        }
        return const SizedBox();
      },
    );
  }

  Widget _gridPaginationView(bool loading) {
    final listItem = _paginationNotifier?.preloadedItems ?? <T>[];
    final gridViewFormation = widget.gridViewFormat;
    final itemCount = listItem.length +
        (loading
            ? widget.typeIndicatorLoading.isCircularIndicator
                ? widget.skeltonFormat.countable
                : gridViewFormation.crossAxisCount
            : 0);
    if (listItem.isEmpty) {
      return const SizedBox();
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding,
        vertical: widget.vPadding,
      ),
      controller: _scrollController,
      physics: widget.physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridViewFormation.crossAxisCount,
        mainAxisSpacing: gridViewFormation.mainAxisSpacing,
        crossAxisSpacing: gridViewFormation.crossAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < listItem.length) {
          return widget.itemBuilder(context, listItem[index], index);
        } else if (index >= listItem.length && loading) {
          Timer(const Duration(milliseconds: 30), () {
            _scrollController!.jumpTo(
              _scrollController!.position.maxScrollExtent,
            );
          });
          return _loadingBottom();
        }
        return const SizedBox();
      },
    );
  }

  Widget _loadingBottom() {
    if (widget.typeIndicatorLoading == TypeIndicatorLoading.circularIndicator) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Center(
          child: CircularProgressIndicator(
            color: widget.circularIndicatorColor,
          ),
        ),
      );
    } else {
      SkeltonFormat format = widget.skeltonFormat;
      if (widget.paginationViewType.isGrid) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: format.padding,
          decoration: BoxDecoration(
            color: format.color ?? Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(format.radius),
          ),
          child: Column(
            children: [
              ...format.columns.map(
                (e) => Expanded(
                  flex: e,
                  child: SkeletonContainer.rounded(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.circular(format.radius),
                  ),
                ),
              )
            ]
                .expand((element) => [element, const SizedBox(height: 5.0)])
                .toList()
              ..removeLast(),
          ),
        );
      }
      return Container(
        margin: format.margin,
        width: double.infinity,
        padding: format.padding,
        decoration: BoxDecoration(
          color: format.color ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(format.radius),
        ),
        child: Row(
          children: [
            ...format.columns.map(
              (e) => Expanded(
                flex: e,
                child: SkeletonContainer.rounded(
                  width: double.infinity,
                  height: format.height,
                  borderRadius: BorderRadius.circular(format.radius),
                ),
              ),
            )
          ].expand((element) => [element, const SizedBox(width: 5.0)]).toList()
            ..removeLast(),
        ),
      );
    }
  }
}
