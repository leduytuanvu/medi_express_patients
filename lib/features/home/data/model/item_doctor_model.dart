import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class ItemDoctorModel {
  final String name;
  final String description1;
  final String description2;
  final String description3;
  final int book1;
  final int book2;
  final String avatarPath;

  ItemDoctorModel({
    required this.name,
    required this.description1,
    required this.description2,
    required this.description3,
    required this.book1,
    required this.book2,
    required this.avatarPath,
  });

  @override
  String toString() =>
      'ItemDoctorModel{title: $name, description1: $description1, description2: $description2, description3: $description3, book1: $book1, book2: $book2, avatarPath: $avatarPath}';

  static List<ItemDoctorModel> list(BuildContext context) {
    List<ItemDoctorModel> list = [];
    for (int i = 0; i < 10; i++) {
      list.add(
        ItemDoctorModel(
          name: 'BS Tràn Minh Khuyên',
          description1: 'Bác sĩ chuyên khoa 2',
          description2: 'Sức khỏe tâm thần',
          description3: 'Bệnh viện Đại học Y Dược 1',
          book1: 123,
          book2: 234,
          avatarPath: Assets.png.avatarDoctor1x,
        ),
      );
    }
    return list;
  }
}
