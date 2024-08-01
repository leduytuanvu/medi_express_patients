import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_drop_down_box_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class EnterInformationRegisterPage extends BaseStatelessWidget {
  EnterInformationRegisterPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _content(context, authController),
    );
  }

  Stack _content(BuildContext context, AuthController authController) {
    return Stack(
      children: [
        _header(context, authController),
        _body(context, authController),
      ],
    );
  }

  Positioned _body(BuildContext context, AuthController authController) {
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
        height: context.hp(88),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
          child: Column(
            children: [
              SizedBox(height: context.hp(4)),
              Text(
                'Thông tin cá nhân',
                style: AppTextStyle.mediumTitle(context),
              ),
              SizedBox(height: context.hp(1)),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: context.hp(3)),
                      CustomTextFieldWidget(
                        labelText: 'Họ tên',
                        controller: authController.fullNameController,
                        showClearText: true,
                        errorText: authController.state.errorPasswordRegister,
                      ),
                      CustomTextFieldWidget(
                        labelText: 'Email',
                        controller: authController.emailController,
                        type: TextFieldType.gmail,
                        errorText: authController.state.errorPasswordRegister,
                      ),
                      CustomTextFieldWidget(
                        labelText: 'Ngày sinh',
                        controller: authController.birthdateController,
                        type: TextFieldType.dateTime,
                        errorText: authController.state.errorPasswordRegister,
                      ),
                      CustomDropDownBoxWidget<String>(
                        labelText: 'Giới tính',
                        borderRadius: 8.0,
                        items: authController.state.listGender,
                        displayItem: (city) => city,
                        selectedItem: null,
                        onChanged: (String? gender) {
                          Log.info(gender ?? '');
                          authController.genderController.text = gender ?? '';
                          authController.state.genderId.value =
                              gender == 'Nam' ? 1 : 0;
                        },
                        errorText: authController.state.errorGender,
                      ),
                      CustomDropDownBoxWidget<CityEntity>(
                        labelText: 'Tỉnh/thành phố',
                        borderRadius: 8.0,
                        items: authController.state.listAllCity,
                        displayItem: (city) => city.name,
                        selectedItem:
                            null, // Default to null for 'Choose an option'
                        onChanged: (CityEntity? city) {
                          authController.getDistrictByCity(city!.id);
                          authController.cityController.text = city.name;
                        },
                        errorText: authController.state.errorCity,
                      ),
                      CustomDropDownBoxWidget<DistrictEntity>(
                        labelText: 'Quận/huyện',
                        borderRadius: 8.0,
                        items: authController.state.listAllDistrict,
                        displayItem: (city) => city.districtName,
                        selectedItem:
                            null, // Default to null for 'Choose an option'
                        onChanged: (DistrictEntity? district) {
                          Log.info(district?.districtName ?? '');
                          // Handle the selected city entity
                          print('Selected city: ${district?.districtName}');
                          authController.getWardByDistrict(district!.id);
                          authController.districtController.text =
                              district.districtName;
                        },
                        errorText: authController.state.errorDistrict,
                      ),
                      CustomDropDownBoxWidget<WardEntity>(
                        labelText: 'Phường/xã',
                        borderRadius: 8.0,
                        items: authController.state.listAllWard,
                        displayItem: (city) => city.wardName,
                        selectedItem:
                            null, // Default to null for 'Choose an option'
                        onChanged: (WardEntity? city) {
                          Log.info(city?.wardName ?? '');
                          // Handle the selected city entity
                          print('Selected city: ${city?.wardName}');
                          authController.wardController.text = city!.wardName;
                          authController.state.wardId.value = city.id;
                        },
                        errorText: authController.state.errorWard,
                      ),
                      CustomTextFieldWidget(
                        labelText: 'Địa chỉ cụ thể',
                        controller: authController.addressController,
                        errorText: authController.state.errorPasswordRegister,
                      ),
                      CustomTextFieldWidget(
                        labelText: 'Sổ BHYT',
                        controller: authController.bhytController,
                      ),
                      CustomButtonWidget(
                        height: context.hp(6),
                        width: context.wp(100),
                        title: "Xác nhận",
                        onPressed: () async {
                          // var validateSuccess = true;
                          // if (authController.fullNameController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorFullName.value =
                          //       'Họ tên không được để trống';
                          // } else {
                          //   authController.state.errorFullName.value = '';
                          // }

                          // if (authController.emailController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorEmail.value =
                          //       'Email không được để trống';
                          // } else if (!EmailValidator.validate(
                          //     authController.emailController.text.trim())) {
                          //   validateSuccess = false;
                          //   authController.state.errorEmail.value =
                          //       'Email không không hợp lệ';
                          // } else {
                          //   authController.state.errorEmail.value = '';
                          // }

                          // if (authController.birthdateController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorBirthdate.value =
                          //       'Ngày sinh không được để trống';
                          // } else {
                          //   authController.state.errorBirthdate.value = '';
                          // }

                          // if (authController.genderController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorGender.value =
                          //       'Giới tính không được để trống';
                          // } else {
                          //   authController.state.errorGender.value = '';
                          // }

                          // if (authController.cityController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorCity.value =
                          //       'Tỉnh/Thành phố không được để trống';
                          // } else {
                          //   authController.state.errorCity.value = '';
                          // }

                          // if (authController.districtController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorDistrict.value =
                          //       'Quận/Huyện không được để trống';
                          // } else {
                          //   authController.state.errorDistrict.value = '';
                          // }

                          // if (authController.wardController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorWard.value =
                          //       'Phường/Xã không được để trống';
                          // } else {
                          //   authController.state.errorWard.value = '';
                          // }

                          // if (authController.addressController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorAddress.value =
                          //       'Địa chỉ không được để trống';
                          // } else {
                          //   authController.state.errorAddress.value = '';
                          // }

                          // if (authController.bhytController.text
                          //     .trim()
                          //     .isEmpty) {
                          //   validateSuccess = false;
                          //   authController.state.errorBhyt.value =
                          //       'Số bảo hiểm y tế không được để trống';
                          // } else {
                          //   authController.state.errorBhyt.value = '';
                          // }

                          // if (validateSuccess) {
                          //   context
                          //       .navigateTo(AppRoutes.enterAnamnesisRegister);
                          // }
                        },
                        color: const Color(0xffCF4375),
                        titleSize: context.sp(14),
                        radius: context.rp(10),
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: context.hp(40)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _header(BuildContext context, AuthController authController) {
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
        height: context.hp(19),
        child: Stack(
          children: [
            Transform.rotate(
              angle: -0.04,
              child: Transform.translate(
                offset: const Offset(0, 10),
                child: Image.asset(
                  Assets.png.backgroundTop4x,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      authController.phoneController.text = '';
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
                    'Đăng kí tài khoản',
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  SizedBox(width: context.wp(16)),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ],
        ),
      ),
    );
  }
}
