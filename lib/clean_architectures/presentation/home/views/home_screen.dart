import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/content_category_bottom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/course_item.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
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

  Color get _primaryColor => Theme.of(context).primaryColor;

  ScrollController? _scrollController;

  Object? listen;

  BoxDecoration get _boxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(width: 1, color: Theme.of(context).hintColor),
      );

  final _searchController = TextEditingController();

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
        return CourseCategoryUi(bloc: _bloc);
        // return const SizedBox();
      },
    );
    if (getCategories is String) {
      _bloc.applyCategory(getCategories);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.school, color: _primaryColor),
            Text(
              ' Courses',
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                "View e-book",
                style: context.titleSmall.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _searchField(context),
          Expanded(
            child: StreamBuilder(
              stream: _bloc.courses$,
              builder: (ctx1, snapShot) {
                final listItem = snapShot.data?.rows ?? <Course>[];
                return StreamBuilder(
                  stream: _bloc.loading$,
                  builder: (ctx2, snapShot2) {
                    return RefreshIndicator(
                      onRefresh: () async => _bloc.onRefreshData(),
                      child: _listView(
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
  }

  Padding _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: _boxDecoration,
              child: TextField(
                controller: _searchController,
                onSubmitted: (text) => _bloc.submitWithText(text),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here....',
                  contentPadding: EdgeInsets.all(5.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          GestureDetector(
            onTap: _openSelectedFilter,
            child: Container(
              width: 52,
              height: 52,
              decoration: _boxDecoration,
              child: Icon(Icons.grid_view_rounded, color: _primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView({required List<dynamic> listItem, required bool loading}) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _scrollController,
      itemCount: listItem.length + 1,
      itemBuilder: (context, index) {
        if (index < listItem.length) {
          return CourseItem(course: listItem[index]);
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
                  size: 40.0, color: Theme.of(context).primaryColor),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

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
