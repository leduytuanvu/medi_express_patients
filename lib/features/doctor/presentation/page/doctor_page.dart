import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/home/data/model/item_doctor_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';

class DoctorPage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                SizedBox(
                  height: context.hp(7),
                  width: context.wp(16),
                ),
                const Spacer(),
                Text(
                  'Bệnh án',
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
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(context.rp(2)),
            // border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: homeController.serchController,
                  onChanged: (value) {
                    homeController.serchController.text = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tìm bác sĩ',
                    hintStyle: AppTextStyle.searchHint(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Color(0xFF414852),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ).paddingOnly(
          left: context.wp(4),
          right: context.wp(4),
          top: context.wp(4),
          bottom: context.wp(2),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: ItemDoctorModel.list(context).length,
            itemBuilder: (context, index) {
              final item = ItemDoctorModel.list(context)[index];
              return Container(
                // color: Colors.red,
                // margin: EdgeInsets.only(right: context.wp(2)),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item.avatarPath,
                          height: context.hp(15),
                        ),
                        context.wp(4).sbw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // context.hp(2).sbh,
                              Row(
                                children: [
                                  Text(
                                    item.name,
                                    style: AppTextStyle.bigItemPatientTitle(
                                      context,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFFFE9E0D),
                                    size: context.wp(4.8),
                                  ),
                                  context.wp(0.8).sbw,
                                  Text(
                                    '4.2',
                                    style: AppTextStyle.smallBody(context),
                                  )
                                ],
                              ),
                              // context.hp(0.6).sbh,
                              Text(
                                item.description1,
                                style: AppTextStyle.mediumDateTime(context),
                              ),
                              Text(
                                item.description2,
                                style: AppTextStyle.mediumDateTime(context),
                              ),
                              Text(
                                item.description3,
                                style: AppTextStyle.mediumDateTime(context),
                              ),
                              Row(
                                children: [
                                  Text('${item.book1} lượt đặt khám'),
                                  Text('${item.book1} lượt tư vấn')
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    context.hp(1).sbh,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8FAFF),
                              borderRadius:
                                  BorderRadius.circular(context.rp(4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.record,
                                  height: context.wp(4.6),
                                  width: context.wp(4.6),
                                ),
                                context.wp(2).sbw,
                                Text(
                                  'Tư vấn từ xa',
                                  style: AppTextStyle.link(context),
                                )
                              ],
                            ).paddingSymmetric(vertical: context.hp(1.2)),
                          ),
                        ),
                        context.wp(2).sbw,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8FAFF),
                              borderRadius:
                                  BorderRadius.circular(context.rp(4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.addCircleBlue,
                                  height: context.wp(4.6),
                                  width: context.wp(4.6),
                                ),
                                context.wp(2).sbw,
                                Text(
                                  'Đặt khám',
                                  style: AppTextStyle.link(context),
                                )
                              ],
                            ).paddingSymmetric(vertical: context.hp(1.2)),
                          ),
                        ),
                      ],
                    ),
                    
                    Divider(
                      thickness: context.hp(1),
                      color: const Color(0xFFE3E8EF),
                    ),
                  ],
                ),
              );
            },
          ).paddingSymmetric(
            vertical: context.wp(2),
          ),
        ),
      ],
    );
  }
}
