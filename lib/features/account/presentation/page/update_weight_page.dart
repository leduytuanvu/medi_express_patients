import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class UpdateWeightPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  UpdateWeightPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: context.hp(100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.rp(22)),
              topRight: Radius.circular(context.rp(22)),
            ),
          ),
          // child: Align(
          //   alignment: Alignment.topCenter,
          //   child: Row(
          //     children: [],
          //   ),
          // ).paddingOnly(top: context.hp(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: context.wp(100)),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: context.wp(7),
                  ),
                ),
              ).paddingAll(context.wp(3.4)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chỉ số cân nặng',
                    style: AppTextStyle.mediumTitle(context).copyWith(
                      fontSize: context.sp(17),
                    ),
                  ),
                  context.wp(2).sbh,
                  Text(
                    'Nhập chỉ số hiện tại của bạn',
                    style: AppTextStyle.mediumBody(context),
                  ),
                  context.wp(5).sbh,
                  CustomTextFieldWidget(
                    labelText: 'Ngày đo',
                    controller: accountController.dateTextFieldController,
                    type: TextFieldType.dateTime,
                    errorText: accountController.accountState.errorDateInput,
                  ),
                  CustomTextFieldWidget(
                    labelText: 'Cân nặng',
                    controller: accountController.valueTextFieldController,
                    type: TextFieldType.phone,
                    errorText: accountController.accountState.errorValueInput,
                  ),
                ],
              ).paddingSymmetric(horizontal: context.wp(4)),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    CustomButtonWidget(
                      height: context.hp(6),
                      width: context.wp(45),
                      title: "Hủy",
                      onPressed: () async {
                        // Handle button press
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      color: const Color(0xffCF4375),
                      titleSize: context.sp(14),
                      radius: context.rp(10),
                      fontWeight: FontWeight.w600,
                    ),
                    context.wp(2).sbw,
                    CustomButtonWidget(
                      height: context.hp(6),
                      width: context.wp(45),
                      title: "Lưu",
                      onPressed: () async {
                        // Handle button press
                        FocusScope.of(context).unfocus();
                        accountController.updateWeight(context);
                      },
                      color: const Color(0xffCF4375),
                      titleSize: context.sp(14),
                      radius: context.rp(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ).paddingSymmetric(horizontal: context.wp(4)),
              ),
              context.wp(2).sbh,
            ],
          ),
        ),
      ),
    );
  }
}
