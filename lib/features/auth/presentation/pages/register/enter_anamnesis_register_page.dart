// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:medi_express_application_for_patients/core/presentation/controllers/global_controller.dart';
// import 'package:medi_express_application_for_patients/core/utils/common/assets.dart';
// import 'package:medi_express_application_for_patients/core/utils/extensions/context_extension.dart';
// import 'package:medi_express_application_for_patients/core/utils/theme/app_colors.dart';
// import 'package:medi_express_application_for_patients/core/utils/theme/app_text_style.dart';
// import 'package:medi_express_application_for_patients/core/widgets/custom_button_widget.dart';
// import 'package:medi_express_application_for_patients/core/widgets/custom_text_field_widget.dart';
// import 'package:medi_express_application_for_patients/features/auth/presentation/controller/auth_controller.dart';
// import 'package:medi_express_application_for_patients/routes/app_routes.dart';

// class EnterAnamnesisRegisterPage extends StatelessWidget {
//   const EnterAnamnesisRegisterPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();
//     final GlobalController globalController = Get.find<GlobalController>();

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: _content(context, authController, globalController),
//     );
//   }

//   Stack _content(BuildContext context, AuthController authController,
//       GlobalController globalController) {
//     return Stack(
//       children: [
//         _header(context, authController),
//         _body(context, authController, globalController),
//       ],
//     );
//   }

//   Positioned _body(BuildContext context, AuthController authController,
//       GlobalController globalController) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(context.rp(26)),
//             topRight: Radius.circular(context.rp(26)),
//           ),
//         ),
//         height: context.hp(88),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
//           child: Column(
//             children: [
//               SizedBox(height: context.hp(4)),
//               Text(
//                 'Tiền sử bệnh',
//                 style: AppTextStyles.bepro(
//                   fontSize: context.sp(17),
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: context.hp(3)),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.hypertension.value =
//                                         !authController
//                                             .state.hypertension.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(
//                                       authController.state.hypertension.value
//                                           ? Icons.check_box_outlined
//                                           : Icons.check_box_outline_blank),
//                                 )),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Cao huyết áp',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.diabetes.value =
//                                         !authController.state.diabetes.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(
//                                       authController.state.diabetes.value
//                                           ? Icons.check_box_outlined
//                                           : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Bệnh hen suyễn',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.heartDisease.value =
//                                         !authController
//                                             .state.heartDisease.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(
//                                       authController.state.heartDisease.value
//                                           ? Icons.check_box_outlined
//                                           : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Đột quỵ',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.stroke.value =
//                                         !authController.state.stroke.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(authController.state.stroke.value
//                                       ? Icons.check_box_outlined
//                                       : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Rung nhĩ',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // const Spacer(),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.asthma.value =
//                                         !authController.state.asthma.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(authController.state.asthma.value
//                                       ? Icons.check_box_outlined
//                                       : Icons.check_box_outline_blank),
//                                 )),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Tiểu đường',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.epilepsy.value =
//                                         !authController.state.epilepsy.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(
//                                       authController.state.epilepsy.value
//                                           ? Icons.check_box_outlined
//                                           : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Text(
//                               'Bệnh động kinh',
//                               style: AppTextStyles.bepro(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.copd.value =
//                                         !authController.state.copd.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(authController.state.copd.value
//                                       ? Icons.check_box_outlined
//                                       : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Phổi tắc nghẽn',
//                                   style: AppTextStyles.bepro(),
//                                 ),
//                                 Text(
//                                   'mãn tính',
//                                   style: AppTextStyles.bepro(),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: context.hp(2)),
//                         Row(
//                           children: [
//                             Obx(() => GestureDetector(
//                                   onTap: () {
//                                     authController.state.palpitations.value =
//                                         !authController
//                                             .state.palpitations.value;
//                                   },
//                                   // child: SvgPicture.asset(
//                                   //   Assets.svg.authCheckBox,
//                                   //   height: context.wp(6),
//                                   //   width: context.wp(6),
//                                   // ),
//                                   child: Icon(
//                                       authController.state.palpitations.value
//                                           ? Icons.check_box_outlined
//                                           : Icons.check_box_outline_blank),
//                                 )),
//                             // SvgPicture.asset(
//                             //   Assets.svg.authCheckBox,
//                             //   height: context.wp(6),
//                             //   width: context.wp(6),
//                             // ),
//                             SizedBox(width: context.wp(3)),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Đau tim',
//                                   style: AppTextStyles.bepro(),
//                                   maxLines: 2,
//                                 ),
//                                 Text(
//                                   'Nhồi máu cơ tim',
//                                   style: AppTextStyles.bepro(),
//                                   maxLines: 2,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: context.hp(2)),
//               CustomTextFieldWidget(
//                 labelText: 'Khác (nêu rõ)',
//                 controller: authController.anotherController,
//               ),
//               SizedBox(height: context.hp(2)),
//               const Spacer(),
//               CustomButtonWidget(
//                 height: context.hp(6),
//                 width: context.wp(100),
//                 title: "Hoàn tất",
//                 onPressed: () async {
//                   authController.register();
//                 },
//                 color: const Color(0xffCF4375),
//                 titleSize: context.sp(14),
//                 radius: context.rp(10),
//                 fontWeight: FontWeight.w600,
//               ),
//               SizedBox(height: context.hp(1.4)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Positioned _header(BuildContext context, AuthController authController) {
//     return Positioned(
//       top: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//         height: context.hp(15),
//         child: Stack(
//           children: [
//             Transform.rotate(
//               angle: 0.04,
//               child: Transform.translate(
//                 offset: const Offset(-80, 10),
//                 child: Image.asset(
//                   Assets.png.authBackgroundTop,
//                   height: context.hp(300),
//                   width: context.wp(300),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: context.wp(4)),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         context.pop();
//                       },
//                       child: SvgPicture.asset(
//                         Assets.svg.sharedChevronLeft,
//                         width: context.wp(7),
//                         height: context.wp(7),
//                       ),
//                     ),
//                     const Spacer(),
//                     Text(
//                       'Đăng kí tài khoản',
//                       style: AppTextStyles.bepro(
//                         color: AppColors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: context.sp(16),
//                       ),
//                     ),
//                     const Spacer(),
//                     SizedBox(width: context.wp(7)),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
