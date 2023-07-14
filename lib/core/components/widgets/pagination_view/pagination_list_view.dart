import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_notifier.dart';
import 'package:provider/provider.dart';

enum PaginationViewType {
  grid,
  list;

  bool get isGrid => this == PaginationViewType.grid;
  bool get isList => this == PaginationViewType.list;
}

enum TypeIndicatorLoading {
  circularIndicator,
  skeltonIndicator;

  bool get isSkeltonIndicator => this == TypeIndicatorLoading.skeltonIndicator;
  bool get isCircularIndicator =>
      this == TypeIndicatorLoading.circularIndicator;
}

typedef PaginationData<T> = Future<List<T>> Function(
    int limitGet, int currentPage);

class PaginationViewCustom<T> extends StatefulWidget {
  final List<T> items;
  final PaginationViewType paginationViewType;
  final PaginationData<T> paginationDataCall;
  final TypeIndicatorLoading typeIndicatorLoading;
  final ScrollController? scrollController;
  final Widget Function(BuildContext context, T data, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatedItem;
  final double hPadding;
  final double vPadding;
  final double spacer;
  final Color circularIndicatorColor;
  final bool isReverse;
  final ScrollPhysics physics;
  const PaginationViewCustom({
    super.key,
    this.scrollController,
    this.hPadding = 0,
    this.vPadding = 0,
    this.spacer = 5,
    this.isReverse = false,
    this.separatedItem,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.circularIndicatorColor = Colors.blue,
    this.paginationViewType = PaginationViewType.list,
    this.typeIndicatorLoading = TypeIndicatorLoading.circularIndicator,
    required this.paginationDataCall,
    required this.items,
    required this.itemBuilder,
  });

  @override
  State<PaginationViewCustom> createState() => _PaginationViewCustomState();
}

class _PaginationViewCustomState extends State<PaginationViewCustom> {
  ScrollController? _scrollController;
  PaginationNotifier? _paginationNotifier;
  @override
  void initState() {
    super.initState();
    _paginationNotifier = PaginationNotifier(widget.paginationDataCall, [])
      ..fetchPaginationItems();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController!.addListener(_listenerScroll);
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        _paginationNotifier!.fetchPaginationItems();
      }
    }
  }

  @override
  void dispose() {
    if (_scrollController != null) {
      _scrollController!.dispose();
      _scrollController!.removeListener(_listenerScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _paginationNotifier,
      child: Consumer<PaginationNotifier>(
        builder: (context, modal, _) {
          // return CustomScrollView(
          // );
          return switch (widget.paginationViewType) {
            PaginationViewType.list => _listPaginationView(true),
            _ => _gridPaginationView(),
          };
        },
      ),
    );
  }

  Widget _listPaginationView(bool loading) {
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
      itemCount: widget.items.length + (loading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.items.length) {
          return widget.itemBuilder(context, widget.items[index], index);
        } else {
          Timer(const Duration(milliseconds: 30), () {
            _scrollController!.jumpTo(
              _scrollController!.position.maxScrollExtent,
            );
          });
          return _loadingBottom();
        }
      },
    );
  }

  Widget _gridPaginationView() {
    return const SizedBox();
  }

  Widget _loadingBottom() {
    return switch (widget.typeIndicatorLoading) {
      TypeIndicatorLoading.circularIndicator => Center(
          child: CircularProgressIndicator(
            color: widget.circularIndicatorColor,
          ),
        ),
      _ => const SizedBox(),
    };
  }
}
