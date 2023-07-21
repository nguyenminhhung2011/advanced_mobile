//Update later
import 'package:flutter/material.dart';

class GridWithFreeSizeCustom extends StatelessWidget {
  final double? hPadding;
  final double? vPadding;
  final int numberColumn;
  final int maxCountPerRow;
  final int itemCount;
  final double crossSpacing;
  final double mainSpacing;
  final Widget Function(BuildContext, int) itemBuilder;
  const GridWithFreeSizeCustom({
    super.key,
    this.hPadding,
    this.vPadding,
    this.mainSpacing = 5.0,
    this.crossSpacing = 5.0,
    required this.itemCount,
    required this.numberColumn,
    required this.maxCountPerRow,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hPadding ?? 0.0,
        vertical: vPadding ?? 0.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: List.generate(
          maxCountPerRow,
          (indexC) {
            int startRowIndex = indexC;
            return Row(
              children: List.generate(
                numberColumn,
                (indexR) {
                  int index = indexR + (startRowIndex * numberColumn);
                  return Expanded(
                    child: index < itemCount
                        ? itemBuilder(context, index)
                        : const SizedBox(),
                  );
                },
              )
                  .expand((element) => [element, SizedBox(width: crossSpacing)])
                  .toList()
                ..removeLast(),
            );
          },
        ).expand((element) => [element, SizedBox(height: mainSpacing)]).toList()
          ..removeLast(),
      ),
    );
  }
}
