import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:intl/intl.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;
  final Function() onPress;
  const ScheduleItem({
    super.key,
    required this.schedule,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
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
          _richText(
            header: 'Lesson date',
            title:
                DateFormat().add_yMMMMEEEEd().format(schedule.startTimestamp),
            context: context,
          ),
          _richText(
            header: 'Start time',
            title: getjmFormat(schedule.startTimestamp),
            context: context,
          ),
          _richText(
            header: 'End time',
            title: getjmFormat(schedule.endTimestamp),
            context: context,
          ),
          ButtonCustom(
            onPress: onPress,
            radius: 5.0,
            height: 35.0,
            child: Text(
              'Book tutor',
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ].expand((e) => [e, const SizedBox(height: 2.0)]).toList()
          ..removeLast(),
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
