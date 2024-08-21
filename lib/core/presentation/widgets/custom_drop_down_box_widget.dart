import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';

class CustomDropDownBoxWidget<T> extends StatelessWidget {
  final String labelText;
  final double borderRadius;
  final List<T> items;
  final String Function(T) displayItem;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final RxString? errorText;

  const CustomDropDownBoxWidget({
    Key? key,
    required this.labelText,
    this.borderRadius = 8.0,
    required this.items,
    required this.displayItem,
    this.selectedItem,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(labelText, style: AppTextStyle.mediumHint(context)),
                    SizedBox(
                      height: context.hp(4),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<T>(
                            value: selectedItem,
                            items: items.map<DropdownMenuItem<T>>((T value) {
                              return DropdownMenuItem<T>(
                                value: value,
                                child: Text(
                                  displayItem(value),
                                  style: AppTextStyle.mediumBody(context),
                                ),
                              );
                            }).toList(),
                            onChanged: (T? newValue) {
                              if (onChanged != null) {
                                onChanged!(newValue);
                              }
                            },
                            isExpanded: true,
                            icon: const SizedBox.shrink(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: context.sp(14),
                            ),
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (errorText != null && errorText!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: context.hp(0.6)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(
                      () => Text(
                        errorText!.value,
                        style: AppTextStyle.mediumError(context),
                      ),
                    ),
                  ),
                ),
              context.hp(1.4).sbh,
            ],
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey.shade600,
                size: context.wp(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
