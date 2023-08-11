import 'package:collection/collection.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/double_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';

import '../model/filter_model.dart';
import '../model/filter_response.dart';

class ModelBottomSheet extends StatefulWidget {
  final List<FilterModel> listFilter;
  final List<FilterResponse> initResponse;

  const ModelBottomSheet({
    super.key,
    this.listFilter = const <FilterModel>[],
    this.initResponse = const <FilterResponse>[],
  });

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  Color get primaryColor => Theme.of(context).primaryColor;

  final List<FilterResponse> dataControls = [];

  void _onChangeSlider(RangeValues value, int locationIndex) {
    setState(
      () {
        dataControls[locationIndex].setFromPrice(value.start);
        dataControls[locationIndex].setToPrice(value.end);
      },
    );
  }

  void _onSelectedCompare(
      int locationIndex, String compareAdd, String subCompare) {
    if (dataControls[locationIndex].compareSelected?.contains(subCompare) ??
        false) {
      dataControls[locationIndex].removeCompareSelected(subCompare);
      dataControls[locationIndex].addCompareSelected(compareAdd);
      setState(() {});
      return;
    }
    if (dataControls[locationIndex].compareSelected?.contains(compareAdd) ??
        false) {
      dataControls[locationIndex].removeCompareSelected(compareAdd);
      setState(() {});
      return;
    }
    dataControls[locationIndex].addCompareSelected(compareAdd);
    setState(() {});
  }

  void _onSelectedCategory(String category, int locationIndex) {
    if (dataControls[locationIndex].categorySelected?.contains(category) ??
        false) {
      dataControls[locationIndex].removeCategorySelected(category);
      setState(() {});
      return;
    }
    dataControls[locationIndex].addCategorySelected(category);
    setState(() {});
    return;
  }

  void _onApply() {
    context.popArgs(dataControls);
  }

  @override
  void initState() {
    // log(widget.initResponse.length + 1);
    if (widget.initResponse.isNotEmpty) {
      setState(() {
        dataControls.addAll(widget.initResponse);
      });
    } else {
      for (var i = 0; i < widget.listFilter.length; i++) {
        final data = widget.listFilter[i];
        if (data is PriceModel) {
          dataControls.add(FilterResponse(
            filterType: FilterType.price,
            fromPrice: data.minPrice,
            toPrice: data.minPrice,
            locationIndex: i,
          ));
        } else if (data is CompareModel) {
          dataControls.add(FilterResponse(
            filterType: FilterType.compare,
            compareSelected: <String>[],
            locationIndex: i,
          ));
        } else if (data is CategoryModelSearch) {
          dataControls.add(FilterResponse(
            filterType: FilterType.categories,
            categorySelected: <String>[],
            locationIndex: i,
          ));
        } else {}
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // style
  TextStyle get headerStyle =>
      context.titleMedium.copyWith(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    final height = context.heightDevice;
    return Container(
      width: context.widthDevice,
      constraints: BoxConstraints(
        maxHeight: height * 0.8,
        minHeight: height * 0.6,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ButtonCustom(
            height: 45.0,
            radius: 5.0,
            onPress: _onApply,
            child: Text(
              'Apply',
              style: context.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Column(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...widget.listFilter.mapIndexed((index, e) {
                      late Widget itemDisplay;
                      if (e is PriceModel) {
                        itemDisplay = _rangePrice(
                            context: context,
                            priceModel: e,
                            filterResponse: dataControls[index]);
                      } else if (e is CompareModel) {
                        itemDisplay = Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: _compareField(
                            exampleWidget: [],
                            context: context,
                            compareModel: e,
                            filterResponse: dataControls[index],
                          ),
                        );
                      } else if (e is CategoryModelSearch) {
                        itemDisplay = Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: _category(
                            context: context,
                            categoryModel: e,
                            filterResponse: dataControls[index],
                          ),
                        );
                      } else {
                        itemDisplay = const SizedBox();
                      }
                      return ExpansionItem(
                          label: e.header, content: itemDisplay);
                    }),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _category({
    required BuildContext context,
    required CategoryModelSearch categoryModel,
    required FilterResponse filterResponse,
  }) {
    return Wrap(
      spacing: 6.0,
      runSpacing: -8,
      alignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.up,
      children: [
        ...categoryModel.categories.map((e) {
          final isSelected =
              filterResponse.categorySelected?.contains(e) ?? false;
          return ChoiceChip(
            label: Text(
              e,
              style: context.titleSmall.copyWith(
                fontSize: 14,
                color: isSelected ? primaryColor : null,
                fontWeight: FontWeight.w400,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            avatar: isSelected
                ? Icon(Icons.check, color: primaryColor, size: 15.0)
                : null,
            selected: isSelected,
            onSelected: (text) =>
                _onSelectedCategory(e, filterResponse.locationIndex),
            backgroundColor: Theme.of(context).dividerColor.withOpacity(0.07),
            selectedColor: primaryColor.withOpacity(0.1),
          );
        }),
      ],
    );
  }

  Widget _rangePrice({
    required BuildContext context,
    required PriceModel priceModel,
    required FilterResponse filterResponse,
  }) {
    return Column(
      children: [
        Text(
          '${filterResponse.fromPrice!.toCurrency()} - ${filterResponse.toPrice!.toCurrency()}',
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        RangeSlider(
          values:
              RangeValues(filterResponse.fromPrice!, filterResponse.toPrice!),
          onChanged: (values) =>
              _onChangeSlider(values, filterResponse.locationIndex),
          max: priceModel.maxPrice,
          min: priceModel.minPrice,
          divisions: 10000,
          activeColor: primaryColor,
          inactiveColor: primaryColor.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _compareField({
    required List<Text> exampleWidget,
    required BuildContext context,
    required CompareModel compareModel,
    required FilterResponse filterResponse,
  }) {
    final compares = compareModel.compares;
    if (compares.isEmpty) {
      return const SizedBox();
    }
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 4,
      ),
      shrinkWrap: true,
      itemCount:
          compares.length * 2, // Need to update variable, just for temporary
      itemBuilder: (_, index) {
        final compare = compares[index ~/ 2];
        final compareText = index % 2 == 0 ? compare.left : compare.right;
        final subCompare =
            compare.left == compareText ? compare.right : compare.left;
        final isContains =
            filterResponse.compareSelected?.contains(compareText) ?? false;
        final selectedColor =
            isContains ? primaryColor : Theme.of(context).hintColor;

        return GestureDetector(
          onTap: () => _onSelectedCompare(
              filterResponse.locationIndex, compareText, subCompare),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(3),
              border: Border.all(
                width: 1,
                color: selectedColor.withOpacity(isContains ? 0.5 : 0),
              ),
            ),
            child: Text(
              '${compare.headerCategory} : $compareText',
              style: context.titleMedium.copyWith(color: selectedColor),
            ),
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
                  angle: 3.14 * animationValue / 4,
                  alignment: Alignment.center,
                  child: Icon(
                    actionIcon ?? Icons.add,
                    size: 17,
                    color: Theme.of(context).hintColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
