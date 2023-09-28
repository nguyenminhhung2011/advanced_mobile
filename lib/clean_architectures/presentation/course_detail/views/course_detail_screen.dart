import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/appbar.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  CourseDetailBloc get _bloc => BlocProvider.of<CourseDetailBloc>(context);

  Object? listen;

  Color get _primaryColor => Theme.of(context).primaryColor;

  Color get _backgroundColor => Theme.of(context).scaffoldBackgroundColor;

  @override
  void initState() {
    super.initState();

    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.getCourseDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: _backgroundColor,
      body: StreamBuilder(
        stream: _bloc.loading$,
        builder: (ctx, sS) {
          final loading = sS.data ?? false;
          if (loading) {
            return _loading();
          }
          return StreamBuilder(
            stream: _bloc.course$,
            builder: (ctx1, sS1) {
              return _mainView(course: sS1.data!);
            },
          );
        },
      ),
    );
  }

  CustomScrollView _mainView({required Course course}) {
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        AppbarCustom(
          pinned: true,
          backgroundColor: Theme.of(context).primaryColor,
          widgeExpanded: ImageCustom(
            imageUrl: course.imageUrl ?? ImageConst.baseImageView,
            isNetworkImage: true,
          ),
          expandedHeight: context.heightDevice * 0.35,
          title: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            const Spacer(),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[const SizedBox(height: 10000)],
          ),
        )
        // ...widget.children.map((e) => e)
      ],
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: _primaryColor),
    );
  }

  Stream handleState(state) async* {
    if (state is GetCourseDetailSuccess) {
      log("🌆[Get course detail] success");
      return;
    }
    if (state is GetCourseDetailFailed) {
      log("🌆${state.toString()}");
      return;
    }
  }
}
