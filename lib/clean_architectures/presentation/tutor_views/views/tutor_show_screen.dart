import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_views/bloc/tutor_show_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/tutor_view_card.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:timer_count_down/timer_count_down.dart';

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
    listen ??= _bloc.state$.flatMap(handleState).collect();
    _bloc.fetchData();
    _bloc.getTotalTime();
    _bloc.getUpComingClass();
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

    // dom something
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: _bloc.favoriteMode$,
      builder: (context, snapShot) {
        final isFavoriteMode = snapShot.data ?? false;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.school, color: _primaryColor),
                Text(
                  ' ${S.of(context).tutor}',
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      context.openListPageWithRoute(Routes.searchTutor),
                  icon: Icon(Icons.search, color: Theme.of(context).hintColor),
                ),
                IconButton(
                  onPressed: () => _bloc.changeFavoriteMode(),
                  icon: Icon(
                    Icons.favorite_outline,
                    color: isFavoriteMode
                        ? Colors.red
                        : Theme.of(context).hintColor,
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              _headerField(),
              const SizedBox(height: 10.0),
              Expanded(
                child: StreamBuilder(
                  stream: _bloc.tutor$,
                  builder: (ctx1, snapShot) {
                    var listItem = (snapShot.data?.tutors.rows ?? <Tutor>[])
                        as List<Tutor>;
                    final fav = snapShot.data?.fav ?? <String>[];
                    if (isFavoriteMode) {
                      listItem = listItem
                          .where((element) => fav.contains(element.userId))
                          .toList();
                    }
                    return StreamBuilder<bool?>(
                      stream: _bloc.loading$,
                      builder: (ctx2, snapShot2) {
                        return RefreshIndicator(
                          onRefresh: () async => _bloc.onRefreshData(),
                          child: _listView(
                            fav: fav,
                            listItem: listItem,
                            loading: snapShot2.data ?? false,
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _headerField() => StreamBuilder(
        stream: _bloc.loadingHeader$,
        builder: (ctx, sS) {
          final loading = sS.data ?? false;
          if (loading) {
            return CircularProgressIndicator(color: _primaryColor);
          }
          return GestureDetector(
            onTap: () => _bloc.openBeforeMeeting(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: _primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<BooInfo?>(
                    stream: _bloc.upComingClass$,
                    builder: (ctx1, sS1) {
                      final booInfo = sS1.data;
                      if (booInfo == null) {
                        return Text(
                          S.of(context).donHaveAnyUpcoming,
                          style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        );
                      }
                      final referencesTime = booInfo.scheduleDetailInfo!
                              .startPeriodTimestamp.millisecondsSinceEpoch /
                          1000;
                      final currentTime = Constant.currentTimeMilliSeconds;
                      if (currentTime > referencesTime) {
                        return const SizedBox();
                      }
                      return Countdown(
                        seconds: (referencesTime - currentTime).round(),
                        build: (BuildContext context, double time) {
                          int hours = time.round() ~/ 3600;
                          int minutes = (time.round() % 3600) ~/ 60;
                          int seconds = time.round() % 60;
                          return _renderRichText(hours, minutes, seconds,
                              header:
                                  '${S.of(context).upComingLessonsWillAppear} ');
                        },
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {
                          _bloc.getUpComingClass();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  StreamBuilder(
                    stream: _bloc.learningTotalTime$,
                    builder: (ctx1, sS1) {
                      final data = ((sS1.data ?? 100)).round();

                      int hours = data ~/ 60;
                      int minutes = data % 60;
                      return _renderRichText(hours, minutes, null,
                          header: '${S.of(context).totalLessonsTimesIs} ');
                    },
                  )
                ],
              ),
            ),
          );
        },
      );

  RichText _renderRichText(int hours, int minutes, int? seconds,
      {required String header}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.titleMedium.copyWith(color: Colors.white),
        children: [
          ...[
            header,
            hours.toString(),
            ' ${S.of(context).hours} ${S.of(context).and} ',
            minutes.toString(),
            ' ${S.of(context).minutes} ',
            if (seconds != null) ...[
              seconds.toString(),
              ' ${S.of(context).seconds}.'
            ],
          ].mapIndexed((index, element) {
            final textStyle = TextStyle(
              fontWeight: index % 2 == 0 ? FontWeight.w400 : FontWeight.w600,
            );
            return TextSpan(text: element, style: textStyle);
          }),
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
            tutorOnPress: () => context.openPageWithRouteAndParams(
                Routes.tutorDetail, tutor.userId),
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
    if (state is GetTotalTimeFailed) {
      log('[Get total time failed] ${state.message}');
      return;
    }
    if (state is GetTotalTimeSuccess) {
      log('[Get total time success] Success');
      return;
    }
    if (state is OpenBeforeMeetingViewSuccess) {
      context.openPageWithRouteAndParams(Routes.beforeMeeting, state.args);
      return;
    }
  }
}
