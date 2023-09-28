import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/schedule/schedule_detail.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:intl/intl.dart';

class AddNoteToBooTutor extends StatefulWidget {
  final ScheduleDetail scheduleDetail;
  const AddNoteToBooTutor({
    super.key,
    required this.scheduleDetail,
  });

  @override
  State<AddNoteToBooTutor> createState() => _AddNoteToBooTutorState();
}

class _AddNoteToBooTutorState extends State<AddNoteToBooTutor> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final elementBoxStyle = context.titleSmall
        .copyWith(color: primaryColor, fontWeight: FontWeight.w600);
    return Container(
      width: double.infinity,
      height: context.heightDevice * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book details',
              style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor.withOpacity(0.1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${getjmFormat(widget.scheduleDetail.startPeriodTimestamp)} ⌚ ${getjmFormat(widget.scheduleDetail.endPeriodTimestamp)}',
                    style: elementBoxStyle,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    DateFormat()
                        .add_yMMMMEEEEd()
                        .format(widget.scheduleDetail.startPeriodTimestamp),
                    style: elementBoxStyle,
                  ),
                ],
              ),
            ),
            Text('Enter your note here', style: context.titleMedium),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: "Add note",
              ),
            ),
          ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
            ..removeLast(),
        )),
        ButtonCustom(
          radius: 5.0,
          onPress: () => context.popArgs(_noteController.text),
          child: Text(
            'Book',
            style: context.titleSmall
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ]),
    );
  }
}
