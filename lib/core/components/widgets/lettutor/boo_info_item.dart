import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/lettutor/row_tutor_information.dart';
import 'package:intl/intl.dart';

class BooInfoItem extends StatelessWidget {
  const BooInfoItem({
    super.key,
    required this.booInfo,
    required this.isHistoryType,
    this.cancelFunction,
    this.editRequestFunction,
    this.rattingFunction,
  });

  final BooInfo booInfo;
  final bool isHistoryType;
  final Function()? cancelFunction;
  final Function()? editRequestFunction;
  final Function()? rattingFunction;

  @override
  Widget build(BuildContext context) {
    final tutorInfo = booInfo.scheduleDetailInfo?.scheduleInfo?.tutorInfo;
    if (tutorInfo == null) {
      return const SizedBox();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
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
          RowTutorInformation(
              tutor: tutorInfo, showFavorite: false, showRatting: false),
          ...[
            booInfo.scheduleDetailInfo?.startPeriodTimestamp,
            booInfo.scheduleDetailInfo?.startPeriodTimestamp,
            booInfo.scheduleDetailInfo?.endPeriodTimestamp,
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
          if (isHistoryType)
            _rowButtonForHistoryType(context)
          else
            _rowButtonUpComingType(context),
        ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
          ..removeLast(),
      ),
    );
  }

  Widget _rowButtonUpComingType(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonCustom(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderColor: Colors.red,
          height: 40.0,
          radius: 5.0,
          onPress: cancelFunction ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close, color: Colors.red),
              Text(
                'Cancel',
                style: context.titleMedium
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
              )
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 1, color: Theme.of(context).dividerColor),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(5.0),
                  ),
                  color: Theme.of(context).dividerColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        'Request for lesson',
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ButtonCustom(
                        height: 35.0,
                        radius: 5.0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderColor: Theme.of(context).primaryColor,
                        onPress: editRequestFunction ?? () {},
                        child: Text('Edit request', style: context.titleSmall),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  booInfo.studentRequest ?? 'Empty',
                  style:
                      context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row _rowButtonForHistoryType(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: ButtonCustom(
            onPress: rattingFunction ?? () {},
            height: 40.0,
            radius: 5.0,
            child: Text(
              'Start ratting',
              style: context.titleMedium
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 2,
          child: ButtonCustom(
            onPress:  () {},
            borderColor: Colors.yellow,
            width: double.infinity,
            height: 40.0,
            radius: 5.0,
            color: Theme.of(context).cardColor,
            child: const Icon(
              Icons.warning,
              color: Colors.yellow,
              size: 20.0,
            ),
          ),
        )
      ],
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
