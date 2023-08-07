import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/double_extension.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

class ModelBottomSheet extends StatefulWidget {
  final double max;
  final double? min;

  const ModelBottomSheet({
    super.key,
    this.max = 1000000,
    this.min = 0,
  });

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  double fromPrice = 0;
  double toPrice = 0;

  void onChangeSlider(value) {
    setState(
      () {
        fromPrice = value.start;
        toPrice = value.end;
      },
    );
  }

  // style
  TextStyle get headerStyle =>
      context.titleMedium.copyWith(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final min = widget.min ?? 0;
    final height = context.heightDevice;
    const exampleWidget = [
      Text('abc'),
      Text('abc'),
      Text('abc'),
      Text('abc'),
      Text('abc'),
      Text('abc'),
      Text('abc'),
      Text('abc'),
    ];

    return Container(
      width: context.widthDevice,
      constraints: BoxConstraints(
        maxHeight: height * 0.85,
        minHeight: height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Container(
              width: 60,
              height: 3.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
            const SizedBox(height: 10.0),
            ExpansionItem(
              content: exampleWidget.isNotEmpty // Need to update variable, just for temporary
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _compareField(exampleWidget, context),
                    )
                  : const SizedBox(),
              label: S.of(context).sortBy,
            ),
            ExpansionItem(
              content: _rangePrice(context, min),
              label: S.of(context).byPrice,
            )
          ],
        ),
      ),
    );
  }

  Column _rangePrice(BuildContext context, double min) {
    return Column(
      children: [
        Text(
          '${fromPrice.toCurrency()} - ${toPrice.toCurrency()}',
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        RangeSlider(
          values: RangeValues(fromPrice, toPrice),
          onChanged: onChangeSlider,
          max: widget.max,
          min: min,
          divisions: 10000,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
      ],
    );
  }

  GridView _compareField(List<Text> exampleWidget, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 4,
      ),
      shrinkWrap: true,
      itemCount:
          exampleWidget.length, // Need to update variable, just for temporary
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(3),
            ),
            child: exampleWidget[
                index], // Need to update variable, just for temporary
          ),
        );
      },
    );
  }
}

class ExpansionItem extends StatelessWidget {
  final Widget? content;
  final String label;
  final TextStyle? textStyle;
  final IconData? actionIcon;

  const ExpansionItem({
    super.key,
    this.content,
    this.label = '',
    this.textStyle,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionWidget(
      initiallyExpanded: true,
      content: content ?? const SizedBox(),
      titleBuilder: (double animationValue, double easeInValue, bool isExpanded,
          toggleFunction) {
        return InkWell(
          onTap: () => toggleFunction(animated: true),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: textStyle ??
                        context.titleLarge
                            .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Transform.rotate(
                  angle: 3.14 * animationValue / 2,
                  alignment: Alignment.center,
                  child: Icon(actionIcon ?? Icons.arrow_right, size: 37),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
