import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
      3,
      (index) => Container(
        decoration: const BoxDecoration(),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.svg.introFirst,
              width: context.wp(70),
              height: context.wp(70),
            ),
            SizedBox(height: context.wp(22)),
            Text('Quản lý và chia sẻ Hồ sơ sức khỏe',
                textAlign: TextAlign.center,
                style: AppTextStyle.mediumTitle(context)),
            SizedBox(height: context.wp(4)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.wp(14)),
              child: Text(
                textAlign: TextAlign.center,
                'Lịch sử khám chữa bệnh, tiêm chủng… được tự động cập nhật từ các cơ sở Khám chữa bệnh.',
                style: AppTextStyle.bodyIntro(context),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      itemBuilder: (_, index) {
                        return pages[index % pages.length];
                      },
                    ),
                  ),
                ),
                IndicatorWidget(
                  controller: _pageController,
                  itemCount: pages.length,
                ),
                SizedBox(height: context.hp(3))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                left: context.wp(3),
                right: context.wp(6),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.offNamedScreen(AppRoutes.login);
                    },
                    child: Container(
                      height: context.hp(6),
                      width: context.wp(20),
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'Bỏ qua',
                          style: AppTextStyle.mediumTextButton(context),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButtonWidget(
                    height: context.hp(6),
                    width: context.wp(44),
                    title: "Tiếp theo",
                    onPressed: () async {
                      final currentPage = _pageController.page?.toInt() ?? 0;
                      if (currentPage == pages.length - 1) {
                        context.offNamedScreen(AppRoutes.login);
                      } else {
                        await Future.delayed(const Duration(microseconds: 1));
                        _pageController.animateToPage(
                          currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    color: const Color(0xffCF4375),
                    titleSize: context.sp(14),
                    radius: context.rp(10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  final PageController controller;
  final int itemCount;

  const IndicatorWidget({
    super.key,
    required this.controller,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            double selectedness = Curves.easeOut.transform(
              max(
                0.0,
                1.0 -
                    ((controller.page ?? controller.initialPage) - index).abs(),
              ),
            );
            double width = 10.0 + (38.0 - 12.0) * selectedness;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              height: 5.0,
              width: width,
              decoration: BoxDecoration(
                color: selectedness > 0.5
                    ? const Color(0xFF005495)
                    : const Color(0xFFE3E8EF),
                borderRadius: BorderRadius.circular(6.0),
              ),
            );
          }),
        );
      },
    );
  }
}
