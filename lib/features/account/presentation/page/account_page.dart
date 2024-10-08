import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class AccountPage extends StatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  final AuthController authController = Get.find<AuthController>();
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.hp(5).sbh,
        GestureDetector(
          onTap: () {
            authController.authState.errorFullName.value = "";
            authController.authState.errorEmail.value = "";
            authController.authState.errorBirthdate.value = "";
            authController.authState.errorBirthdate.value = "";
            authController.authState.errorCity.value = "";
            authController.authState.errorDistrict.value = "";
            authController.authState.errorWard.value = "";
            authController.authState.errorAddress.value = "";
            authController.authState.errorBhyt.value = "";

            authController.fullNameController.text =
                authController.baseState.user.value.name ?? '';
            authController.emailController.text =
                authController.baseState.user.value.email ?? '';
            authController.birthdateController.text = authController
                    .baseState.user.value.birthDate!
                    .toFormattedDate() ??
                '';
            authController.genderController.text =
                authController.baseState.user.value.gender! ? 'Nam' : 'Nữ';
            accountController.accountState.selectedGender.value =
                authController.baseState.user.value.gender! ? 'Nam' : 'Nữ';
            authController.cityController.text =
                authController.baseState.user.value.fullAddress!.city ?? '';
            authController.districtController.text =
                authController.baseState.user.value.fullAddress!.district ?? '';
            authController.wardController.text =
                authController.baseState.user.value.fullAddress!.ward ?? '';
            authController.addressController.text =
                authController.baseState.user.value.fullAddress!.address ?? '';
            authController.bhytController.text =
                authController.baseState.user.value.bhytCode ?? '';
            context.toNamedScreen(AppRoutes.personalInformation);
          },
          child: Container(
            color: Colors.transparent,
            height: context.hp(12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Log.info("TAP");
                    accountController.pickImage();
                  },
                  child: Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: authController
                              .baseState.user.value.avatar!.isNotEmpty
                          ? CachedNetworkImage(
                              width: context.wp(16),
                              height: context.wp(16),
                              imageUrl:
                                  authController.baseState.user.value.avatar!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                color: Colors.grey[200],
                                strokeWidth: 2,
                              ).paddingAll(context.wp(4)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.asset(
                              Assets.png.user,
                              width: context.wp(16),
                              height: context.wp(16),
                            ),
                    );
                  }),
                ),
                context.wp(4).sbw,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      if (authController
                          .baseState.user.value.name!.isNotEmpty) {
                        return Text(
                          '${authController.baseState.user.value.name}',
                          style: AppTextStyle.mediumItemTitle(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      } else {
                        return Text(
                          'Ẩn danh',
                          style: AppTextStyle.mediumItemTitle(context),
                        );
                      }
                    }),
                    Obx(() {
                      if (authController
                          .baseState.user.value.email!.isNotEmpty) {
                        return Text(
                          '${authController.baseState.user.value.email}',
                          style: AppTextStyle.bigHint(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      } else {
                        return Text(
                          'andanh@gmail.com',
                          style: AppTextStyle.bigHint(context),
                        );
                      }
                    }),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.wp(5),
                ),
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
          ),
        ),
        Divider(
          thickness: context.hp(0.9),
          color: Color(0xFFF4F5F7),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.healthIndex);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            // color: const Color(0xFFF5F6F9),
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(Assets.svg.healthIndex,
                                  color: Color(0xFF52C41A))
                              .paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('health_index'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: context.hp(1.7), horizontal: context.wp(4)),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    authController.authState.errorFullName.value = "";
                    authController.authState.errorEmail.value = "";
                    authController.authState.errorBirthdate.value = "";
                    authController.authState.errorBirthdate.value = "";
                    authController.authState.errorCity.value = "";
                    authController.authState.errorDistrict.value = "";
                    authController.authState.errorWard.value = "";
                    authController.authState.errorAddress.value = "";
                    authController.authState.errorBhyt.value = "";

                    authController.fullNameController.text =
                        authController.baseState.user.value.name ?? '';
                    authController.emailController.text =
                        authController.baseState.user.value.email ?? '';
                    authController.birthdateController.text = authController
                            .baseState.user.value.birthDate!
                            .toFormattedDate() ??
                        '';
                    authController.genderController.text =
                        authController.baseState.user.value.gender!
                            ? 'Nam'
                            : 'Nữ';
                    accountController.accountState.selectedGender.value =
                        authController.baseState.user.value.gender!
                            ? 'Nam'
                            : 'Nữ';
                    authController.cityController.text =
                        authController.baseState.user.value.fullAddress!.city ??
                            '';
                    authController.districtController.text = authController
                            .baseState.user.value.fullAddress!.district ??
                        '';
                    authController.wardController.text =
                        authController.baseState.user.value.fullAddress!.ward ??
                            '';
                    authController.addressController.text = authController
                            .baseState.user.value.fullAddress!.address ??
                        '';
                    authController.bhytController.text =
                        authController.baseState.user.value.bhytCode ?? '';
                    context.toNamedScreen(AppRoutes.personalInformation);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.personalInformation,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('personal_information'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      top: context.hp(1.7),
                      bottom: context.hp(0.4),
                      left: context.wp(4),
                      right: context.wp(4),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                GestureDetector(
                  onTap: () {
                    authController.oldChangePasswordController.text = '';
                    authController.newChangePasswordController.text = '';
                    authController.reNewChangePasswordController.text = '';

                    authController
                        .authState.errorOldPasswordChangePassword.value = '';
                    authController
                        .authState.errorNewPasswordChangePassword.value = '';
                    authController
                        .authState.errorReNewPasswordChangePassword.value = '';
                    context.toNamedScreen(AppRoutes.changePassword);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.changePassword,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('change_password'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      bottom: context.hp(1.7),
                      top: context.hp(0.4),
                      left: context.wp(4),
                      right: context.wp(4),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.settings);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.setting,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('setting'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      top: context.hp(1.7),
                      bottom: context.hp(0.4),
                      left: context.wp(4),
                      right: context.wp(4),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.helper);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.helper,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('support'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      bottom: context.hp(0.4),
                      top: context.hp(0.4),
                      left: context.wp(4),
                      right: context.wp(4),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.language);
                    // String selectedLanguage = "Tiếng Việt"; // Default value
                    // List<String> languages = [
                    //   "Tiếng Việt",
                    //   "English",
                    // ];
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: Text(
                    //         "Chọn ngôn ngữ",
                    //         style: AppTextStyle.mediumBody(context),
                    //         textAlign: TextAlign.center,
                    //       ).paddingOnly(bottom: context.wp(2)),
                    //       content: DropdownButtonFormField<String>(
                    //         value: selectedLanguage,
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.symmetric(
                    //             horizontal: context.wp(4),
                    //             vertical: context.hp(2),
                    //           ),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.all(
                    //               Radius.circular(context.rp(4)),
                    //             ),
                    //             borderSide: BorderSide(
                    //               color: Colors.black, // Set the border color
                    //               width: 1.0, // Set the border thickness
                    //             ),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.all(
                    //               Radius.circular(context.rp(4)),
                    //             ),
                    //             borderSide: BorderSide(
                    //               color: Colors.black, // Set the border color
                    //               width: 1.0, // Set the border thickness
                    //             ),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.all(
                    //               Radius.circular(context.rp(4)),
                    //             ),
                    //             borderSide: BorderSide(
                    //               color: Colors
                    //                   .black, // Set the border color when focused
                    //               width:
                    //                   1.0, // Set the border thickness when focused
                    //             ),
                    //           ),
                    //         ),
                    //         icon: Padding(
                    //           padding: EdgeInsets.only(
                    //               left: context.wp(
                    //                   2)), // Add space between text and icon
                    //           child: Icon(Icons.arrow_drop_down,
                    //               size: context.wp(5)),
                    //         ),
                    //         items: languages.map((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Padding(
                    //               padding:
                    //                   EdgeInsets.zero, // Set custom padding
                    //               child: Text(
                    //                 value,
                    //                 style: AppTextStyle.mediumBody(context),
                    //               ),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         onChanged: (String? newValue) {
                    //           switch (newValue) {
                    //             case 'Tiếng Việt':
                    //               var locale = Locale('vi', 'VN');
                    //               Get.updateLocale(locale);
                    //               break;
                    //             case 'English':
                    //               var locale = Locale('en', 'US');
                    //               Get.updateLocale(locale);
                    //               break;
                    //             case 'French':
                    //               var locale = Locale('fr', 'FR');
                    //               Get.updateLocale(locale);
                    //               break;
                    //           }
                    //           // Update the selected language
                    //           selectedLanguage = newValue!;
                    //
                    //           // Close the dialog
                    //           Navigator.of(context).pop();
                    //
                    //           // Optionally, do something with the selected language
                    //           print('Selected Language: $selectedLanguage');
                    //         },
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(context.rp(4)),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.language,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('language'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      bottom: context.hp(1.7),
                      top: context.hp(0.4),
                      left: context.wp(4),
                      right: context.wp(4),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () async {
                    final AuthController authController =
                        Get.find<AuthController>();
                    authController.logout(context);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.logout,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Text('log_out'.tr),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingSymmetric(
                        vertical: context.hp(1.7), horizontal: context.wp(4)),
                  ),
                ),
                context.hp(6).sbh,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
