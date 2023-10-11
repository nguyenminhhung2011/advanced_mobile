import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_topic/course_topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/course_detail/bloc/course_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/appbar.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
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

  EdgeInsets get _horizontalPadding =>
      const EdgeInsets.symmetric(horizontal: 10.0);

  TextStyle get _headerStyle =>
      context.titleLarge.copyWith(fontWeight: FontWeight.w600);

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
              if (sS1.data == null) {
                return const SizedBox();
              }
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
          expandedHeight: context.heightDevice * 0.3,
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
            <Widget>[
              HeaderTextCustom(
                headerText: course.name,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                textStyle: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                  color: _primaryColor,
                ),
              ),
              Padding(
                padding: _horizontalPadding,
                child: Text(course.description, style: context.titleMedium),
              ),
              const SizedBox(height: 20.0),
              HeaderTextCustom(
                headerText: S.of(context).overview,
                textStyle: _headerStyle,
                padding: _horizontalPadding,
              ),
              const SizedBox(height: 10.0),
              ..._overViewField(course)
                  .expand((e) => [e, const SizedBox(height: 10.0)]),
              _renderHeaderTitle(
                  renderHeader: S.of(context).experienceLevel,
                  renderText: (course.level ?? '0').renderExperienceText),
              _timeField(course),
              const SizedBox(height: 10.0),
              HeaderTextCustom(
                  headerText: S.of(context).allLevels, textStyle: _headerStyle),
              const SizedBox(height: 10.0),
              ...course.topics
                  .map(
                    (topic) => _courseTopicBuilder(courseTopicModel: topic),
                  )
                  .expand((e) => [e, const SizedBox(height: 5.0)])
            ],
          ),
        ),
      ],
    );
  }

  Iterable<Column> _overViewField(Course course) {
    return [
      course.reason ?? '',
      course.purpose ?? '',
    ].mapIndexed((index, element) {
      final renderHeader =
          index == 0 ? S.of(context).whatTTCourses : S.of(context).whatWYBe;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTextCustom(
            headerText: renderHeader,
            padding: _horizontalPadding,
            textStyle:
                context.titleMedium.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50.0,
                child:
                    Icon(Icons.question_mark, color: _primaryColor, size: 20.0),
              ),
              Expanded(
                child: Text(
                  element,
                  style: context.titleMedium.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  Widget _courseTopicBuilder({required CourseTopic courseTopicModel}) {
    return GestureDetector(
      onTap: () {
        if (courseTopicModel.nameFile?.isNotEmpty ?? false) {
          context.openPageWithRouteAndParams(
              Routes.pdfView, courseTopicModel.nameFile);
        }
      },
      child: Container(
        margin: _horizontalPadding,
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${courseTopicModel.orderCourse} ${courseTopicModel.name}',
                style:
                    context.titleMedium.copyWith(fontWeight: FontWeight.w600)),
            if (courseTopicModel.description.isNotEmpty)
              Text(courseTopicModel.description),
          ],
        ),
      ),
    );
  }

  Container _timeField(Course course) {
    return Container(
      margin: _horizontalPadding,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          ...<DateTime>[
            course.createdAt ?? DateTime.now(),
            course.updatedAt ?? DateTime.now()
          ]
              .mapIndexed((index, e) {
                final renderHeader = index == 0
                    ? S.of(context).createdAt
                    : S.of(context).updatedAt;
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        renderHeader,
                        style: context.titleMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4.0),
                      Text(getMMMMEEEd(e), style: context.titleSmall),
                    ],
                  ),
                );
              })
              .expand((e) => [e, const SizedBox(width: 5.0)])
              .toList()
            ..removeLast(),
        ],
      ),
    );
  }

  Column _renderHeaderTitle(
      {required String renderHeader, required String renderText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTextCustom(
          headerText: renderHeader,
          textStyle: _headerStyle,
          padding: _horizontalPadding,
        ),
        Padding(
          padding: _horizontalPadding,
          child: Text(
            renderText,
            style: context.titleMedium.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
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
