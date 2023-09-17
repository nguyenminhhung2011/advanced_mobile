import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class TutorShowScreen extends StatefulWidget {
  const TutorShowScreen({super.key});

  @override
  State<TutorShowScreen> createState() => _TutorShowScreenState();
}

class _TutorShowScreenState extends State<TutorShowScreen> {
  TutorShowBloc get _bloc => BlocProvider.of<TutorShowBloc>(context);
  ScrollController? _scrollController;

  Object? listen;

  Color get _primaryColor => Theme.of(context).primaryColor;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(_listenerScroll);
  }

  void _listenerScroll() {
    if (_scrollController!.position.atEdge) {
      if (_scrollController!.position.pixels != 0) {
        _bloc.fetchData();
      }
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    listen ??= _bloc.state$.flatMap(handleState).collect();
    _bloc.fetchData();
    // dom something
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: StreamBuilder(
              stream: _bloc.tutor$,
              builder: (ctx1, snapShot) {
                final listItem = snapShot.data?.rows ?? <Tutor>[];
                return StreamBuilder(
                  stream: _bloc.loading$,
                  builder: (ctx2, snapShot2) {
                    return _listView(
                      listItem: listItem,
                      loading: snapShot2.data ?? false,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  ListView _listView({required List<dynamic> listItem, required bool loading}) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      controller: _scrollController,
      itemCount: listItem.length + 1,
      itemBuilder: (context, index) {
        if (index < listItem.length) {
          return _itemBuilder(tutor: listItem[index]);
        }
        if (index >= listItem.length && (loading)) {
          Timer(const Duration(milliseconds: 30), () {
            _scrollController!.jumpTo(
              _scrollController!.position.maxScrollExtent,
            );
          });
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: StyleLoadingWidget.foldingCube.renderWidget(
                  size: 40.0, color: _primaryColor),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Container _itemBuilder({required Tutor tutor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              blurRadius: 5.0)
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: ImageCustom(
                  imageUrl: tutor.avatar ?? ImageConst.baseImageView,
                  isNetworkImage: true,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.name ?? '',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    RattingWidgetCustom(rating: tutor.rating ?? 0.0)
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.red,
                ),
              )
            ],
          ),
          if (tutor.specialties != null)
            Wrap(
              children: [
                ...tutor.specialties!.split(',').map(
                      (e) => Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              _primaryColor.withOpacity(0.2),
                        ),
                        child: Text(
                          e.replaceAll('-', ' '),
                          style: context.titleSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                    )
              ],
            ),
          Text(
            tutor.bio ?? '',
            style: context.titleSmall.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonCustom(
              borderColor: _primaryColor,
              color: Theme.of(context).cardColor,
              enableWidth: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Books ',
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: _primaryColor,
                    ),
                  ),
                  Icon(Icons.check, color: _primaryColor),
                ],
              ),
              onPress: () {},
            ),
          )
        ].expand((e) => [e, const SizedBox(height: 10.0)]).toList()
          ..removeLast(),
      ),
    );
  }

  Stream<void> handleState(state) async* {
    if (state is FetchDataTutorFailed) {
      log('[Fetch data course] ${state.message}');
      return;
    }
    if (state is FetchDataTutorSuccess) {
      log('[Fetch data success] ${state.message}');
      return;
    }
  }
}
