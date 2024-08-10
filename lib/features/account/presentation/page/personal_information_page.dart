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
                      'Thông tin cá nhân',
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
                      labelText: 'Họ tên',
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
                      labelText: 'Ngày sinh',
                      controller: authController.birthdateController,
                      type: TextFieldType.dateTime,
                      errorText: authController.authState.errorBirthdate,
                    ),
                    CustomDropDownBoxWidget<String>(
                      labelText: 'Giới tính',
                      borderRadius: 8.0,
                      items: authController.authState.listGender,
                      displayItem: (gender) => gender,
                      selectedItem: null,
                      onChanged: (String? gender) {
                        Log.info(gender ?? '');
                        authController.genderController.text = gender ?? '';
                        authController.authState.genderId.value =
                            gender == 'Nam' ? 1 : 0;
                      },
                      errorText: authController.authState.errorGender,
                    ),
                    CustomDropDownBoxWidget<CityEntity>(
                      labelText: 'Tỉnh/thành phố',
                      borderRadius: 8.0,
                      items: authController.authState.listAllCity,
                      displayItem: (city) => city.name,
                      selectedItem: null,
                      onChanged: (CityEntity? city) {
                        authController.getDistrictByCity(city!.id);
                        authController.cityController.text = city.name;
                      },
                      errorText: authController.authState.errorCity,
                    ),
                    CustomDropDownBoxWidget<DistrictEntity>(
                      labelText: 'Quận/huyện',
                      borderRadius: 8.0,
                      items: authController.authState.listAllDistrict,
                      displayItem: (district) => district.districtName,
                      selectedItem: null,
                      onChanged: (DistrictEntity? district) {
                        Log.info(district?.districtName ?? '');
                        authController.getWardByDistrict(district!.id);
                        authController.districtController.text =
                            district.districtName;
                      },
                      errorText: authController.authState.errorDistrict,
                    ),
                    CustomDropDownBoxWidget<WardEntity>(
                      labelText: 'Phường/xã',
                      borderRadius: 8.0,
                      items: authController.authState.listAllWard,
                      displayItem: (ward) => ward.wardName,
                      selectedItem: null,
                      onChanged: (WardEntity? ward) {
                        Log.info(ward?.wardName ?? '');
                        authController.wardController.text = ward!.wardName;
                        authController.authState.wardId.value = ward.id;
                      },
                      errorText: authController.authState.errorWard,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Địa chỉ cụ thể',
                      controller: authController.addressController,
                      errorText: authController.authState.errorAddress,
                    ),
                    CustomTextFieldWidget(
                      labelText: 'Sổ BHYT',
                      controller: authController.bhytController,
                      errorText: authController.authState.errorBhyt,
                    ),
                    CustomButtonWidget(
                      height: context.hp(6),
                      width: context.wp(100),
                      title: "Cập nhật",
                      onPressed: () async {
                        // Handle button press
                        FocusScope.of(context).unfocus();
                        authController.enterInformation(context);
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
