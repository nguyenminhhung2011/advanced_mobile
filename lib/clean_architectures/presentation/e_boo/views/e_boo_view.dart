import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/e_boo/bloc/e_boo_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/content_category_bottom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/e_boo_item.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/not_found_field.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/row_search_field.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/default_pagination.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class EBooScreen extends StatefulWidget {
  const EBooScreen({super.key});

  @override
  State<EBooScreen> createState() => _EBooScreenState();
}

class _EBooScreenState extends State<EBooScreen> {
  EBooBloc get _bloc => BlocProvider.of<EBooBloc>(context);

  Object? listen;

  Color get _primaryColor => Theme.of(context).primaryColor;

  Color get _backGroundColor => Theme.of(context).scaffoldBackgroundColor;

  @override
  void initState() {
    super.initState();
    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.getEBoo(null, null);
  }

  void _openSelectedFilter() async {
    final getCategories = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return CourseCategoryUi(eBloc: _bloc);
        // return const SizedBox();
      },
    );
    if (getCategories is String) {
      _bloc.getEBoo(null, getCategories);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: _bloc.loading$,
      builder: (ctx, sS) {
        final loading = sS.data ?? false;
        return Stack(
          children: [
            _body(context, loading: loading),
            if (loading)
              Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _loading(),
              )
          ],
        );
      },
    );
  }

  Scaffold _body(BuildContext context, {required bool loading}) {
    return Scaffold(
      backgroundColor: _backGroundColor,
      appBar: AppBar(
        backgroundColor: _backGroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
        ),
        title: Text(
          S.of(context).allEBoo,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _bloc.refreshItem(),
        child: Column(
          children: [
            RowSearchField(
              onSubmit: (text) => _bloc.getEBoo(text, null),
              openSelectedFilter: _openSelectedFilter,
            ),
            Expanded(
              child: StreamBuilder<Pagination<EBoo>>(
                stream: _bloc.eBoo$,
                builder: (ctx, sS) {
                  final listEBoo =
                      sS.data?.rows ?? List<EBoo>.empty(growable: true);
                  if (listEBoo.isEmpty && !loading) {
                    return const NotFoundField();
                  }
                  return DefaultPagination(
                    items: listEBoo,
                    loading: false,
                    itemBuilder: (_, index) => EBooItem(item: listEBoo[index]),
                    listenScrollBottom: () => _bloc.getEBoo(null, null),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: _primaryColor),
    );
  }

  Stream handleState(state) async* {
    if (state is GetEBooSuccess) {
      log("🌟[Get E boo] success");
      return;
    }
    if (state is GetEBooFailed) {
      log("🌟${state.toString()}");
      return;
    }
  }
}
