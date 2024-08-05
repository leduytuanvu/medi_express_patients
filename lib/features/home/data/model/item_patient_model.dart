import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class ItemPatientModel {
  final String title;
  final String datetime;
  final String imagePath;

  ItemPatientModel({
    required this.title,
    required this.datetime,
    required this.imagePath,
  });

  @override
  String toString() =>
      'ItemPatientModel{title: $title, datetime: $datetime, path: $imagePath}';

  static List<ItemPatientModel> list(BuildContext context) {
    List<ItemPatientModel> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(
        ItemPatientModel(
          title: 'Bệnh án nội khoa',
          datetime: '12/05/2024',
          imagePath: Assets.png.patientImage1x,
        ),
      );
    }
    return list;
  }
}
