import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/row_tutor_information.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_count_down.dart';

class BeforeMeetingView extends StatefulWidget {
  final BooInfo booInfo;
  const BeforeMeetingView({super.key, required this.booInfo});

  @override
  State<BeforeMeetingView> createState() => _BeforeMeetingViewState();
}

class _BeforeMeetingViewState extends State<BeforeMeetingView> {
  @override
  Widget build(BuildContext context) {
    final currentTime = Constant.currentTimeMilliSeconds;
    final referenceTime = widget.booInfo.scheduleDetailInfo!
            .startPeriodTimestamp.millisecondsSinceEpoch /
        1000;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowTutorInformation(
                  tutor: widget
                      .booInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo,
                  showFavorite: false,
                  showRatting: false,
                ),
                ...[
                  widget.booInfo.scheduleDetailInfo?.startPeriodTimestamp,
                  widget.booInfo.scheduleDetailInfo?.startPeriodTimestamp,
                  widget.booInfo.scheduleDetailInfo?.endPeriodTimestamp,
                ].mapIndexed((index, e) {
                  if (e == null) {
                    return const SizedBox();
                  }
                  return _richText(
                    header: switch (index) {
                      0 => 'Lesson date',
                      1 => 'Start time',
                      _ => 'End time'
                    },
                    title: switch (index) {
                      0 => DateFormat().add_yMMMMEEEEd().format(e),
                      _ => getjmFormat(e)
                    },
                    context: context,
                  );
                }),
              ],
            ),
          ),
          Countdown(
            seconds: (referenceTime - currentTime).round(),
            build: (BuildContext context, double time) {
              int hours = time.round() ~/ 3600;
              int minutes = (time.round() % 3600) ~/ 60;
              int seconds = time.round() % 60;
              return _renderRichText(hours, minutes, seconds,
                  header: 'Upcoming lessons will appear ');
            },
            interval: const Duration(milliseconds: 100),
            onFinished: () {
              // _bloc.getUpComingClass();
            },
          ),
        ],
      ),
    );
  }

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
            ' hours and ',
            minutes.toString(),
            ' minutes ',
            if (seconds != null) ...[seconds.toString(), ' seconds.'],
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

  Widget _richText(
      {required String header,
      required String title,
      required BuildContext context}) {
    return RichText(
        text: TextSpan(
      style: context.titleMedium,
      children: [
        TextSpan(
          text: header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ': $title')
      ],
    ));
  }
}
