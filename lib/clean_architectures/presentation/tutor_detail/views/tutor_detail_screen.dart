import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_user_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_state.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listen ??= _bloc.state$.flatMap(handleState).collect();

    _bloc.getTutorBydId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ButtonCustom(
          height: 45.0,
          onPress: () {},
          child: Text(
            'Book tutor',
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
          icon: Icon(Icons.arrow_back, color: Theme.of(context).shadowColor),
        ),
        title: Text(
          'Tutor detail',
          style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<bool?>(
        stream: _bloc.loading$,
        builder: (ctx, sS) {
          final loading = sS.data ?? false;
          if (loading) {
            return Center(
              child: StyleLoadingWidget.foldingCube
                  .renderWidget(size: 40.0, color: _primaryColor),
            );
          }
          return StreamBuilder<TutorDetail>(
            stream: _bloc.tutor$,
            builder: (ctx1, sS1) {
              final tutor = sS1.data;
              if (tutor == null) {
                return const SizedBox();
              }
              return _tutorView(tutor);
            },
          );
        },
      ),
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
        HeaderTextCustom(
          headerText: "Description",
          padding: _horizontalEdgeInsets,
        ),
        Padding(
          padding: _horizontalEdgeInsets,
          child: Text(tutor.bio ?? '', style: context.titleMedium),
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
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
            width: 80.0,
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
              const SizedBox(height: 2.0),
              if (tutorUser.country?.isNotEmpty ?? false) ...[
                Text(
                  Constant.countries[tutorUser.country!.toUpperCase()] ??
                      'Unknown',
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 2.0),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RattingWidgetCustom(
                      rating: tutor.rating ?? 0.0, itemSize: 17.0),
                  Text(
                    ' ${tutor.rating?.toStringAsFixed(1) ?? ''} . ${tutor.totalFeedback}',
                    style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w500, color: _primaryColor),
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
  }
}
