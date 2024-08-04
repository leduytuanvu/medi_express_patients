// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:medi_express_patients/core/config/log.dart';
// import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
// import 'package:medi_express_patients/core/utils/comon/assets.dart';
// import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
// import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
// import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
// import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
// import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
// import 'package:medi_express_patients/features/home/data/model/home_examination_package_model.dart';
// import 'package:medi_express_patients/features/home/data/model/item_utilities_model.dart';
// import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
// import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';

// class HomePage extends StatelessWidget {
//   final HomeController homeController = Get.find<HomeController>();
//   HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return SizedBox(
//     //   height: context.hp(40),
//     //   child: Stack(
//     //     children: [
//     //       _header(context, homeController),
//     //       _body(context, homeController),
//     //       Align(
//     //         alignment: Alignment.topCenter,
//     //         child: Image.asset(
//     //           Assets.png.banner3x,
//     //           width: context.wp(98),
//     //         ),
//     //       ).paddingOnly(top: context.hp(9)),
//     //     ],
//     //   ),
//     // );

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: context.hp(31),
//             width: context.wp(100),
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: context.hp(5.4),
//                   left: context.hp(0),
//                   right: context.hp(0),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Chào, Tuan Vu',
//                         style: AppTextStyle.bigTitle(context),
//                       ),
//                       const Spacer(),
//                       SvgPicture.asset(Assets.svg.bell),
//                     ],
//                   ).paddingSymmetric(horizontal: context.wp(4)),
//                 ),
//                 Positioned(
//                     top: context.hp(16.4),
//                     left: context.hp(0),
//                     right: context.hp(0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(context.rp(26)),
//                           topRight: Radius.circular(context.rp(26)),
//                         ),
//                       ),
//                       height: context.hp(15.6),
//                       width: context.wp(100),
//                     )),
//                 Positioned(
//                   top: context.hp(8),
//                   left: context.hp(0),
//                   right: context.hp(0),
//                   child: Image.asset(
//                     Assets.png.banner3x,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text('Tiện ích', style: AppTextStyle.mediumItemTitle(context))
//               .paddingOnly(
//             left: context.wp(4),
//             right: context.wp(4),
//             top: context.wp(8),
//             bottom: context.wp(4),
//           ),
//           SizedBox(
//             // color: Colors.amber,
//             height: context.hp(25),
//             child: GridView.builder(
//               padding: const EdgeInsets.all(0),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4, // Number of items per row
//                 crossAxisSpacing: context.wp(0), // Spacing between columns
//                 mainAxisSpacing: context.wp(0), // Spacing between rows
//                 childAspectRatio: 0.9, // Aspect ratio of each item
//               ),
//               itemCount: ItemUtilitiesModel.list(context).length,
//               itemBuilder: (context, index) {
//                 final item = ItemUtilitiesModel.list(context)[index];
//                 return DottedBorder(
//                   color: const Color(0xFFD5D8DD),
//                   dashPattern: const [4, 4],
//                   strokeWidth: 1,
//                   child: SizedBox(
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           item.icon,
//                           context.hp(1.36).sbh,
//                           _buildTwoLineText(context, item.title),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ).paddingOnly(
//             left: context.wp(4),
//             right: context.wp(4),
//             bottom: context.wp(4.2),
//           ),
//           Divider(
//             color: const Color(0xFFF4F5F7),
//             thickness: context.hp(1),
//           ),
//           Row(
//             children: [
//               Text(
//                 'Gói khám tại nhà',
//                 style: AppTextStyle.mediumItemTitle(context),
//               ),
//               const Spacer(),
//               SvgPicture.asset(
//                 Assets.svg.arrorRight,
//               ),
//             ],
//           ).paddingOnly(
//             left: context.wp(4),
//             right: context.wp(4),
//             top: context.wp(6),
//             bottom: context.wp(4),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: context.wp(4), right: context.wp(2)),
//             // height: context.hp(26),
//             // color: Colors.amber,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: ItemHomeExaminationPackageModel.list(context).length,
//                     itemBuilder: (context, index) {
//                       final item =
//                           ItemHomeExaminationPackageModel.list(context)[index];
//                       return Container(
//                         width: context.wp(40), // Set the width of each item
//                         margin: EdgeInsets.only(right: context.wp(2)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(
//                               item.iconPath,
//                               width: context.wp(40),
//                             ),
//                             context.hp(1).sbh,
//                             Text(
//                               item.title,
//                               style: AppTextStyle.bigItemBody(context),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             context.hp(0.3).sbh,
//                             Text(
//                               item.price,
//                               style: AppTextStyle.mediumItemPrice(context),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           context.hp(1.8).sbh,
//           Divider(
//             color: const Color(0xFFF4F5F7),
//             thickness: context.hp(1),
//           ),
//           context.hp(20).sbh,
//         ],
//       ),
//     );
//   }

