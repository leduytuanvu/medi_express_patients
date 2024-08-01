// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:medi_express_application_for_patients/core/utils/common/assets.dart';
// import 'package:medi_express_application_for_patients/core/utils/extensions/extensions.dart';
// import 'package:medi_express_application_for_patients/core/utils/theme/app_text_style.dart';
// import 'package:medi_express_application_for_patients/core/widgets/custom_button_widget.dart';
// import 'package:medi_express_application_for_patients/routes/app_routes.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class IntroPage extends StatefulWidget {
//   const IntroPage({super.key});

//   @override
//   State<IntroPage> createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pages = List.generate(
//       3,
//       (index) => Container(
//         decoration: const BoxDecoration(),
//         margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               Assets.svg.onboardingIntroFirst,
//               width: context.wp(70),
//               height: context.wp(70),
//             ),
//             SizedBox(height: context.wp(22)),
//             Text(
//               'Quản lý và chia sẻ Hồ sơ sức khỏe',
//               textAlign: TextAlign.center,
//               style: AppTextStyles.bepro(
//                 fontWeight: FontWeight.w700,
//                 fontSize: context.sp(19),
//               ),
//             ),
//             SizedBox(height: context.wp(4)),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: context.wp(14)),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 'Lịch sử khám chữa bệnh, tiêm chủng… được tự động cập nhật từ các cơ sở Khám chữa bệnh.',
//                 style: AppTextStyles.bepro(
//                   color: const Color(0xFF777F89),
//                   height: 1.7,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );

//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             flex: 6,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: pages.length,
//                       itemBuilder: (_, index) {
//                         return pages[index % pages.length];
//                       },
//                     ),
//                   ),
//                 ),
//                 SmoothPageIndicator(
//                   controller: _pageController,
//                   count: pages.length,
//                   effect: ExpandingDotsEffect(
//                     dotHeight: context.hp(0.66),
//                     dotWidth: context.wp(2.6),
//                     expansionFactor: 4.0,
//                     spacing: 4.0,
//                     dotColor: const Color(0xFFE3E8EF),
//                     activeDotColor: const Color(0xFF005495),
//                   ),
//                 ),
//                 SizedBox(height: context.hp(3))
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: context.wp(6),
//                 right: context.wp(6),
//               ),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       context.navigateReplacementALL(AppRoutes.login);
//                     },
//                     child: const Text('Bỏ qua').bepro,
//                   ),
//                   const Spacer(),
//                   CustomButtonWidget(
//                     height: context.hp(6),
//                     width: context.wp(44),
//                     title: "Tiếp theo",
//                     onPressed: () {
//                       final currentPage = _pageController.page?.toInt() ?? 0;
//                       if (currentPage == pages.length - 1) {
//                         context.navigateReplacementALL(AppRoutes.login);
//                       } else {
//                         _pageController.animateToPage(
//                           currentPage + 1,
//                           duration: const Duration(milliseconds: 400),
//                           curve: Curves.easeInOut,
//                         );
//                       }
//                     },
//                     color: const Color(0xffCF4375),
//                     titleSize: context.sp(14),
//                     radius: context.rp(10),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
