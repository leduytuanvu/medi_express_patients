import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
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
                  authController.baseState.titleButtonWarning.value,
              message: authController.baseState.warningMessage.value,
              onConfirm:
                  authController.baseState.warningFunction.value ?? () {},
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        Obx(() {
          if (authController.baseState.errorMessage.value.isNotEmpty) {
            return _buildDialogError(
              context,
              titleButtonError: authController.baseState.titleButtonError.value,
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
}
