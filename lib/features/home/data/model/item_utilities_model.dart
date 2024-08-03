import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class ItemUtilitiesModel {
  final String title;
  final Widget icon;

  ItemUtilitiesModel({required this.title, required this.icon});

  @override
  String toString() => 'ItemUtilitiesModel{title: $title, icon: $icon}';

  static List<ItemUtilitiesModel> list(BuildContext context) {
    return [
      ItemUtilitiesModel(
          title: 'Chỉ số sức khỏe',
          icon: SvgPicture.asset(
            Assets.svg.healthIndex,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Đơn thuốc',
          icon: SvgPicture.asset(
            Assets.svg.prescription,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Tiêm chủng',
          icon: SvgPicture.asset(
            Assets.svg.vacine,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Lịch khám',
          icon: SvgPicture.asset(
            Assets.svg.examSchedule,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Xét nghiệm',
          icon: SvgPicture.asset(
            Assets.svg.test,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Chuẩn đoán hình ảnh',
          icon: SvgPicture.asset(
            Assets.svg.diagnostic,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Dịch vụ y tế',
          icon: SvgPicture.asset(
            Assets.svg.serviceHealth,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'Bệnh án',
          icon: SvgPicture.asset(
            Assets.svg.patient,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
    ];
  }
}
