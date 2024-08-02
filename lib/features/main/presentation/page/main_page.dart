import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/account/presentation/page/main_page.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/chat/presentation/page/chat_page.dart';
import 'package:medi_express_patients/features/doctor/presentation/controller/doctor_controller.dart';
import 'package:medi_express_patients/features/doctor/presentation/page/doctor_page.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/home/presentation/page/home_page.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/page/schedule_page.dart';

class MainPage extends BaseStatelessWidget {
  MainPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: mainController.pageController,
        onPageChanged: (index) {
          mainController.changePage(index);
        },
        children: [
          GetBuilder<HomeController>(
            init: HomeController(errorHandlingService: ErrorHandlingService()),
            builder: (controller) => HomePage(),
          ),
          GetBuilder<DoctorController>(
            init:
                DoctorController(errorHandlingService: ErrorHandlingService()),
            builder: (controller) => const DoctorPage(),
          ),
          GetBuilder<ScheduleController>(
            init: ScheduleController(
                errorHandlingService: ErrorHandlingService()),
            builder: (controller) => const SchedulePage(),
          ),
          GetBuilder<ChatController>(
            init: ChatController(errorHandlingService: ErrorHandlingService()),
            builder: (controller) => const ChatPage(),
          ),
          GetBuilder<AccountController>(
            init:
                AccountController(errorHandlingService: ErrorHandlingService()),
            builder: (controller) => const AccountPage(),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: mainController.mainState.currentIndex.value,
          onTap: (index) {
            mainController.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.home,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 0
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.doctor,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 1
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Bác sĩ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.calender,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 2
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Lịch khám',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.chat,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 3
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Tin nhắn',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.account,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 4
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Tài khoản',
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor:
              const Color(0xfffcf4375), // Color for selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          selectedLabelStyle: const TextStyle(
            fontSize: 14.0, // Text size for selected item
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14.0, // Text size for unselected item
          ),
          type: BottomNavigationBarType
              .fixed, // Use fixed to avoid animation on tap
        );
      }),
    );
  }
}
