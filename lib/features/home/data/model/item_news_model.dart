import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class ItemNewsModel {
  final String title;
  final String iconPath;

  ItemNewsModel({
    required this.title,
    required this.iconPath,
  });

  @override
  String toString() => 'ItemNewsModel{title: $title, path: $iconPath}';

  static List<ItemNewsModel> list(BuildContext context) {
    List<ItemNewsModel> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(
        ItemNewsModel(
          title:
              'Sức khỏe tổng quát Sức khỏe tổng quát Sức khỏe tổng quát Sức khỏe tổng quát Sức khỏe tổng quát',
          iconPath: Assets.png.package1x,
        ),
      );
    }
    return list;
  }
}
