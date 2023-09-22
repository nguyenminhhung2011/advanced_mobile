import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';

class DefaultPagination<T> extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final List<T> items;
  final bool loading;
  final Function() listenScrollBottom;

  final ScrollPhysics? physics;
  final Widget? loadingWidget;

  const DefaultPagination({
    super.key,
    this.physics,
    this.loadingWidget,
    required this.items,
    required this.loading,
    required this.itemBuilder,
    required this.listenScrollBottom,
  });

  @override
  State<DefaultPagination<T>> createState() => _DefaultPaginationState<T>();
}

class _DefaultPaginationState<T> extends State<DefaultPagination<T>> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_listenScroll);
  }

  void _listenScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        widget.listenScrollBottom();
      }
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_listenScroll);
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics ??
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      controller: _scrollController,
      itemCount: widget.items.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.items.length) {
          return widget.itemBuilder(context, index);
        }
        if (index >= widget.items.length && (widget.loading)) {
          Timer(const Duration(milliseconds: 30), () {
            _scrollController!.jumpTo(
              _scrollController!.position.maxScrollExtent,
            );
          });
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: widget.loadingWidget ??
                Center(
                  child: StyleLoadingWidget.foldingCube.renderWidget(
                      size: 40.0, color: Theme.of(context).primaryColor),
                ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
