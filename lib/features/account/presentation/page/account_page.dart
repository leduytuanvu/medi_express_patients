import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.hp(5).sbh,
        Container(
          height: context.hp(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  Assets.png.avatar1,
                  width: context.wp(16),
                  height: context.wp(16),
                ),
              ),
              context.wp(4).sbw,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Đình Nguyện',
                      style: AppTextStyle.mediumItemTitle(context)),
                  Text('nguyen.@gmail.com',
                      style: AppTextStyle.bigHint(context)),
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
        Divider(
          thickness: context.hp(0.9),
          color: Color(0xFFF4F5F7),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: context.wp(14),
                      width: context.wp(14),
                      decoration: BoxDecoration(
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
                    Text('Chỉ số sức khỏe'),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingSymmetric(
                    vertical: context.hp(1.7), horizontal: context.wp(4)),
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    Log.info('click');
                    context.toNamedScreen(AppRoutes.personalInformation);
                  },
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
                      Text('Thông tin cá nhân'),
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
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.changePassword);
                  },
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
                      Text('Đổi mật khẩu'),
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
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
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
                    Text('Cài đặt'),
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
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                Row(
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
                    Text('Hỗ trợ'),
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
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ).paddingSymmetric(horizontal: context.wp(4)),
                Row(
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
                    Text('Ngôn ngữ'),
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
                Divider(
                  thickness: context.hp(0.9),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
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
                    Text('Đăng xuất'),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingSymmetric(
                    vertical: context.hp(1.7), horizontal: context.wp(4)),
                context.hp(6).sbh,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
