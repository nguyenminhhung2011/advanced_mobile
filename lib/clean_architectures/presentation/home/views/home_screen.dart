import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
// import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
// import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';
// import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
// import 'package:flutter_base_clean_architecture/core/components/widgets/pagination_view/pagination_list_view.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DidChangeDependencies {
  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);
  ScrollController? _scrollController;

  Object? listen;

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
              stream: _bloc.courses$,
              builder: (ctx1, snapShot) {
                final listItem = snapShot.data?.rows ?? <Course>[];
                return StreamBuilder(
                  stream: _bloc.loading$,
                  builder: (ctx2, snapShot2) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      controller: _scrollController,
                      itemCount: listItem.length,
                      itemBuilder: (context, index) {
                        if (index < listItem.length) {
                          return _itemBuilder(listItem[index]);
                        }
                        if (index >= listItem.length &&
                            (snapShot2.data ?? false)) {
                          Timer(const Duration(milliseconds: 30), () {
                            _scrollController!.jumpTo(
                              _scrollController!.position.maxScrollExtent,
                            );
                          });
                          return const CircularProgressIndicator();
                        }
                        return const SizedBox();
                      },
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

  Container _itemBuilder(Course course) => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: ImageCustom(
                imageUrl: course.imageUrl ?? ImageConst.baseImageView,
                isNetworkImage: true,
                width: 100,
                height: 100,
                loadingWidget: SkeletonContainer.rounded(
                  width: 100,
                  height: 100,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: context.titleMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    course.description,
                    style: context.titleSmall
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Text(
                        'Levels',
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        ' ${course.level} . ${course.topics.length} topics',
                        style: context.titleSmall
                            .copyWith(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
                  ..removeLast(),
              ),
            )
          ],
        ),
      );

  Stream<void> handleState(state) async* {
    if (state is FetchDataCourseFailed) {
      log('[Fetch data course] ${state.message}');
      return;
    }
    if (state is FetchDataCourseSuccess) {
      log('[Fetch data success] ${state.message}');
      return;
    }
  }
}
