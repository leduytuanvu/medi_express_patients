import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';

class ItemAccountModel {
  final String title;
  final String iconPath;
  final VoidCallback onPress;

  ItemAccountModel({
    required this.title,
    required this.iconPath,
    required this.onPress,
  });

  @override
  String toString() =>
      'ItemAccountModel{title: $title, description1: $iconPath';

  static List<ItemAccountModel> list(BuildContext context) {
    List<ItemAccountModel> list = [];
    list.add(
      ItemAccountModel(
        title: 'Chỉ số sức khỏe',
        iconPath: Assets.svg.healthIndex,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Thông tin cá nhân',
        iconPath: Assets.svg.personalInformation,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Đổi mật khẩu',
        iconPath: Assets.svg.changePassword,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Cài đặt',
        iconPath: Assets.svg.changePassword,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Hỗ trợ',
        iconPath: Assets.svg.helper,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Ngôn ngữ',
        iconPath: Assets.svg.language,
        onPress: () {
        },
      ),
    );
    list.add(
      ItemAccountModel(
        title: 'Đăng xuất',
        iconPath: Assets.svg.logout,
        onPress: () {
        },
      ),
    );
    return list;
  }
}