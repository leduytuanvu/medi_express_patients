import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class ItemHomeExaminationPackageModel {
  final String title;
  final String price;
  final String iconPath;

  ItemHomeExaminationPackageModel({
    required this.title,
    required this.price,
    required this.iconPath,
  });

  @override
  String toString() =>
      'ItemHomeExaminationPackageModel{title: $title, price: $price, path: $iconPath}';

  static List<ItemHomeExaminationPackageModel> list(BuildContext context) {
    List<ItemHomeExaminationPackageModel> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(
        ItemHomeExaminationPackageModel(
          title: 'Sức khỏe tổng quát',
          price: '2,066,000đ',
          iconPath: Assets.png.package1x,
        ),
      );
    }
    return list;
  }
}
