import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.height,
    this.width,
    this.titleSize,
    this.radius,
    this.fontWeight = FontWeight.bold,
  });

  final String title;
  final double? titleSize;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color? color;
  final double? height, width;
  final double? radius;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.wp(2)),
      height: height ?? context.wp(4),
      width: width ?? context.wp(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xffCF4375),
          padding: EdgeInsets.symmetric(horizontal: context.wp(2)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 26),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.button(context),
        ),
      ),
    );
  }
}
