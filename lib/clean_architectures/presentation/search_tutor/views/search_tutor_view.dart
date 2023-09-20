import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/search_tutor/bloc/search_tutor_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class SearchTutorScreen extends StatefulWidget {
  const SearchTutorScreen({super.key});

  @override
  State<SearchTutorScreen> createState() => SearchTutorScreenState();
}

class SearchTutorScreenState extends State<SearchTutorScreen> {
  SearchTutorBloc get _bloc => BlocProvider.of<SearchTutorBloc>(context);

  Object? listen;

  Color get _primaryColor => Theme.of(context).primaryColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listen ??= _bloc.state$.flatMap(handleState).collect();
    _bloc.fetchTopicsData();
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
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).shadowColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          const HeaderTextCustom(headerText: "Nationality"),
          const HeaderTextCustom(headerText: "Topics"),
          StreamBuilder<bool?>(
            stream: _bloc.loading$,
            builder: (ctx1, sS1) {
              final loading = sS1.data ?? false;
              if (loading) {
                return Center(
                  child: StyleLoadingWidget.foldingCube
                      .renderWidget(size: 40.0, color: _primaryColor),
                );
              }
              return StreamBuilder<List<Topic>>(
                stream: _bloc.topics$,
                builder: (ctx2, sS2) {
                  final topics = sS2.data ?? <Topic>[];
                  return StreamBuilder<List<Topic>>(
                    stream: _bloc.topicSelected$,
                    builder: (ctx3, sS3) {
                      final topicSelected = sS3.data ?? <Topic>[];
                      return _topicsField(
                        topics: topics,
                        topicsSelected: topicSelected,
                      );
                    },
                  );
                },
              );
            },
          ),
        ].expand((e) => [e, const SizedBox(height: 5.0)]).toList(),
      ),
    );
  }

  Padding _topicsField(
      {required List<Topic> topics, required List<Topic> topicsSelected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Wrap(
        spacing: 6.0,
        runSpacing: -8,
        alignment: WrapAlignment.start,
        verticalDirection: VerticalDirection.up,
        children: [
          ...topics.map((e) {
            final isSelected = topicsSelected.contains(e);
            return ChoiceChip(
              label: Text(
                e.name ?? '',
                style: context.titleSmall.copyWith(
                  fontSize: 14,
                  color: isSelected ? _primaryColor : null,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              avatar: isSelected
                  ? Icon(Icons.check, color: _primaryColor, size: 15.0)
                  : null,
              selected: isSelected,
              onSelected: (_) => _bloc.selectedTopic(e),
              backgroundColor: Theme.of(context).dividerColor.withOpacity(0.07),
              selectedColor: _primaryColor.withOpacity(0.1),
            );
          })
        ],
      ),
    );
  }

  Stream handleState(state) async* {
    if (state is FetchTopicsFailed) {
      log("🐼 [Fetch topic] failed");
      return;
    }
    if (state is FetchTopicsSuccess) {
      log("🐼 [Fetch topic] success");
      return;
    }
  }
}
