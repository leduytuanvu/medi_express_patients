import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/main/presentation/state/main_state.dart';

class MainController extends BaseController {
  MainController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final MainState mainState = MainState();
  final PageController pageController = PageController();

  void changePage(int index) {
    mainState.currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Log.info("init main controller");
  }
}
