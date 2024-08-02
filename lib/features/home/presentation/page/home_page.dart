import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: context.hp(40),
    //   child: Stack(
    //     children: [
    //       _header(context, homeController),
    //       _body(context, homeController),
    //       Align(
    //         alignment: Alignment.topCenter,
    //         child: Image.asset(
    //           Assets.png.banner3x,
    //           width: context.wp(98),
    //         ),
    //       ).paddingOnly(top: context.hp(9)),
    //     ],
    //   ),
    // );

    return SingleChildScrollView(
      child: Column(
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
                      SvgPicture.asset(Assets.svg.bell),
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
          // Container(
          //   height: context.hp(20),
          //   width: context.wp(100),
          //   color: Colors.white,
          // ),
          // Container(
          //   height: context.hp(20),
          //   width: context.wp(100),
          //   color: Colors.white,
          // ),
          // Container(
          //   height: context.hp(20),
          //   width: context.wp(100),
          //   color: Colors.white,
          // ),
          // Container(
          //   height: context.hp(20),
          //   width: context.wp(100),
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }

  Positioned _body(BuildContext context, HomeController homeController) {
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
        height: context.hp(74),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
          child: Column(
            children: [
              SizedBox(height: context.hp(4)),
              Text(
                'Nhập số điện thoại',
                style: AppTextStyle.mediumTitle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _header(BuildContext context, HomeController homeController) {
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
        height: context.hp(27),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              Text(
                'Chào, Tuan Vu',
                style: AppTextStyle.bigTitle(context),
              ),
              const Spacer(),
              SvgPicture.asset(Assets.svg.bell),
            ],
          ),
        ).paddingOnly(
          top: context.hp(6),
          left: context.wp(4),
          right: context.wp(4),
        ),
      ),
    );
  }
}
