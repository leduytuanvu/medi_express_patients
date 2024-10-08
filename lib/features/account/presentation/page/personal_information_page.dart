import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_drop_down_box_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class PersonalInformationPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  PersonalInformationPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
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
                      'personal_information'.tr,
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
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
                child: Column(
                  children: [
                    SizedBox(height: context.hp(3)),
                    CustomTextFieldWidget(
                      labelText: 'full_name'.tr,
                      controller: authController.fullNameController,
                      showClearText: false,
                      errorText: authController.authState.errorFullName,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Email',
                      controller: authController.emailController,
                      type: TextFieldType.gmail,
                      errorText: authController.authState.errorEmail,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'date_of_birth'.tr,
                      controller: authController.birthdateController,
                      type: TextFieldType.dateTime,
                      errorText: authController.authState.errorBirthdate,
                    ),
                    Obx(() {
                      return CustomDropDownBoxWidget<String>(
                        labelText: 'gender'.tr,
                        borderRadius: 8.0,
                        items: authController.authState.listGender,
                        displayItem: (gender) => gender,
                        selectedItem: accountController
                                .accountState.selectedGender.value.isEmpty
                            ? null
                            : accountController
                                .accountState.selectedGender.value,
                        onChanged: (String? gender) {
                          if (gender != null) {
                            Log.info(gender);
                            accountController
                                .accountState.selectedGender.value = gender;
                            authController.genderController.text = gender;
                            authController.authState.genderId.value =
                                gender == 'Nam' ? 1 : 0;
                          }
                        },
                        errorText: authController.authState.errorGender,
                      );
                    }),
                    Obx(() {
                      return CustomDropDownBoxWidget<CityEntity>(
                        labelText: 'Tỉnh/thành phố',
                        borderRadius: 8.0,
                        items: accountController.accountState.listAllCity,
                        displayItem: (city) => city.name,
                        selectedItem: accountController.accountState.city.value,
                        onChanged: (CityEntity? city) {
                          accountController.accountState.city.value = city;
                          accountController.accountState.district.value = null;
                          accountController.accountState.ward.value = null;
                          accountController.accountState.listAllWard.value = [];
                          accountController.getDistrictByCity(city!.id);
                          authController.cityController.text = city.name;
                        },
                        errorText: authController.authState.errorCity,
                      );
                    }),
                    Obx(() {
                      return CustomDropDownBoxWidget<DistrictEntity>(
                        labelText: 'district'.tr,
                        borderRadius: 8.0,
                        items: accountController.accountState.listAllDistrict,
                        displayItem: (district) => district.districtName,
                        selectedItem:
                            accountController.accountState.district.value,
                        onChanged: (DistrictEntity? district) {
                          Log.info(district?.districtName ?? '');
                          accountController.accountState.district.value =
                              district;
                          accountController.accountState.ward.value = null;
                          accountController.accountState.listAllWard.value = [];
                          accountController.getWardByDistrict(district!.id);
                          authController.districtController.text =
                              district.districtName;
                        },
                        errorText: authController.authState.errorDistrict,
                      );
                    }),
                    Obx(() {
                      return CustomDropDownBoxWidget<WardEntity>(
                        labelText: 'ward_commune'.tr,
                        borderRadius: 8.0,
                        items: accountController.accountState.listAllWard,
                        displayItem: (ward) => ward.wardName,
                        selectedItem: accountController.accountState.ward.value,
                        onChanged: (WardEntity? ward) {
                          Log.info(ward?.wardName ?? '');
                          accountController.accountState.ward.value = ward;
                          authController.wardController.text = ward!.wardName;
                          authController.authState.wardId.value = ward.id;
                        },
                        errorText: authController.authState.errorWard,
                      );
                    }),
                    CustomTextFieldWidget(
                      labelText: 'specific_address'.tr,
                      controller: authController.addressController,
                      errorText: authController.authState.errorAddress,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'health_insurance_book'.tr,
                      controller: authController.bhytController,
                      errorText: authController.authState.errorBhyt,
                    ),
                    CustomButtonWidget(
                      height: context.hp(6),
                      width: context.wp(100),
                      title: "update".tr,
                      onPressed: () async {
                        // Handle button press
                        FocusScope.of(context).unfocus();
                        // authController.enterInformation(context);
                        accountController.updateInformation();
                      },
                      color: const Color(0xffCF4375),
                      titleSize: context.sp(14),
                      radius: context.rp(10),
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: context.hp(20)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
