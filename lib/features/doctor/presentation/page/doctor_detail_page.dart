import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/create_appointment_id_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

import '../controller/doctor_controller.dart';

class DoctorDetailPage extends BaseStatelessWidget {
  final DoctorController doctorController = Get.find<DoctorController>();
  DoctorDetailPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final InformationDoctorEntity doctorInformation =
        arguments['doctorInformation'] as InformationDoctorEntity;
    Log.info("doctorInformation: $doctorInformation");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body: _content(context, doctorController, doctorInformation),
      body: GetBuilder<DoctorController>(
        init: DoctorController(
          getAllInformationDoctorUsecase:
              Get.find<GetAllInformationDoctorUsecase>(),
          getDoctorByNameUsecase: Get.find<GetDoctorByNameUsecase>(),
          getDoctorInformationDetailUsecase:
              Get.find<GetDoctorInformationDetailUsecase>(),
          getTypeCreateAppointmentServiceUsecase:
              Get.find<GetTypeCreateAppointmentServiceIdUsecase>(),
          createAppointmentUsecase: Get.find<CreateAppointmentIdUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ),
        initState: (_) {
          Log.info(doctorInformation.toString());
          Log.info(doctorInformation.doctorId.toString());
          // Call the function when the page is first shown
          doctorController
              .getDoctorInformationDetail(doctorInformation.doctorId);
        },
        builder: (controller) {
          return _content(context, doctorController, doctorInformation);
        },
      ),
    );
  }

  Stack _content(
    BuildContext context,
    DoctorController doctorController,
    InformationDoctorEntity doctorInformation,
  ) {
    return Stack(
      children: [
        _header(context, doctorController),
        _body(context, doctorController, doctorInformation),
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: doctorInformation.avatar!.isEmpty
                ? Image.asset(
                    Assets.png.avatarDoctor1x,
                    height: context.wp(20),
                    width: context.wp(20),
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    height: context.wp(20),
                    width: context.wp(20),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: doctorInformation.avatar!,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: Colors.grey[200],
                          strokeWidth: 2,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
          ),
        ).paddingOnly(top: context.hp(12))
      ],
    );
  }

  Positioned _body(
    BuildContext context,
    DoctorController doctorController,
    InformationDoctorEntity doctorInformation,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.rp(26)),
            topRight: Radius.circular(context.rp(26)),
          ),
        ),
        height: context.hp(83),
        child: Column(
          children: [
            context.hp(7).sbh,
            Text(
              '${doctorInformation.degree} ${doctorInformation.name}',
              style: AppTextStyle.bigItemPatientTitle(
                context,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              doctorInformation.major ?? 'Chưa có thông tin',
              style: AppTextStyle.mediumDateTime(context)
                  .copyWith(color: Color(0xFF414852)),
            ),
            Text(
              doctorInformation.specialistDoctor ?? 'Chưa có thông tin',
              style: AppTextStyle.mediumDateTime(context),
            ),
            Text(
              doctorInformation.currentWork ?? 'Chưa có thông tin',
              style: AppTextStyle.mediumDateTime(context),
            ),
            context.hp(2).sbh,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.backScreen();
                      final MainController mainController =
                          Get.find<MainController>();
                      mainController.mainState.doctorInformation.value =
                          doctorInformation;
                      mainController.changePage(3);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8FAFF),
                        borderRadius: BorderRadius.circular(context.rp(4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.svg.record,
                            height: context.wp(4.6),
                            width: context.wp(4.6),
                          ),
                          context.wp(2).sbw,
                          Text(
                            'Tư vấn từ xa',
                            style: AppTextStyle.link(context),
                          )
                        ],
                      ).paddingSymmetric(vertical: context.hp(1.2)),
                    ),
                  ),
                ),
                context.wp(2).sbw,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      doctorController.doctorState.dateChoose.value = '';
                      doctorController.doctorState.timeChoose.value = '';
                      doctorController.doctorState.typeExamAtHome.value = true;
                      doctorController.doctorState.dateChoose.value =
                          '${DateTime.now().day}';
                      doctorController.doctorState.yearChoose.value =
                          '${DateTime.now().year}';
                      doctorController.doctorState.monthChoose.value =
                          '${DateTime.now().month}';
                      Log.info("ididididid: ${doctorInformation.doctorId}");
                      doctorController.doctorState.doctorId =
                          doctorInformation.doctorId;
                      context.toNamedScreen(AppRoutes.bookScheduleId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8FAFF),
                        borderRadius: BorderRadius.circular(context.rp(4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.svg.addCircleBlue,
                            height: context.wp(4.6),
                            width: context.wp(4.6),
                          ),
                          context.wp(2).sbw,
                          Text(
                            'Đặt khám',
                            style: AppTextStyle.link(context),
                          )
                        ],
                      ).paddingSymmetric(vertical: context.hp(1.2)),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            Obx(() {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.hp(1.6).sbh,
                      Text(
                        'Giới thiệu về bác sĩ ${doctorController.doctorState.doctorInformationDetail.value.doctorName}',
                        style: AppTextStyle.bigItemPatientTitle(
                          context,
                        ),
                      ),
                      context.hp(1.8).sbh,
                      Text(
                        '${doctorController.doctorState.doctorInformationDetail.value.information.degree} ${doctorController.doctorState.doctorInformationDetail.value.doctorName}',
                        style: AppTextStyle.bigItemPatientTitle(context)
                            .copyWith(fontSize: context.sp(14)),
                      ),
                      context.hp(0.6).sbh,
                      Text(
                        '${doctorController.doctorState.doctorInformationDetail.value.information.specialistDoctor} - ${doctorController.doctorState.doctorInformationDetail.value.information.currentWork}',
                        style: AppTextStyle.bigItemPatientTitle(context)
                            .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: context.sp(14)),
                      ),
                      // context.hp(0.6).sbh,
                      // Text(
                      //   'Giảng viên trường Đaị học Y Hà Nội',
                      //   style: AppTextStyle.bigItemPatientTitle(
                      //     context,
                      //   ).copyWith(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: context.sp(14)),
                      // ),
                      // context.hp(0.6).sbh,
                      // Text(
                      //   'Bác sĩ tại phòng khám Đa khoa vip 12 clinic',
                      //   style: AppTextStyle.bigItemPatientTitle(
                      //     context,
                      //   ).copyWith(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: context.sp(14)),
                      // ),
                      context.hp(1.4).sbh,
                      Divider(
                        thickness: 1,
                        color: Color(0xFFF4F5F7),
                      ),
                      context.hp(2).sbh,
                      Text(
                        'Quá trình công tác',
                        style: AppTextStyle.bigItemPatientTitle(
                          context,
                        ),
                      ),
                      context.hp(1.8).sbh,
                      for (int i = 0;
                          i <
                              doctorController
                                  .doctorState
                                  .doctorInformationDetail
                                  .value
                                  .workingProcess
                                  .length;
                          i++) ...{
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: context.hp(1)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2, // Adjust flex as needed
                                child: Text(
                                  '${doctorController.doctorState.doctorInformationDetail.value.workingProcess[i].year}:' ??
                                      '',
                                  style: AppTextStyle.mediumDateTime(context),
                                ),
                              ),
                              SizedBox(
                                  width: context
                                      .wp(2)), // Add spacing between texts
                              Expanded(
                                flex: 5, // Adjust flex as needed
                                child: Text(
                                  '${doctorController.doctorState.doctorInformationDetail.value.workingProcess[i].info}',
                                  style: AppTextStyle.mediumDateTime(context),
                                  softWrap: true,
                                  overflow:
                                      TextOverflow.visible, // Allows wrapping
                                ),
                              ),
                            ],
                          ),
                        )
                      },
                      // if (doctorController
                      //     .doctorState
                      //     .doctorInformationDetail
                      //     .value
                      //     .workingProcess
                      //     .length -
                      //     1 >
                      //     i) ...{
                      context.hp(10).sbh,
                      // }
                      // ListView.builder for work history
                      // Container(
                      //   height: context.hp(30), // Adjust height as needed
                      //   child: ListView.builder(
                      //     padding: EdgeInsets.zero,
                      //     itemCount: 10, // Replace with your data length
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.symmetric(vertical: context.hp(1)),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               'Item ${index * 2 + 1}',
                      //               style: AppTextStyle.mediumDateTime(context),
                      //             ),
                      //             Text(
                      //               'Item ${index * 2 + 2}',
                      //               style: AppTextStyle.mediumDateTime(context),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ).paddingSymmetric(vertical: context.hp(2)),
                    ],
                  ).paddingSymmetric(
                      horizontal: context.wp(4), vertical: context.hp(1)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Positioned _header(BuildContext context, DoctorController doctorController) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: context.hp(22),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // authController.phoneController.text = '';
                  context.backScreen();
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
                'Thông tin bác sĩ',
                style: AppTextStyle.appBar(context),
              ),
              const Spacer(),
              SizedBox(width: context.wp(16)),
            ],
          ),
        ).paddingOnly(top: context.hp(4)),
      ),
    );
  }
}
