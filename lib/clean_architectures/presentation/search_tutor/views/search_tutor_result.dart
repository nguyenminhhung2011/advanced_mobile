import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_result_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/not_found_field.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/tutor_view_card.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/default_pagination.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class SearchTutorResultView extends StatefulWidget {
  const SearchTutorResultView({super.key});

  @override
  State<SearchTutorResultView> createState() => _SearchTutorResultViewState();
}

class _SearchTutorResultViewState extends State<SearchTutorResultView> {
  SearchTutorResultBloc get _bloc =>
      BlocProvider.of<SearchTutorResultBloc>(context);

  Object? listen;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.searchTutor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: Theme.of(context).shadowColor),
        ),
        title: Text(
          S.of(context).searchTutorResult,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: StreamBuilder(
              stream: _bloc.tutor$,
              builder: (ctx1, sS1) {
                final listItem = sS1.data?.tutors.rows ?? <Tutor>[];
                log("🌟 [Data length] ${listItem.length}");
                return StreamBuilder<bool?>(
                    stream: _bloc.loading$,
                    builder: (ctx2, sS2) {
                      final loading = sS2.data ?? false;
                      if (!loading && listItem.isEmpty) {
                        return const NotFoundField();
                      }
                      return DefaultPagination(
                        items: listItem,
                        loading: loading,
                        itemBuilder: (_, index) {
                          final tutor = listItem[index];
                          return TutorViewCard(
                            tutor: tutor,
                            isLiked: true,
                            tutorOnPress: () =>
                                context.openPageWithRouteAndParams(
                                    Routes.tutorDetail, tutor.userId),
                            favOnPress: () {
                              // if (tutor.userId != null) {
                              //   _bloc.addTutorToFav(tutor.userId ?? '');
                              // }
                            },
                          );
                        },
                        listenScrollBottom: _bloc.searchTutor,
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  Stream handleState(state) async* {
    if (state is SearchTutorSuccess) {
      log("🌟 [Search tutor] Success");
      return;
    }
    if (state is SearchTutorFailed) {
      log("🌟 [Search tutor] Failed message ${state.message}");
      return;
    }
  }
}
