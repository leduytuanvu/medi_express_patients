import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';

class ChartWidget extends StatelessWidget {
  final List<ChartData> data;

  ChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> _getValidSpots() {
      return data.map((chartData) => FlSpot(chartData.x, chartData.y)).toList();
    }

    String _getTitleForX(double value) {
      final matchedData = data.firstWhere((chartData) => chartData.x == value,
          orElse: () => ChartData(x: 0, y: 0, title: ''));
      return matchedData.title;
    }

    return SizedBox(
      height: context.hp(40),
      child: LineChart(
        LineChartData(
          minX: data.first.x,
          maxX: data.last.x,
          // minY: data.map((e) => e.y).reduce(
          //     (value, element) => value < element ? value - 5 : element - 5),
          minY: 60,
          // maxY: data
          //     .map((e) => e.y)
          //     .reduce((value, element) => value > element ? value : element),
          maxY: 160,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  if (value.toInt().toString() == '160') {
                    return Text(
                      '(BPM)',
                      style: AppTextStyle.smallBody(context).copyWith(
                        fontSize: context.sp(11),
                      ),
                      textAlign: TextAlign.end,
                    ).paddingOnly(right: context.wp(2));
                  } else {
                    return Text(
                      value.toInt().toString(),
                      style: AppTextStyle.smallBody(context).copyWith(
                        fontSize: context.sp(11),
                      ),
                      textAlign: TextAlign.end,
                    ).paddingOnly(right: context.wp(2));
                  }
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _getTitleForX(value),
                      style: AppTextStyle.smallBody(context).copyWith(
                        fontSize: context.sp(11),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey[200],
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.grey[300]!),
              bottom: BorderSide(color: Colors.grey[300]!),
              top: BorderSide.none,
              right: BorderSide.none,
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: _getValidSpots(),
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.08),
                    Colors.blue.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(
                show: false, // Hide the dots on the chart
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  return LineTooltipItem(
                    '${touchedSpot.y.toInt()} BPM\n${_getTitleForX(touchedSpot.x)}',
                    AppTextStyle.smallBody(context)
                        .copyWith(color: Colors.white),
                  );
                }).toList();
              },
            ),
            handleBuiltInTouches: true,
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(color: Colors.transparent),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 6,
                        color: Colors.blue,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final double x; // X-axis value
  final double y; // Y-axis value
  final String title; // Title for the X-axis

  ChartData({required this.x, required this.y, required this.title});
}
