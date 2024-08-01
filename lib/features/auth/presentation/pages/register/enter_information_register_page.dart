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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
            child: Column(
              children: [
                SizedBox(height: context.hp(4)),
                Text(
                  'Thông tin cá nhân',
                  style: AppTextStyle.mediumTitle(context),
                ),
                SizedBox(height: context.hp(3)),
                CustomTextFieldWidget(
                  labelText: 'Họ tên',
                  controller: authController.fullNameController,
                  showClearText: false,
                  errorText: authController.state.errorFullName,
                ),
                CustomTextFieldWidget(
                  labelText: 'Email',
                  controller: authController.emailController,
                  type: TextFieldType.gmail,
                  errorText: authController.state.errorEmail,
                ),
                CustomTextFieldWidget(
                  labelText: 'Ngày sinh',
                  controller: authController.birthdateController,
                  type: TextFieldType.dateTime,
                  errorText: authController.state.errorBirthdate,
                ),
                CustomDropDownBoxWidget<String>(
                  labelText: 'Giới tính',
                  borderRadius: 8.0,
                  items: authController.state.listGender,
                  displayItem: (gender) => gender,
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
                  selectedItem: null,
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
                  displayItem: (district) => district.districtName,
                  selectedItem: null,
                  onChanged: (DistrictEntity? district) {
                    Log.info(district?.districtName ?? '');
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
                  displayItem: (ward) => ward.wardName,
                  selectedItem: null,
                  onChanged: (WardEntity? ward) {
                    Log.info(ward?.wardName ?? '');
                    authController.wardController.text = ward!.wardName;
                    authController.state.wardId.value = ward.id;
                  },
                  errorText: authController.state.errorWard,
                ),
                CustomTextFieldWidget(
                  labelText: 'Địa chỉ cụ thể',
                  controller: authController.addressController,
                  errorText: authController.state.errorAddress,
                ),
                CustomTextFieldWidget(
                  labelText: 'Sổ BHYT',
                  controller: authController.bhytController,
                  errorText: authController.state.errorBhyt,
                ),
                CustomButtonWidget(
                  height: context.hp(6),
                  width: context.wp(100),
                  title: "Xác nhận",
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
                SizedBox(height: context.hp(50)),
              ],
            ),
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
