import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';

class DiagnosticImagingPage extends BaseStatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  DiagnosticImagingPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    homeController.getAllHealthRecord();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    'Chuẩn đoán hình ảnh',
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // context.backScreen();
                    },
                    child: SizedBox(
                      height: context.hp(7),
                      width: context.wp(16),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ),
        ],
      ),
    );
  }
}
