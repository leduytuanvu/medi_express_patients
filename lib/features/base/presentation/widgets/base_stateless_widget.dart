import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';

abstract class BaseStatelessWidget extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildContent(context),
        Obx(() {
          if (authController.baseState.isLoading.value) {
            return const Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        Obx(() {
          if (authController.baseState.warningMessage.value.isNotEmpty) {
            return _buildDialogWarning(
              context,
              titleButtonWarning:
                  authController.baseState.warningTitleButton.value,
              message: authController.baseState.warningMessage.value,
              onConfirm:
                  authController.baseState.warningFunction.value ?? () {},
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        Obx(() {
          if (authController.baseState.confirmMessage.value.isNotEmpty) {
            return _buildDialogConfirm(
              context,
              titleButtonConfirm:
                  authController.baseState.confirmTitleButton.value,
              message: authController.baseState.confirmMessage.value,
              onConfirm:
                  authController.baseState.confirmFunction.value ?? () {},
            );
          } else {
            Log.info("show confirm 2");
            return const SizedBox.shrink();
          }
        }),
        Obx(() {
          if (authController.baseState.errorMessage.value.isNotEmpty) {
            return _buildDialogError(
              context,
              titleButtonError: authController.baseState.errorTitleButton.value,
              message: authController.baseState.errorMessage.value,
              onConfirm: authController.baseState.errorFunction.value ?? () {},
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }

  Widget buildContent(BuildContext context);

  Widget _buildDialogWarning(
    BuildContext context, {
    required String titleButtonWarning,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            elevation: 24,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black, width: 0.2),
            ),
            content: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.hp(3)),
                  Text(
                    message,
                    style: AppTextStyle.mediumBody(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.hp(3)),
                  CustomButtonWidget(
                    height: context.hp(6),
                    width: double.infinity,
                    title: titleButtonWarning,
                    onPressed: () async {
                      Log.info("click");
                      onConfirm();
                    },
                    color: const Color(0xffCF4375),
                    titleSize: context.sp(14),
                    radius: context.rp(10),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogError(
    BuildContext context, {
    required String titleButtonError,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            elevation: 24,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black, width: 0.2),
            ),
            content: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.hp(3)),
                  Text(
                    message,
                    style: AppTextStyle.mediumBody(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.hp(3)),
                  CustomButtonWidget(
                    height: context.hp(6),
                    width: double.infinity,
                    title: titleButtonError,
                    onPressed: () async {
                      Log.info("click");
                      onConfirm();
                    },
                    color: const Color(0xffCF4375),
                    titleSize: context.sp(14),
                    radius: context.rp(10),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogConfirm(
    BuildContext context, {
    required String titleButtonConfirm,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.white,
            elevation: 24,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black, width: 0.2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => authController.clearConfirm(),
                    child: SvgPicture.asset(
                      Assets.svg.close,
                      height: context.wp(9),
                      width: context.wp(9),
                    ).paddingOnly(
                      top: context.wp(1.5),
                      right: context.wp(1.5),
                    ),
                  ),
                ),
                SizedBox(height: context.hp(1)),
                Text(
                  message,
                  style: AppTextStyle.mediumBody(context),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.hp(2)),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget(
                        height: context.hp(5),
                        title: 'Hủy',
                        onPressed: () async {
                          Log.info("click");
                          authController.clearConfirm();
                        },
                        color: const Color(0xffCF4375),
                        titleSize: context.sp(14),
                        radius: context.rp(10),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: context.wp(2)),
                    Expanded(
                      child: CustomButtonWidget(
                        height: context.hp(5),
                        title: titleButtonConfirm,
                        onPressed: () async {
                          Log.info("click");
                          onConfirm();
                        },
                        color: const Color(0xffCF4375),
                        titleSize: context.sp(14),
                        radius: context.rp(10),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: context.wp(4),
                  vertical: context.wp(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
