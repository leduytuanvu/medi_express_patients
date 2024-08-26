import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class HeartbeatPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  HeartbeatPage({super.key});

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
                      'Nhịp tim',
                      style: AppTextStyle.appBar(context),
                    ),
                    const Spacer(),
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
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(top: context.hp(4)),
            ),
            SizedBox(height: context.hp(1)),
            Column(
              children: [
                Row(
                  children: [
                    Text('Chỉ số gần đây'),
                    Spacer(),
                    Text('Thêm chỉ số'),
                    Text(' | '),
                    Icon(
                      Icons.share_outlined,
                      color: Color(0xFF005495),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('80 BPM'),
                    Spacer(),
                    Text('Bình thường'),
                  ],
                ),
                Row(
                  children: [
                    Text('08:30 23/09/2021'),
                    Spacer(),
                    SvgPicture.asset(Assets.svg.edit),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text('80 BPM'),
                    Spacer(),
                    Text('Bình thường'),
                  ],
                ),
                Row(
                  children: [
                    Text('08:30 23/09/2021'),
                    Spacer(),
                    SvgPicture.asset(Assets.svg.edit),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
            Divider(),
            Column(
              children: [
                Text('Biểu đồ nhịp tim').paddingSymmetric(
                  horizontal: context.wp(4),
                ),
              ],
            ),
            context.hp(6).sbh,
          ],
        ),
      ),
    );
  }
}
