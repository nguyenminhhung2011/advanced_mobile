import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/review/review.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/review_item.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

class BottomShowReviews extends StatefulWidget {
  final TutorDetailBloc tutorDetailBloc;
  const BottomShowReviews({
    super.key,
    required this.tutorDetailBloc,
  });

  @override
  State<BottomShowReviews> createState() => _BottomShowReviewsState();
}

class _BottomShowReviewsState extends State<BottomShowReviews> {
  Color get _primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthDevice,
      constraints: BoxConstraints(
        maxHeight: context.heightDevice * 0.8,
        minHeight: context.heightDevice * 0.6,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ButtonCustom(
            height: 45.0,
            radius: 5.0,
            onPress: () {},
            child: Text(
              'Add new reviews',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: StreamBuilder<bool?>(
          stream: widget.tutorDetailBloc.loadingRev$,
          builder: (ctx, sS) {
            final loading = sS.data ?? false;
            return StreamBuilder<Pagination<Review>>(
              stream: widget.tutorDetailBloc.reviews$,
              builder: (ctx1, sS1) {
                final listReview = sS1.data;
                final rows = listReview?.rows ?? List.empty();
                return _viewField(context, listReview, rows, loading);
              },
            );
          },
        ),
      ),
    );
  }

  ListView _viewField(BuildContext context, Pagination<Review>? listReview,
      List<dynamic> rows, bool loading) {
    return ListView(
      children: [
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 3.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const HeaderTextCustom(
          headerText: 'All reviews',
          padding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
        const SizedBox(height: 20.0),
        if (listReview != null) ...rows.map((e) => ReviewItemPro(review: e)),
        if (loading) _loading(),
        TextButton(
          onPressed: () => widget.tutorDetailBloc.getReviews(),
          child: Text(
            S.of(context).seeMore,
            style: context.titleSmall.copyWith(
              color: _primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: _primaryColor),
    );
  }
}
