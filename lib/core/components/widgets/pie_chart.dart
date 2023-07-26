import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

import '../constant/constant.dart';

class Data {
  final String name;
  final double percents;
  final Color color;
  final String imagePath;
  Data(
      {required this.imagePath,
      required this.name,
      required this.percents,
      required this.color});
}

class PieChartVIew extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int sum;
  final double radius;
  const PieChartVIew({
    super.key,
    required this.data,
    required this.sum,
    this.radius = 160,
  });

  @override
  State<PieChartVIew> createState() => _PieChartVIewState();
}

class _PieChartVIewState extends State<PieChartVIew> {
  final ValueNotifier<int> _touchIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius,
      width: widget.radius,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: PieChart(
                PieChartData(
                  startDegreeOffset: 130,
                  sectionsSpace: 0,
                  centerSpaceRadius: widget.radius / 4 - 10,
                  sections: [
                    ...widget.data.map((e) => Data(
                          imagePath:
                              Constant.icons[e['icon']]['icon'].toString(),
                          name: '',
                          percents: ((e['data'] as int) / widget.sum * 100)
                              .round()
                              .toDouble(),
                          color: (Constant.icons[e['icon']]['color'] as Color)
                              .withOpacity(0.5),
                        ))
                  ]
                      .asMap()
                      .map<int, PieChartSectionData>((index, data) {
                        return MapEntry(
                          index,
                          PieChartSectionData(
                            color: data.color,
                            value: data.percents,
                            radius: 10,
                            showTitle: false,
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
            if (widget.data.isNotEmpty) ...[
              Center(
                child: ValueListenableBuilder<int>(
                  valueListenable: _touchIndex,
                  builder: (context, touchIndex, chi) => PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            _touchIndex.value = -1;
                            return;
                          }
                          _touchIndex.value = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        },
                      ),
                      startDegreeOffset: 130,
                      sectionsSpace: 0,
                      centerSpaceRadius: widget.radius / 4,
                      sections: [
                        ...widget.data.map((e) => Data(
                              imagePath:
                                  Constant.icons[e['icon']]['icon'].toString(),
                              name: '',
                              percents: ((e['data'] as int) / widget.sum * 100)
                                  .round()
                                  .toDouble(),
                              color:
                                  (Constant.icons[e['icon']]['color'] as Color),
                            ))
                      ]
                          .asMap()
                          .map<int, PieChartSectionData>((index, data) {
                            final isTouched = index == touchIndex;
                            final width = ((widget.radius * 25) / 160);
                            return MapEntry(
                              index,
                              PieChartSectionData(
                                color: data.color,
                                value: data.percents,
                                radius: isTouched ? width + 10 : width,
                                showTitle: false,
                                // titlePositionPercentageOffset: 0.55,
                                badgeWidget: Badge(
                                  data.imagePath,
                                  size: isTouched ? 35.0 : 30.0,
                                  borderColor: data.color,
                                ),
                                badgePositionPercentageOffset: .98,
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      // padding: EdgeInsets.all(size * .15),
      child: Center(child: Text(svgAsset, style: context.titleMedium)),
    );
  }
}
