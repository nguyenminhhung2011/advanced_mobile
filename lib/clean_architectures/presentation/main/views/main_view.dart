import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/bloc/main_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/bloc/main_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/views/welcome_text.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  Color get _primaryColor => Theme.of(context).primaryColor;

  MainBloc get _bloc => BlocProvider.of<MainBloc>(context);

  Object? listen;

  @override
  void initState() {
    super.initState();

    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.getTopTutors();

    _bloc.getTopCourse();
  }

  Stream handleState(state) async* {
    if (state is GetTopTutorFailed) {
      context.showSnackBar("🐛[Get top tutors error] ${state.toString()}");
      return;
    }
    if (state is GetTopTutorSuccess) {
      log("🌟[Get top tutors] Get top tutors success");
      return;
    }
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
              ' letTutor',
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _bloc.getTopTutors();
          _bloc.getTopCourse();
        },
        child: ListView(children: [
          const WelcomeText(),
          _bannerField(context),
          const SizedBox(height: 15.0),
          ...['👨‍🏫 Top tutors', '💻 Recommend courses', '📖 Free eBook']
              .mapIndexed(
            (index, e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTextCustom(
                  headerText: e,
                  isShowSeeMore: true,
                  onPress: () {},
                  textStyle: context.titleMedium
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 17.0),
                ),
                switch (index) {
                  0 => _renderTutorField(),
                  1 => _renderCourseField(),
                  _ => const SizedBox(),
                },
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ]
            // .expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
            ),
      ),
    );
  }

  Padding _bannerField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
              height: context.heightDevice * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _primaryColor.withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getMMMMEEEd(DateTime.now()),
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  ...[
                    "Free eBook material",
                    "Free one to one with tutors",
                    "Free courses with pdf material",
                  ].map(
                    (e) => Text(
                      '🐼 $e',
                      style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ].expand((e) => [e, const SizedBox(height: 2.0)]).toList()
                  ..removeLast(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              ImageConst.bannerImage,
              height: context.heightDevice * 0.20,
            ),
          )
        ],
      ),
    );
  }

  Widget _renderCourseField() {
    return StreamBuilder(
      stream: _bloc.loadingGetCourse,
      builder: (ctx, sS) {
        final loading = sS.data ?? false;
        if (loading) {
          return RenderWaitToFetchData(
            expandIndicator: const <int>[1],
            height: 220,
            widthItem: context.widthDevice * 0.4,
          );
        }
        return StreamBuilder(
          stream: _bloc.courses$,
          builder: (ctx1, sS1) {
            final courses = sS1.data;
            if (courses?.isNotEmpty ?? false) {
              return SizedBox(
                width: double.infinity,
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses!.length + 1,
                  itemBuilder: (_, index) {
                    if (index == courses.length) {
                      return const SizedBox();
                    }
                    final data = courses[index];
                    return CourseHorizontalItem(
                        course: data, isFirstItem: index == 0);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }

  Widget _renderTutorField() {
    return StreamBuilder(
      stream: _bloc.loadingGetTutors,
      builder: (ctx, sS) {
        final loading = sS.data ?? false;
        if (loading) {
          return RenderWaitToFetchData(
            expandIndicator: const <int>[1, 3, 1],
            height: 210,
            widthItem: context.widthDevice * 0.55,
          );
        }
        return StreamBuilder(
          stream: _bloc.tutors$,
          builder: (ctx1, sS1) {
            final tutors = sS1.data;
            if (tutors?.isNotEmpty ?? false) {
              return SizedBox(
                width: double.infinity,
                height: 210,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tutors!.length + 1,
                    itemBuilder: (_, index) {
                      if (index == tutors.length) {
                        return const SizedBox();
                      }
                      final data = tutors[index];
                      return TutorVerticalItem(
                          data: data, isFirstItem: index == 0);
                    }),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class CourseHorizontalItem extends StatelessWidget {
  final Course course;

  final bool isFirstItem;
  const CourseHorizontalItem({
    super.key,
    required this.course,
    required this.isFirstItem,
  });

  EdgeInsetsGeometry get _margin => EdgeInsets.only(
      left: isFirstItem ? 10 : 0, right: 10.0, top: 10.0, bottom: 10.0);

  BorderRadiusGeometry get _radius => BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.widthDevice * 0.4,
          height: double.infinity,
          margin: _margin,
          decoration: BoxDecoration(
            borderRadius: _radius,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 5.0,
              )
            ],
            image: DecorationImage(
              image: NetworkImage(course.imageUrl ?? ImageConst.baseImageView),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: context.widthDevice * 0.4,
          height: double.infinity,
          padding: const EdgeInsets.all(10.0),
          margin: _margin,
          decoration:
              BoxDecoration(borderRadius: _radius, color: Colors.black26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(
                flex: 1,
                child: Text(
                  course.name,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  course.description,
                  style: context.titleSmall.copyWith(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 10.0,
          left: isFirstItem ? 10.0 : 0.0,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            child: Text(
              (course.level ?? '0').renderExperienceText,
              style: context.titleSmall.copyWith(color: Colors.white, fontSize: 11.0),
            ),
          ),
        ),
      ],
    );
  }
}

class TutorVerticalItem extends StatelessWidget {
  const TutorVerticalItem({
    super.key,
    required this.data,
    required this.isFirstItem,
  });
  final bool isFirstItem;

  final Tutor data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.openPageWithRouteAndParams(Routes.tutorDetail, data.userId),
      child: Container(
        width: context.widthDevice * 0.55,
        margin: EdgeInsets.only(
            left: isFirstItem ? 10 : 0, right: 10.0, top: 10.0, bottom: 10.0),
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ImageCustom(
                      imageUrl: data.avatar ?? ImageConst.baseImageView,
                      isNetworkImage: true,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.name ?? '', style: context.titleSmall),
                        RattingWidgetCustom(
                            rating: data.rating ?? 0.0, itemSize: 10.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              flex: 3,
              child: Text(
                data.bio ?? '',
                maxLines: 6,
                style: context.titleSmall
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12.0),
              ),
            ),
            Divider(color: Theme.of(context).primaryColor, thickness: 0.3),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        data.level?.toLowerCase() ?? 'Unknown',
                        style: context.titleSmall
                            .copyWith(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Validator.countryCodeValid(data.country)
                        ? Text(
                            CountryCode.fromCountryCode(
                                  data.country!.toUpperCase(),
                                ).name ??
                                '',
                            style: context.titleSmall.copyWith(fontSize: 12.0),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RenderWaitToFetchData extends StatelessWidget {
  final List<int> expandIndicator;
  final double height;
  final double widthItem;
  const RenderWaitToFetchData({
    super.key,
    required this.expandIndicator,
    required this.height,
    required this.widthItem,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 10.0),
          for (var i = 0; i < 4; i++)
            Container(
              width: widthItem,
              height: double.infinity,
              padding: const EdgeInsets.all(5.0),
              margin:
                  const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 5.0,
                  )
                ],
              ),
              child: Column(
                children: [
                  ...expandIndicator
                      .map(
                        (e) => Expanded(
                          flex: e,
                          child: SkeletonContainer.circular(
                            borderRadius: BorderRadius.circular(5.0),
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      )
                      .expand((e) => [e, const SizedBox(height: 5.0)])
                      .toList()
                    ..removeLast()
                ],
              ),
            ),
        ],
      ),
    );
  }
}
