import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';

import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_user_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/report_tutor/views/report_tutor_bottom.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/bottom_view_review.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/video_player.dart';
import 'package:flutter_base_clean_architecture/core/dependency_injection/di.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:readmore/readmore.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class TutorDetailScreen extends StatefulWidget {
  const TutorDetailScreen({super.key});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  TutorDetailBloc get _bloc => BlocProvider.of<TutorDetailBloc>(context);

  Object? listen;

  Color get _primaryColor => Theme.of(context).primaryColor;

  Color get _backgroundColor => Theme.of(context).scaffoldBackgroundColor;

  EdgeInsets get _horizontalEdgeInsets =>
      const EdgeInsets.symmetric(horizontal: 10.0);

  Widget favIcon(bool isLiked) =>
      Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.white);
  @override
  void initState() {
    super.initState();

    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.getTutorBydId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _viewMoreReviews() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return BottomShowReviews(tutorDetailBloc: _bloc);
      },
    );
  }

  void _reportTutorBottomSheet({required String userId}) async {
    final report = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return BlocProvider(
          initBloc: (_) => injector.get<ReportTutorBloc>(param1: userId),
          child: const ReportTutorBottom(),
        );
        // return const SizedBox();
      },
    );
    if ((report is bool) && report) {
      log("🐼[Report tutor] success");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: _backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonCustom(
          height: 45.0,
          onPress: () => _bloc.openTutorSchedulePage(),
          child: Text(
            S.of(context).bookTutor,
            style: context.titleMedium
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
        ),
        title: Text(
          S.of(context).tutorDetail,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<bool?>(
        stream: _bloc.loading$,
        builder: (ctx, sS) {
          final loading = sS.data ?? false;
          if (loading) {
            return _loading();
          }
          return StreamBuilder<TutorDetail>(
            stream: _bloc.tutor$,
            builder: (ctx1, sS1) {
              final tutor = sS1.data;
              if (tutor == null) {
                return const SizedBox();
              }
              return StreamBuilder(
                stream: _bloc.loadingFav$,
                builder: (ctx2, sS2) {
                  final loadingFav = sS.data ?? false;
                  return Stack(
                    children: [
                      _tutorView(tutor),
                      if (loadingFav)
                        Container(
                          color: Colors.black45,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: _loading(),
                        )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: _primaryColor),
    );
  }

  ListView _tutorView(TutorDetail tutor) {
    final tutorUser = tutor.user;
    return ListView(
      children: <Widget>[
        Padding(
          padding: _horizontalEdgeInsets,
          child: _rowTutorInformation(tutorUser, tutor),
        ),
        Padding(
          padding: _horizontalEdgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...<String>[
                (tutor.isFavorite ?? false)
                    ? S.of(context).isFavorite
                    : S.of(context).favorite,
                S.of(context).report,
              ].mapIndexed(
                (index, e) => Expanded(
                  child: ButtonCustom(
                    color: switch (index) {
                      0 => Colors.red.withOpacity(0.7),
                      _ => _primaryColor
                    },
                    radius: 5.0,
                    child: Row(
                      children: [
                        Expanded(child: Text(e)),
                        switch (index) {
                          0 => favIcon(tutor.isFavorite ?? false),
                          _ => const Icon(Icons.report, color: Colors.white)
                        }
                      ],
                    ),
                    onPress: () {
                      if (index == 0) {
                        _bloc.favTutor();
                      } else {
                        _bloc.reportTutor();
                      }
                    },
                  ),
                ),
              ),
            ].expand((e) => [e, const SizedBox(width: 5.0)]).toList()
              ..removeLast(),
          ),
        ),
        if ((tutor.video?.isNotEmpty ?? false) ||
            (tutor.youtubeVideoId?.isNotEmpty ?? false))
          Container(
            width: double.infinity,
            height: context.heightDevice * 0.3,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1, color: _primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 5.0,
                )
              ],
            ),
            child: VideoPlayerUI(
              url: tutor.video!,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ...{
          S.of(context).description: tutor.bio,
          S.of(context).education: tutor.education,
          S.of(context).languages: tutor.languages,
          S.of(context).specialties: tutor.specialties,
        }.entries.mapIndexed(
              (index, e) => (e.value?.isNotEmpty ?? false)
                  ? _informationWithHeaderField(e, index)
                  : const SizedBox(),
            ),
        HeaderTextCustom(
          headerText: S.of(context).review,
          padding: _horizontalEdgeInsets,
          textStyle: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
          isShowSeeMore: true,
          onPress: _viewMoreReviews,
        ),
        HeaderTextCustom(
          headerText: S.of(context).suggestedCourses,
          textStyle: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
          padding: _horizontalEdgeInsets,
        ),
        if (tutorUser?.courses != null)
          ...tutorUser!.courses!.map(
            (e) => Padding(
              padding: _horizontalEdgeInsets,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e.name,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(S.of(context).view,
                        style:
                            context.titleSmall.copyWith(color: _primaryColor)),
                  )
                ],
              ),
            ),
          )
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _informationWithHeaderField(MapEntry<String, String?> e, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderTextCustom(
          headerText: e.key,
          padding: _horizontalEdgeInsets,
          textStyle: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5.0),
        if (index < 2)
          Padding(
            padding: _horizontalEdgeInsets,
            child: ReadMoreText(
              e.value!,
              trimLines: 3,
              trimCollapsedText: S.of(context).showMore,
              trimExpandedText: S.of(context).showLess,
              lessStyle: context.titleSmall.copyWith(color: _primaryColor),
              moreStyle: context.titleSmall.copyWith(color: _primaryColor),
              style: context.titleSmall.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.w500),
            ),
          )
        else
          Padding(
            padding: _horizontalEdgeInsets,
            child: Wrap(
              children: [
                ...e.value!.split(',').map(
                      (e) => Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: _primaryColor.withOpacity(0.2),
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
          ),
      ],
    );
  }

  Widget _rowTutorInformation(TutorUserDetail? tutorUser, TutorDetail tutor) {
    if (tutorUser == null) {
      return const SizedBox();
    }
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: ImageCustom(
            imageUrl: tutorUser.avatar ?? ImageConst.baseImageView,
            isNetworkImage: true,
            width: 70.0,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tutorUser.name ?? '',
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 1.0),
              if (tutorUser.country?.isNotEmpty ?? false) ...[
                Text(
                  Constant.countries[tutorUser.country!.toUpperCase()] ??
                      'Unknown',
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 1.0),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RattingWidgetCustom(
                      rating: tutor.rating ?? 0.0, itemSize: 17.0),
                  Text(
                    ' ${tutor.rating?.toStringAsFixed(1) ?? ''} . ${tutor.totalFeedback}',
                    style: context.titleSmall.copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: _primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Stream handleState(state) async* {
    if (state is GetTutorByIdSuccess) {
      log("🌟[Get tutor by id] Success");
      return;
    }
    if (state is GetTutorByIdFailed) {
      log("🌟[Get tutor by id] Failed ${state.toString()}");
      return;
    }
    if (state is FavTutorFailed) {
      log("🌟[Fav tutor] Failed ${state.toString()}");
      return;
    }
    if (state is FavTutorSuccess) {
      log("🌟[Fav tutor] Success");
      return;
    }
    if (state is GetReviewsFailed) {
      log("🌟 [Get reviews] Failed ${state.toString()}");
      return;
    }
    if (state is GetReviewsSuccess) {
      log("🌟 [Get reviews] Success");
      return;
    }
    if (state is OpenReportTutorSuccess) {
      log("🌟 [Open report tutor view] Success");
      _reportTutorBottomSheet(userId: state.userId);
      return;
    }
    if (state is OpenTutorScheduleSuccess) {
      log("🌟 [Open tutor schedule view] Success");
      context.openPageWithRouteAndParams(Routes.tutorSchedule, state.userId);
      return;
    }
  }
}
