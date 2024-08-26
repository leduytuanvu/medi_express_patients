// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
//
// enum TypeChart {
//   weight,
//   height,
//   temperature,
//   heartRate,
//   spo2,
//   bloodPressure,
//   bloodSugar,
//   ua,
// }
//
// class ChartWidget extends StatelessWidget {
//   // final List<ThresholdEntity> listThresholdEntity;
//   // final List<ThresholdHourEntity> listThresholdHourEntity;
//   final TypeChart typeChart;
//   final Color colorChart;
//   final String typeTimeChart;
//
//   const ChartWidget({
//     // required this.listThresholdEntity,
//     // required this.listThresholdHourEntity,
//     required this.typeChart,
//     required this.colorChart,
//     required this.typeTimeChart,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool is24Hour = true;
//     if (typeTimeChart == TypeTimeChart.dayTemp.name ||
//         typeTimeChart == TypeTimeChart.dayMist.name) {
//       is24Hour = false;
//     }
//
//     List<ThresholdEntity> listThresholdEntityResult = [];
//     List<ThresholdHourEntity> listThresholdHourEntityResult = [];
//
//     if (typeChart == TypeChart.mist) {
//       if (is24Hour) {
//         for (int i = 0; i < listThresholdHourEntity.length; i++) {
//           double avg = (listThresholdHourEntity[i].minHumi +
//                   listThresholdHourEntity[i].maxHumi) /
//               2;
//           avg = (avg * 10).round().toDouble() / 10;
//           listThresholdHourEntityResult.add(ThresholdHourEntity(
//             hour: listThresholdHourEntity[i].hour,
//             maxHumi: avg,
//             maxTemp: 0,
//             minHumi: avg,
//             minTemp: 0,
//           ));
//         }
//       } else {
//         for (int i = 0; i < listThresholdEntity.length; i++) {
//           double avg = (listThresholdEntity[i].minHumi +
//                   listThresholdEntity[i].maxHumi) /
//               2;
//           avg = (avg * 10).round().toDouble() / 10;
//           listThresholdEntityResult.add(ThresholdEntity(
//             date: listThresholdEntity[i].date,
//             maxHumi: avg,
//             maxTemp: 0,
//             minHumi: avg,
//             minTemp: 0,
//           ));
//         }
//       }
//     } else {
//       if (is24Hour) {
//         for (int i = 0; i < listThresholdHourEntity.length; i++) {
//           double avg = (listThresholdHourEntity[i].minTemp +
//                   listThresholdHourEntity[i].maxTemp) /
//               2;
//           avg = (avg * 10).round().toDouble() / 10;
//           listThresholdHourEntityResult.add(ThresholdHourEntity(
//             hour: listThresholdHourEntity[i].hour,
//             maxHumi: 0,
//             maxTemp: avg,
//             minHumi: 0,
//             minTemp: avg,
//           ));
//         }
//       } else {
//         for (int i = 0; i < listThresholdEntity.length; i++) {
//           double avg = (listThresholdEntity[i].minTemp +
//                   listThresholdEntity[i].maxTemp) /
//               2;
//           avg = (avg * 10).round().toDouble() / 10;
//           listThresholdEntityResult.add(ThresholdEntity(
//             date: listThresholdEntity[i].date,
//             maxHumi: 0,
//             maxTemp: avg,
//             minHumi: 0,
//             minTemp: avg,
//           ));
//         }
//       }
//     }
//
//     List<String> getWeekDays(String datetimeStr) {
//       DateTime datetimeObj = DateTime.parse(datetimeStr);
//       int currentWeekday = datetimeObj.weekday;
//       List<String> weekDays = [];
//       for (int i = 1; i <= 8; i++) {
//         DateTime weekDayDate =
//             datetimeObj.add(Duration(days: i - currentWeekday));
//         weekDays.add(DateFormat('EE').format(weekDayDate));
//       }
//       return weekDays;
//     }
//
//     double min = 0, max = 0;
//     if (typeChart == TypeChart.mist) {
//       if (is24Hour) {
//         min = listThresholdHourEntityResult
//             .map((e) => e.minHumi)
//             .reduce((value, element) => value < element ? value : element);
//         max = listThresholdHourEntityResult
//             .map((e) => e.minHumi)
//             .reduce((value, element) => value > element ? value : element);
//       } else {
//         min = listThresholdEntityResult
//             .map((e) => e.minHumi)
//             .reduce((value, element) => value < element ? value : element);
//         max = listThresholdEntityResult
//             .map((e) => e.minHumi)
//             .reduce((value, element) => value > element ? value : element);
//       }
//     } else {
//       if (is24Hour) {
//         min = listThresholdHourEntityResult
//             .map((e) => e.minTemp)
//             .reduce((value, element) => value < element ? value : element);
//         max = listThresholdHourEntityResult
//             .map((e) => e.minTemp)
//             .reduce((value, element) => value > element ? value : element);
//       } else {
//         min = listThresholdEntityResult
//             .map((e) => e.minTemp)
//             .reduce((value, element) => value < element ? value : element);
//         max = listThresholdEntityResult
//             .map((e) => e.minTemp)
//             .reduce((value, element) => value > element ? value : element);
//       }
//     }
//
//     int intervalLeft = 1;
//     int intervalBottom = 1;
//
//     double width = MediaQuery.of(context).size.width - 16.w;
//
//     if (is24Hour) {
//       ThresholdHourEntity entity = ThresholdHourEntity(
//         hour: listThresholdHourEntityResult[0].hour,
//         maxHumi: listThresholdHourEntityResult[0].maxHumi,
//         maxTemp: listThresholdHourEntityResult[0].maxTemp,
//         minHumi: listThresholdHourEntityResult[0].minHumi,
//         minTemp: listThresholdHourEntityResult[0].minTemp,
//       );
//       listThresholdHourEntityResult.add(entity);
//     }
//
//     double maxY = 0, minY = min - 6;
//     double heightChart = 0;
//     if (max - min > 100) {
//       heightChart = 440.h;
//       maxY = max.toInt() + 26;
//       intervalLeft = 11;
//     } else if (max - min > 90) {
//       heightChart = 430.h;
//       maxY = max.toInt() + 24;
//       intervalLeft = 10;
//     } else if (max - min > 80) {
//       heightChart = 420.h;
//       maxY = max.toInt() + 22;
//       intervalLeft = 9;
//     } else if (max - min > 70) {
//       heightChart = 410.h;
//       maxY = max.toInt() + 20;
//       intervalLeft = 8;
//     } else if (max - min > 60) {
//       heightChart = 400.h;
//       maxY = max.toInt() + 18;
//       intervalLeft = 7;
//     } else if (max - min > 50) {
//       heightChart = 390.h;
//       maxY = max.toInt() + 16;
//       intervalLeft = 6;
//     } else if (max - min > 40) {
//       heightChart = 380.h;
//       maxY = max.toInt() + 14;
//       intervalLeft = 5;
//     } else if (max - min > 30) {
//       heightChart = 370.h;
//       maxY = max.toInt() + 12;
//       intervalLeft = 4;
//     } else if (max - min > 20) {
//       heightChart = 360.h;
//       maxY = max.toInt() + 10;
//       intervalLeft = 3;
//     } else if (max - min > 10) {
//       heightChart = 360.h;
//       maxY = max.toInt() + 8;
//       intervalLeft = 2;
//     } else {
//       heightChart = 360.h;
//       maxY = max.toInt() + 6;
//       intervalLeft = 2;
//     }
//
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SizedBox(
//         width: width,
//         height: heightChart,
//         child: LineChart(
//           LineChartData(
//             gridData: const FlGridData(show: false),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   interval:
//                       intervalBottom.toDouble(), // Set the calculated interval
//                   getTitlesWidget: (value, meta) {
//                     if (is24Hour) {
//                       if (value.toInt() >
//                           listThresholdHourEntityResult.length - 1) {
//                         return const SizedBox.shrink();
//                       }
//                     } else {
//                       if (value.toInt() >
//                           listThresholdEntityResult.length - 1) {
//                         return const SizedBox.shrink();
//                       }
//                     }
//                     if (!is24Hour) {
//                       String datetimeStr = DateTime.now().toString();
//                       DateTime currentDate = DateTime.parse(datetimeStr);
//                       // logger.e("datetimeStr: $datetimeStr");
//                       List<String> daysOfWeek = [];
//                       for (int i = 0; i < 8; i++) {
//                         daysOfWeek.add(DateFormat('EEE')
//                             .format(currentDate.add(Duration(days: i))));
//                       }
//                       String time = "";
//                       if (value.toInt() == 0) {
//                         time = daysOfWeek[0];
//                       } else if (value == 1) {
//                         time = daysOfWeek[1];
//                       } else if (value == 2) {
//                         time = daysOfWeek[2];
//                       } else if (value == 3) {
//                         time = daysOfWeek[3];
//                       } else if (value == 4) {
//                         time = daysOfWeek[4];
//                       } else if (value == 5) {
//                         time = daysOfWeek[5];
//                       } else if (value == 6) {
//                         time = daysOfWeek[6];
//                       } else {
//                         time = daysOfWeek[7];
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 6, left: 10),
//                         child: Text(
//                           time.toString(),
//                           style: AppTextStyle.bodyTextStyleH9(),
//                         ),
//                       );
//                     } else {
//                       String datetimeStr = DateTime.now().toString();
//                       // Parse the string into a DateTime object
//                       DateTime datetimeObj = DateTime.parse(datetimeStr);
//                       // Generate a list of times, subtracting 3 hours each time
//                       List<DateTime> hoursList = List.generate(9,
//                           (i) => datetimeObj.subtract(Duration(hours: 3 * i)));
//                       // Format the DateTime objects to strings in "HH:mm" format
//                       List<String> formattedHoursList = hoursList
//                           .map((time) => DateFormat('HH').format(time))
//                           .toList();
//                       String time = "";
//                       if (value.toInt() == 0) {
//                         time = formattedHoursList[8];
//                       } else if (value.toInt() == 1) {
//                         time = formattedHoursList[7];
//                       } else if (value.toInt() == 2) {
//                         time = formattedHoursList[6];
//                       } else if (value.toInt() == 3) {
//                         time = formattedHoursList[5];
//                       } else if (value.toInt() == 4) {
//                         time = formattedHoursList[4];
//                       } else if (value.toInt() == 5) {
//                         time = formattedHoursList[3];
//                       } else if (value.toInt() == 6) {
//                         time = formattedHoursList[2];
//                       } else if (value.toInt() == 7) {
//                         time = formattedHoursList[1];
//                       } else {
//                         time = formattedHoursList[0];
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 6, left: 10),
//                         child: Text(
//                           time.toString(),
//                           style: AppTextStyle.bodyTextStyleH9(),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 30.w,
//                   interval: intervalLeft.toDouble(),
//                   // The interval at which to show the title
//                   getTitlesWidget: (double value, TitleMeta meta) {
//                     if (value.toInt() > max + 2) {
//                       return const SizedBox.shrink();
//                     }
//                     if (value.toInt() < min - 3) {
//                       return const SizedBox.shrink();
//                     }
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 6),
//                       child: Text(
//                         value.toInt().toString(),
//                         style: AppTextStyle.bodyTextStyleH9(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               topTitles: const AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: const AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             borderData: FlBorderData(show: false),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: List.generate(
//                   is24Hour
//                       ? listThresholdHourEntityResult.length
//                       : listThresholdEntityResult.length,
//                   (index) => FlSpot(
//                     index.toDouble(),
//                     typeChart == TypeChart.mist
//                         ? (is24Hour
//                             ? listThresholdHourEntityResult[index].minHumi
//                             : listThresholdEntityResult[index].minHumi)
//                         : (is24Hour
//                             ? listThresholdHourEntityResult[index].minTemp
//                             : listThresholdEntityResult[index].minTemp),
//                   ),
//                 ),
//                 isCurved: false,
//                 barWidth: 2,
//                 color: colorChart,
//                 belowBarData: BarAreaData(
//                   show: true,
//                   gradient: LinearGradient(
//                     colors: [
//                       colorChart.withOpacity(0.6),
//                       Colors.white,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//                 dotData: FlDotData(
//                   show: true, // Show dots on each data point
//                   getDotPainter: (spot, percent, barData, index) {
//                     return FlDotCirclePainter(
//                       radius: 3,
//                       color: colorChart,
//                       strokeWidth: 2,
//                       strokeColor: Colors.white,
//                     );
//                   },
//                 ),
//               ),
//             ],
//             maxX: is24Hour
//                 ? listThresholdHourEntityResult.length.toDouble()
//                 : listThresholdEntityResult.length.toDouble(),
//             maxY: maxY,
//             minX: 0,
//             minY: minY,
//           ),
//         ),
//       ),
//     );
//   }
// }
