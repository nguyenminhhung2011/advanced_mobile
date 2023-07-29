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
      width: MediaQuery.sizeOf(context).width,
      constraints: BoxConstraints(
        maxHeight: height * 0.6,
        minHeight: height * 0.5,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionItem(
              content: exampleWidget != null // Need to update variable, just for temporary
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 4,
                      ),
                      shrinkWrap: true,
                      itemCount: exampleWidget
                          .length, // Need to update variable, just for temporary
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: exampleWidget[
                                index], // Need to update variable, just for temporary
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
              label: S.of(context).sortBy,
            ),
            ExpansionItem(
              content: Column(
                children: [
                  Text(
                    '${fromPrice.toCurrency()} - ${toPrice.toCurrency()}',
                  ),
                  RangeSlider(
                    values: RangeValues(fromPrice, toPrice),
                    onChanged: onChangeSlider,
                    max: widget.max,
                    min: min,
                    divisions: 10000,
                  ),
                ],
              ),
              label: S.of(context).byPrice,
            )
          ],
        ),
      ),
    );
  }
}

class ExpansionItem extends StatelessWidget {
  final Widget? content;
  final String label;

  const ExpansionItem({
    super.key,
    this.content,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                    style: textTheme.titleLarge,
                  ),
                ),
                Transform.rotate(
                  angle: 3.14 * animationValue / 2,
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_right, size: 40),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
