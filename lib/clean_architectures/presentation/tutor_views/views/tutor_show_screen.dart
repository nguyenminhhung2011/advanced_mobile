import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_state.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/tutor_view_card.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
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
                final listItem = snapShot.data?.tutors.rows ?? <Tutor>[];
                final fav = snapShot.data?.fav ?? <String>[];
                return StreamBuilder<bool?>(
                  stream: _bloc.loading$,
                  builder: (ctx2, snapShot2) {
                    return _listView(
                      fav: fav,
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

  ListView _listView({
    required List<dynamic> listItem,
    required bool loading,
    required List<String> fav,
  }) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      controller: _scrollController,
      itemCount: listItem.length + 1,
      itemBuilder: (context, index) {
        if (index < listItem.length) {
          final Tutor tutor = listItem[index];
          return TutorViewCard(
            tutor: tutor,
            isLiked: fav.contains(tutor.userId),
            favOnPress: () {
              if (tutor.userId != null) {
                _bloc.addTutorToFav(tutor.userId ?? '');
              }
            },
          );
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
              child: StyleLoadingWidget.foldingCube
                  .renderWidget(size: 40.0, color: _primaryColor),
            ),
          );
        }
        return const SizedBox();
      },
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
