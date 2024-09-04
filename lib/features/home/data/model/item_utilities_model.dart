import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
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
          title: 'health_index',
          icon: SvgPicture.asset(
            Assets.svg.healthIndex,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'prescription',
          icon: SvgPicture.asset(
            Assets.svg.prescription,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'vaccination',
          icon: SvgPicture.asset(
            Assets.svg.vacine,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'examination_schedule',
          icon: SvgPicture.asset(
            Assets.svg.examSchedule,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'testing',
          icon: SvgPicture.asset(
            Assets.svg.test,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'diagnosis_of_images',
          icon: SvgPicture.asset(
            Assets.svg.diagnostic,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'medical_services',
          icon: SvgPicture.asset(
            Assets.svg.serviceHealth,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
      ItemUtilitiesModel(
          title: 'medical_record',
          icon: SvgPicture.asset(
            Assets.svg.patient,
            height: context.wp(7.8),
            width: context.wp(7.8),
          )),
    ];
  }
}