//   Widget _buildTwoLineText(BuildContext context, String title) {
//     final words = title.split(' ');
//     final half = (words.length / 2).ceil();
//     final firstLine = words.take(half).join(' ');
//     final secondLine = words.skip(half).join(' ');

//     return Column(
//       children: [
//         Text(
//           firstLine,
//           style: AppTextStyle.mediumItemBody(context),
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         Text(
//           secondLine,
//           style: AppTextStyle.mediumItemBody(context),
//           textAlign: TextAlign.center,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }

//   Positioned _body(BuildContext context, HomeController homeController) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(context.rp(26)),
//             topRight: Radius.circular(context.rp(26)),
//           ),
//         ),
//         height: context.hp(74),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
//           child: Column(
//             children: [
//               SizedBox(height: context.hp(4)),
//               Text(
//                 'Nhập số điện thoại',
//                 style: AppTextStyle.mediumTitle(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Positioned _header(BuildContext context, HomeController homeController) {
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
//         height: context.hp(27),
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: Row(
//             children: [
//               Text(
//                 'Chào, Tuan Vu',
//                 style: AppTextStyle.bigTitle(context),
//               ),
//               const Spacer(),
//               SvgPicture.asset(Assets.svg.bell),
//             ],
//           ),
//         ).paddingOnly(
//           top: context.hp(6),
//           left: context.wp(4),
//           right: context.wp(4),
//         ),
//       ),
//     );
//   }
// }

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/home/data/model/item_home_examination_package_model.dart';
import 'package:medi_express_patients/features/home/data/model/item_utilities_model.dart';
import 'package:medi_express_patients/features/home/data/model/item_news_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.hp(31),
            width: context.wp(100),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: context.hp(5.4),
                  left: context.hp(0),
                  right: context.hp(0),
                  child: Row(
                    children: [
                      Text(
                        'Chào, Tuan Vu',
                        style: AppTextStyle.bigTitle(context),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.svg.bell,
                        height: context.wp(7),
                        width: context.wp(7),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: context.wp(4)),
                ),
                Positioned(
                    top: context.hp(16.4),
                    left: context.hp(0),
                    right: context.hp(0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.rp(26)),
                          topRight: Radius.circular(context.rp(26)),
                        ),
                      ),
                      height: context.hp(15.6),
                      width: context.wp(100),
                    )),
                Positioned(
                  top: context.hp(8),
                  left: context.hp(0),
                  right: context.hp(0),
                  child: Image.asset(
                    Assets.png.banner3x,
                  ),
                ),
              ],
            ),
          ),
          Text('Tiện ích', style: AppTextStyle.mediumItemTitle(context))
              .paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(8),
            bottom: context.wp(4),
          ),
          SizedBox(
            height: context.hp(25),
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: context.wp(0),
                mainAxisSpacing: context.wp(0),
                childAspectRatio: 0.9,
              ),
              itemCount: ItemUtilitiesModel.list(context).length,
              itemBuilder: (context, index) {
                final item = ItemUtilitiesModel.list(context)[index];
                return GestureDetector(
                  onTap: () {
                    Log.info("on tap: ${item.title}");
                    // context.toNamedScreen(AppRoutes.patientPage);
                    switch (item.title) {
                      case "Chỉ số sức khỏe":
                        () {
                          Log.info("chỉ số sức khỏe");
                        };
                      case "Đơn thuốc":
                        () {
                          Log.info("đơn thuốc");
                        };
                      case "Tiêm chủng":
                        () {
                          Log.info("tiêm chủng");
                        };
                      case "Lịch khám":
                        () {
                          Log.info("lịch khám");
                        };
                      case "Xét nghiệm":
                        () {
                          Log.info("xét nghiệm");
                        };
                      case "Chuẩn đoán hình ảnh":
                        () {
                          Log.info("chuẩn đoán hình ảnh");
                        };
                      case "Dịch vụ y tế":
                        () {
                          Log.info("dịch vụ y tế");
                        };
                      case "Bệnh án":
                        context.toNamedScreen(AppRoutes.patientPage);
                    }
                  },
                  child: DottedBorder(
                    color: const Color(0xFFD5D8DD),
                    dashPattern: const [4, 4],
                    strokeWidth: 1,
                    child: SizedBox(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            item.icon,
                            context.hp(1.36).sbh,
                            _buildTwoLineText(context, item.title),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            bottom: context.wp(4.2),
          ),
          Divider(
            color: const Color(0xFFF4F5F7),
            thickness: context.hp(1),
          ),
          Row(
            children: [
              Text(
                'Gói khám tại nhà',
                style: AppTextStyle.mediumItemTitle(context),
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.svg.arrorRight,
              ),
            ],
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(6),
            bottom: context.wp(4),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: context.hp(26),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        ItemHomeExaminationPackageModel.list(context).length,
                    itemBuilder: (context, index) {
                      final item =
                          ItemHomeExaminationPackageModel.list(context)[index];
                      return Container(
                        width: context.wp(40),
                        margin: EdgeInsets.only(
                          right: ItemHomeExaminationPackageModel.list(context)
                                          .length -
                                      1 ==
                                  index
                              ? context.wp(4)
                              : context.wp(2),
                          left: index == 0 ? context.wp(4) : context.wp(0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              item.iconPath,
                              width: context.wp(40),
                            ),
                            context.hp(1).sbh,
                            Text(
                              item.title,
                              style: AppTextStyle.bigItemBody(context),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            context.hp(0.3).sbh,
                            Text(
                              item.price,
                              style: AppTextStyle.mediumItemPrice(context),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          context.hp(1.8).sbh,
          Divider(
            color: const Color(0xFFF4F5F7),
            thickness: context.hp(1),
          ),
          Row(
            children: [
              Text(
                'Tin tức',
                style: AppTextStyle.mediumItemTitle(context),
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.svg.arrorRight,
              ),
            ],
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(6),
            bottom: context.wp(4),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: context.hp(26),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ItemNewsModel.list(context).length,
                    itemBuilder: (context, index) {
                      final item = ItemNewsModel.list(context)[index];
                      return Container(
                        width: context.wp(40),
                        margin: EdgeInsets.only(
                          right: ItemNewsModel.list(context)
                              .length -
                              1 ==
                              index
                              ? context.wp(4)
                              : context.wp(2),
                          left: index == 0 ? context.wp(4) : context.wp(0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              item.iconPath,
                              width: context.wp(40),
                            ),
                            context.hp(1).sbh,
                            Text(
                              item.title,
                              style: AppTextStyle.bigItemBody(context),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          context.hp(10).sbh,
        ],
      ),
    );
  }

  Widget _buildTwoLineText(BuildContext context, String title) {
    final words = title.split(' ');
    final half = (words.length / 2).ceil();
    final firstLine = words.take(half).join(' ');
    final secondLine = words.skip(half).join(' ');

    return Column(
      children: [
        Text(
          firstLine,
          style: AppTextStyle.mediumItemBody(context),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          secondLine,
          style: AppTextStyle.mediumItemBody(context),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
