import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: const Text('home page'),
        onTap: () {
          Log.info('click');
          final MainController homeController = Get.find<MainController>();
          homeController.setAuth(AuthEntity());
        },
      ),
    );
  }
}
