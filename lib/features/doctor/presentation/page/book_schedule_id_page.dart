import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/doctor/presentation/controller/doctor_controller.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

class BookScheduleIdPage extends BaseStatelessWidget {
  final DoctorController doctorController = Get.find<DoctorController>();
  BookScheduleIdPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    doctorController.getTypeCreateAppointmentService();
    void _selectMonthYear(BuildContext context) async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MonthYearPicker(
            initialDate: selectedDate,
            doctorController: doctorController,
            onDateChanged: (newDate) {
              selectedDate = newDate;
              final String formattedDate =
                  DateFormat('MM/yyyy').format(selectedDate);
              DateTime parsedDate = DateFormat('MM/yyyy').parse(formattedDate);
              int month = parsedDate.month;
              int year = parsedDate.year;
              doctorController.doctorState.monthChoose.value = month.toString();
              doctorController.doctorState.yearChoose.value = year.toString();
              print("pickedDate: $formattedDate");
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.hp(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        doctorController.doctorState.doctorId = -1;
                        context.backScreen();
                        // context.offNamedScreen(AppRoutes.bookScheduleId);
                      },
                      child: Container(
                        height: context.hp(7),
                        width: context.wp(16),
                        color: Colors.transparent,
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'make_an_appointment'.tr,
                      style: AppTextStyle.appBar(context),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: context.hp(7),
                      width: context.wp(16),
                    ),
                  ],
                ),
              ).paddingOnly(top: context.hp(4)),
            ),
            context.hp(2.2).sbh,
            Text(
              'type_of_examination'.tr,
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            Row(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      doctorController.setTypeExamAtHome(true);
                    },
                    child: Icon(
                      doctorController.doctorState.typeExamAtHome.value
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: Color(0xFF005495),
                      size: context.sp(20),
                    ),
                  );
                }),
                context.wp(1.2).sbw,
                GestureDetector(
                  onTap: () {
                    doctorController.setTypeExamAtHome(true);
                  },
                  child: Text(
                    'Khám bệnh tại nhà',
                    style: AppTextStyle.mediumBody(context),
                  ),
                ),
                Spacer(),
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      doctorController.setTypeExamAtHome(false);
                    },
                    child: Icon(
                      !doctorController.doctorState.typeExamAtHome.value
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: Color(0xFF005495),
                      size: context.sp(20),
                    ),
                  );
                }),
                context.wp(1.2).sbw,
                GestureDetector(
                  onTap: () {
                    doctorController.setTypeExamAtHome(false);
                  },
                  child: Text(
                    'Khám tại bênh viện',
                    style: AppTextStyle.mediumBody(context),
                  ),
                ),
              ],
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            context.hp(2.2).sbh,
            Text(
              'select_service'.tr,
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            Obx(() {
              return DropdownButtonFormField<
                  TypeCreateAppointmentServiceEntity>(
                value: doctorController
                        .doctorState.listTypeCreateAppointmentService.isNotEmpty
                    ? doctorController
                        .doctorState.listTypeCreateAppointmentService.first
                    : null,
                hint: Text('select_service'.tr),
                items: doctorController
                    .doctorState.listTypeCreateAppointmentService
                    .map((service) {
                  return DropdownMenuItem<TypeCreateAppointmentServiceEntity>(
                    value: service,
                    child: Text(service.serviceName!),
                  );
                }).toList(),
                style: AppTextStyle.mediumBody(context),
                onChanged: (TypeCreateAppointmentServiceEntity? newValue) {
                  if (newValue != null) {
                    doctorController.doctorState.typeCreateAppointmentService
                        .value = newValue;
                    // Handle the selection here
                    print('Selected service: ${newValue.serviceName}');
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFE3E8EF), // Border color
                      width: 1, // Border width
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFE3E8EF), // Border color when enabled
                      width: 1, // Border width when enabled
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFE3E8EF), // Border color when focused
                      width: 1, // Border width when focused
                    ),
                  ),
                ),
              ).paddingSymmetric(
                horizontal: context.wp(4),
              );
            }),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            context.hp(2.2).sbh,
            Text(
              'select_date_and_time'.tr,
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            GestureDetector(
              onTap: () {
                _selectMonthYear(context);
              },
              child: Row(children: [
                Text('select_date'.tr, style: AppTextStyle.mediumBody(context)),
                Spacer(),
                SvgPicture.asset(
                  Assets.svg.calender,
                  color: Color(0xFF005495),
                  height: context.wp(4),
                  width: context.wp(4),
                ).paddingOnly(bottom: context.wp(0.3)),
                context.wp(2).sbw,
                Obx(() {
                  return Text(
                    '${doctorController.doctorState.monthChoose}/${doctorController.doctorState.yearChoose}',
                    style: AppTextStyle.linkH5(context),
                  );
                }),
              ]).paddingSymmetric(horizontal: context.wp(4)),
            ),
            context.hp(1.6).sbh,
            Obx(() {
              DateTime now = DateTime.now();
              int dateChoose = now.day;
              return DaysList(
                selectedMonth: DateTime(
                  int.parse(doctorController.doctorState.yearChoose.value),
                  int.parse(doctorController.doctorState.monthChoose.value),
                  dateChoose,
                ),
                selectedDate: doctorController.doctorState.dateChoose.value,
                doctorController: doctorController,
              );
            }),
            Obx(() {
              if (doctorController.doctorState.errorChooseDate.isNotEmpty) {
                return Text(
                  doctorController.doctorState.errorChooseDate.value,
                  style: AppTextStyle.mediumError(context),
                ).paddingOnly(
                  left: context.wp(4),
                  right: context.wp(4),
                  top: context.hp(1),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            context.hp(1.8).sbh,
            Text('select_time'.tr, style: AppTextStyle.mediumBody(context))
                .paddingOnly(left: context.wp(4)),
            context.hp(1.6).sbh,
            Obx(() {
              return TimeSlotPicker(
                  doctorController: doctorController,
                  timeChoose: doctorController.doctorState.timeChoose.value,
                  dateChoose: doctorController.doctorState.dateChoose.value);
            }),
            Obx(() {
              if (doctorController.doctorState.errorChooseTime.isNotEmpty) {
                return Text(
                  doctorController.doctorState.errorChooseTime.value,
                  style: AppTextStyle.mediumError(context),
                ).paddingOnly(
                  left: context.wp(4),
                  right: context.wp(4),
                  top: context.hp(1),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            context.hp(1).sbh,
            CustomButtonWidget(
              height: context.hp(6),
              width: context.wp(100),
              title: "complete".tr,
              onPressed: () async {
                // Handle button press
                FocusScope.of(context).unfocus();
                doctorController.createAppointment(
                    context, doctorController.doctorState.doctorId);
              },
              color: const Color(0xffCF4375),
              titleSize: context.sp(14),
              radius: context.rp(10),
              fontWeight: FontWeight.w600,
            ).paddingSymmetric(horizontal: context.wp(4)),
          ],
        ),
      ),
    );
  }
}

class TimeSlotPicker extends StatelessWidget {
  final DoctorController doctorController;
  final String timeChoose;
  final String dateChoose;

  TimeSlotPicker({
    required this.doctorController,
    required this.timeChoose,
    required this.dateChoose,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current time plus 30 minutes
    DateTime now = DateTime.now().add(Duration(minutes: 30));

    // Combine the selected date with the selected time to create a DateTime object
    DateTime selectedDate = DateTime(
      int.parse(doctorController.doctorState.yearChoose.value),
      int.parse(doctorController.doctorState.monthChoose.value),
      int.parse(dateChoose),
    );

    // Define the morning and afternoon time slots
    List<String> morningSlots = [
      '08:00 - 09:00',
      '09:00 - 10:00',
      '10:00 - 11:00',
      '11:00 - 12:00',
    ];

    List<String> afternoonSlots = [
      '13:00 - 14:00',
      '14:00 - 15:00',
      '15:00 - 16:00',
      '16:00 - 17:00',
    ];

    return Column(
      children: [
        _buildTimeSlotList(context, morningSlots, selectedDate, now),
        SizedBox(height: context.hp(1)),
        _buildTimeSlotList(context, afternoonSlots, selectedDate, now),
      ],
    );
  }

  Widget _buildTimeSlotList(BuildContext context, List<String> slots,
      DateTime selectedDate, DateTime now) {
    return Container(
      height: context.hp(6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: slots.length,
        itemBuilder: (BuildContext context, int index) {
          bool isDisabled = isTimeSlotDisabled(now, selectedDate, slots[index]);

          return GestureDetector(
            onTap: () {
              if (!isDisabled) {
                doctorController.doctorState.timeChoose.value = slots[index];
              }
            },
            child: Container(
              height: context.hp(4),
              width: context.wp(34),
              margin: EdgeInsets.only(
                left: index == 0 ? context.wp(4) : context.wp(0),
                right:
                    index == slots.length - 1 ? context.wp(4) : context.wp(2),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: timeChoose == slots[index] && !isDisabled
                      ? Color(0xFF005495)
                      : Color(0xFFEEF2F6), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Center(
                child: Text(
                  slots[index],
                  style: AppTextStyle.mediumBody(context).copyWith(
                    color: isDisabled
                        ? Colors.grey
                        : Colors.black, // Disable past times
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isTimeSlotDisabled(
      DateTime now, DateTime selectedDate, String timeSlot) {
    List<String> times = timeSlot.split(' - ');
    DateTime slotStartTime = DateFormat('HH:mm').parse(times[0]);
    DateTime slotStartDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      slotStartTime.hour,
      slotStartTime.minute,
    );

    // Check if the selected date is the same as today
    bool isSameDay = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    // If the selected date is today, disable slots in the past
    if (isSameDay) {
      return now.isAfter(slotStartDateTime);
    }

    // If the selected date is in the future, all slots are enabled
    return false;
  }
}

// class TimeSlotPicker extends StatelessWidget {
//   final doctorController doctorController;
//   final String timeChoose;
//   TimeSlotPicker({
//     required this.doctorController,
//     required this.timeChoose,
//   });
//   @override
//   Widget build(BuildContext context) {
//     // Get the current time plus 30 minutes
//     DateTime now = DateTime.now().add(Duration(minutes: 30));
//
//     // Define the morning and afternoon time slots
//     List<String> morningSlots = [
//       '08:00 - 09:00',
//       '09:00 - 10:00',
//       '10:00 - 11:00',
//       '11:00 - 12:00',
//     ];
//
//     List<String> afternoonSlots = [
//       '13:00 - 14:00',
//       '14:00 - 15:00',
//       '15:00 - 16:00',
//       '16:00 - 17:00',
//       '17:00 - 18:00',
//       '18:00 - 19:00',
//     ];
//
//     return Column(
//       children: [
//         Container(
//           height: context.hp(6),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: morningSlots.length,
//             itemBuilder: (BuildContext context, int index) {
//               bool isPast = isTimeSlotPast(now, morningSlots[index]);
//               return GestureDetector(
//                 onTap: () {
//                   if (now.day <
//                       int.parse(
//                           doctorController.doctorState.dateChoose.value)) {
//                     doctorController.doctorState.timeChoose.value =
//                         morningSlots[index];
//                   } else {
//                     Log.info("${now.hour}, ${morningSlots[index]}");
//                   }
//                 },
//                 child: Container(
//                   height: context.hp(4),
//                   width: context.wp(34),
//                   margin: EdgeInsets.only(
//                     left: index == 0 ? context.wp(4) : context.wp(0),
//                     right: index == morningSlots.length - 1
//                         ? context.wp(4)
//                         : context.wp(2),
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     border: Border.all(
//                       color: timeChoose == morningSlots[index]
//                           ? Color(0xFF005495)
//                           : Color(0xFFEEF2F6), // Border color
//                       width: 1.0, // Border width
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       morningSlots[index],
//                       style: AppTextStyle.mediumBody(context).copyWith(
//                         color: isPast
//                             ? Colors.grey
//                             : Colors.black, // Disable past times
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(height: context.hp(1)),
//         Container(
//           height: context.hp(6),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: afternoonSlots.length,
//             itemBuilder: (BuildContext context, int index) {
//               bool isPast = isTimeSlotPast(now, afternoonSlots[index]);
//
//               return GestureDetector(
//                 onTap: () {
//                   doctorController.doctorState.timeChoose.value =
//                       afternoonSlots[index];
//                 },
//                 child: Container(
//                   height: context.hp(4),
//                   width: context.wp(34),
//                   margin: EdgeInsets.only(
//                     left: index == 0 ? context.wp(4) : context.wp(0),
//                     right: index == afternoonSlots.length - 1
//                         ? context.wp(4)
//                         : context.wp(2),
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     border: Border.all(
//                       color: timeChoose == afternoonSlots[index]
//                           ? Color(0xFF005495)
//                           : Color(0xFFEEF2F6), // Border color
//                       width: 1.0, // Border width
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       afternoonSlots[index],
//                       style: AppTextStyle.mediumBody(context).copyWith(
//                         color: isPast
//                             ? Colors.grey
//                             : Colors.black, // Disable past times
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   bool isTimeSlotPast(DateTime now, String timeSlot) {
//     List<String> times = timeSlot.split(' - ');
//     DateTime slotStartTime = DateFormat('HH:mm').parse(times[0]);
//     DateTime slotStartDateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       slotStartTime.hour,
//       slotStartTime.minute,
//     );
//     return now.isAfter(slotStartDateTime);
//   }
// }

// class DaysList extends StatelessWidget {
//   final DateTime selectedMonth;
//   final doctorController doctorController;
//   final String selectedDate;
//
//   DaysList({
//     required this.selectedMonth,
//     required this.doctorController,
//     required this.selectedDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // final doctorController doctorController =
//     //     Get.find<doctorController>();
//     // Get the selected date
//     int currentDay = selectedMonth.day;
//     int lastDayOfMonth =
//         DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
//
//     // Create a list of days from the current day to the end of the month
//     List<int> days = List<int>.generate(
//         lastDayOfMonth - currentDay + 1, (i) => currentDay + i);
//
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.09,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: days.length,
//         itemBuilder: (BuildContext context, int index) {
//           int day = days[index];
//
//           return GestureDetector(
//             onTap: () {
//               Log.info("date choose: $day");
//               doctorController.doctorState.dateChoose.value =
//                   day.toString();
//             },
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.078,
//               width: MediaQuery.of(context).size.width * 0.14,
//               margin: EdgeInsets.only(
//                 left: index == 0
//                     ? MediaQuery.of(context).size.width * 0.04
//                     : MediaQuery.of(context).size.width * 0,
//                 right: index == days.length - 1
//                     ? MediaQuery.of(context).size.width * 0.04
//                     : MediaQuery.of(context).size.width * 0.02,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(
//                   color: doctorController.doctorState.dateChoose.value ==
//                           day.toString()
//                       ? Color(0xFF005495)
//                       : Color(0xFFEEF2F6), // Border color
//                   width: 1.0, // Border width
//                 ),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                     Text(
//                       DateFormat.E('vi_VN').format(DateTime(selectedMonth.year,
//                           selectedMonth.month, day)), // Day of the week
//                       style: AppTextStyle.smallBody(context),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                     Text(
//                       day.toString(),
//                       style: AppTextStyle.bodyH1(context),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class DaysList extends StatelessWidget {
  final DateTime selectedMonth;
  final DoctorController doctorController;
  final String selectedDate;

  DaysList({
    required this.selectedMonth,
    required this.doctorController,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentDay;

    // If the selected month is the current month, start from today
    // Otherwise, start from the first day of the selected month
    if (selectedMonth.year == now.year && selectedMonth.month == now.month) {
      currentDay = now.day;
    } else {
      currentDay = 1;
    }

    int lastDayOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;

    // Create a list of days from the current day to the end of the month
    List<int> days = List<int>.generate(
        lastDayOfMonth - currentDay + 1, (i) => currentDay + i);

    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          int day = days[index];

          return GestureDetector(
            onTap: () {
              Log.info("date choose: $day");
              doctorController.doctorState.dateChoose.value = day.toString();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.078,
              width: MediaQuery.of(context).size.width * 0.14,
              margin: EdgeInsets.only(
                left: index == 0
                    ? MediaQuery.of(context).size.width * 0.04
                    : MediaQuery.of(context).size.width * 0,
                right: index == days.length - 1
                    ? MediaQuery.of(context).size.width * 0.04
                    : MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: doctorController.doctorState.dateChoose.value ==
                          day.toString()
                      ? Color(0xFF005495)
                      : Color(0xFFEEF2F6), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      DateFormat.E('vi_VN').format(DateTime(selectedMonth.year,
                          selectedMonth.month, day)), // Day of the week
                      style: AppTextStyle.smallBody(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      day.toString(),
                      style: AppTextStyle.bodyH1(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class MonthYearPicker extends StatefulWidget {
//   final DateTime initialDate;
//   final doctorController doctorController;
//   final ValueChanged<DateTime> onDateChanged;
//
//   MonthYearPicker({
//     required this.initialDate,
//     required this.doctorController,
//     required this.onDateChanged,
//   });
//
//   @override
//   _MonthYearPickerState createState() => _MonthYearPickerState();
// }
//
// class _MonthYearPickerState extends State<MonthYearPicker> {
//   late int selectedMonth;
//   late int selectedYear;
//   late DateTime firstDate;
//   late DateTime lastDate;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedMonth = widget.initialDate.month;
//     selectedYear = widget.initialDate.year;
//
//     firstDate = DateTime(selectedYear, selectedMonth);
//     lastDate = DateTime(selectedYear + 1, selectedMonth);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Chọn tháng và năm'),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(context.sp(4))),
//       ),
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           DropdownButton<int>(
//             value: selectedMonth,
//             items: _buildMonthItems(),
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   selectedMonth = value;
//                 });
//               }
//             },
//           ),
//           DropdownButton<int>(
//             value: selectedYear,
//             items: _buildYearItems(),
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   selectedYear = value;
//                   // Điều chỉnh tháng nếu năm thay đổi đến năm hiện tại
//                   if (selectedYear == firstDate.year &&
//                       selectedMonth < firstDate.month) {
//                     selectedMonth = firstDate.month;
//                   }
//                   if (selectedYear == lastDate.year &&
//                       selectedMonth > lastDate.month) {
//                     selectedMonth = lastDate.month;
//                   }
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             'Hủy',
//             style: AppTextStyle.linkH5(context),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             widget.onDateChanged(DateTime(selectedYear, selectedMonth));
//             widget.doctorController.doctorState.monthChoose.value =
//                 selectedMonth.toString();
//             widget.doctorController.doctorState.yearChoose.value =
//                 selectedYear.toString();
//             widget.doctorController.doctorState.dateChoose.value =
//                 1.toString();
//             Navigator.pop(context);
//           },
//           child: Text(
//             'Đồng ý',
//             style: AppTextStyle.linkH5(context),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<DropdownMenuItem<int>> _buildMonthItems() {
//     final items = <DropdownMenuItem<int>>[];
//
//     for (var month = 1; month <= 12; month++) {
//       if (selectedYear == firstDate.year && month < firstDate.month) {
//         continue;
//       }
//       if (selectedYear == lastDate.year && month > lastDate.month) {
//         continue;
//       }
//       items.add(
//         DropdownMenuItem(
//           child: Text(DateFormat.MMMM('vi_VN').format(DateTime(0, month))),
//           value: month,
//         ),
//       );
//     }
//     return items;
//   }
//
//   List<DropdownMenuItem<int>> _buildYearItems() {
//     final items = <DropdownMenuItem<int>>[];
//
//     for (var year = firstDate.year; year <= lastDate.year; year++) {
//       items.add(
//         DropdownMenuItem(
//           child: Text('$year'),
//           value: year,
//         ),
//       );
//     }
//     return items;
//   }
// }

class MonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final DoctorController doctorController;
  final ValueChanged<DateTime> onDateChanged;

  MonthYearPicker({
    required this.initialDate,
    required this.doctorController,
    required this.onDateChanged,
  });

  @override
  _MonthYearPickerState createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  late int selectedMonth;
  late int selectedYear;
  late DateTime firstDate;
  late DateTime lastDate;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now(); // Get the current date
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;

    firstDate = DateTime(currentDate.year, currentDate.month);
    lastDate = DateTime(selectedYear + 1, selectedMonth);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chọn tháng và năm'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(context.sp(4))),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropdownButton<int>(
            value: selectedMonth,
            items: _buildMonthItems(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedMonth = value;
                });
              }
            },
          ),
          DropdownButton<int>(
            value: selectedYear,
            items: _buildYearItems(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedYear = value;

                  // Ensure the selected month is valid for the selected year
                  if (selectedYear == currentDate.year &&
                      selectedMonth < currentDate.month) {
                    selectedMonth = currentDate.month;
                  }
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel'.tr,
            style: AppTextStyle.linkH5(context),
          ),
        ),
        TextButton(
          onPressed: () {
            widget.onDateChanged(DateTime(selectedYear, selectedMonth));
            widget.doctorController.doctorState.monthChoose.value =
                selectedMonth.toString();
            widget.doctorController.doctorState.yearChoose.value =
                selectedYear.toString();
            if (DateTime.now().month < selectedMonth ||
                DateTime.now().year < selectedYear) {
              widget.doctorController.doctorState.dateChoose.value =
                  1.toString();
            } else {
              widget.doctorController.doctorState.dateChoose.value =
                  DateTime.now().day.toString();
            }

            Navigator.pop(context);
          },
          child: Text(
            'agree'.tr,
            style: AppTextStyle.linkH5(context),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<int>> _buildMonthItems() {
    final items = <DropdownMenuItem<int>>[];

    for (var month = 1; month <= 12; month++) {
      // Only restrict months if the selected year is the current year
      if (selectedYear == currentDate.year && month < currentDate.month) {
        continue;
      }
      items.add(
        DropdownMenuItem(
          child: Text(DateFormat.MMMM('vi_VN').format(DateTime(0, month))),
          value: month,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildYearItems() {
    final items = <DropdownMenuItem<int>>[];

    for (var year = currentDate.year; year <= lastDate.year; year++) {
      items.add(
        DropdownMenuItem(
          child: Text('$year'),
          value: year,
        ),
      );
    }
    return items;
  }
}
