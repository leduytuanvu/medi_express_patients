import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';

class CustomDropDownBoxWidget<T> extends StatefulWidget {
  final String labelText;
  final double borderRadius;
  final List<T> items;
  final String Function(T) displayItem;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final RxString? errorText;

  const CustomDropDownBoxWidget({
    super.key,
    required this.labelText,
    this.borderRadius = 8.0,
    required this.items,
    required this.displayItem,
    this.selectedItem,
    this.onChanged,
    this.errorText,
  });

  @override
  State<CustomDropDownBoxWidget> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropDownBoxWidget<T>> {
  T? _selectedItem;
  final GlobalKey _dropdownKey = GlobalKey(); // Define the GlobalKey

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  void _openDropdown() {
    GestureDetector? detector;
    void searchForGestureDetector(Element element) {
      if (element.widget is GestureDetector) {
        detector = element.widget as GestureDetector?;
      }
      element.visitChildElements(searchForGestureDetector);
    }

    if (_dropdownKey.currentContext != null) {
      final element = _dropdownKey.currentContext! as Element;
      searchForGestureDetector(element);
      if (detector != null) {
        detector!.onTap!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDropdown,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(widget.labelText,
                        style: AppTextStyle.mediumHint(context)),
                    SizedBox(
                      height: context.hp(4),
                      child: Obx(() => DropdownButtonHideUnderline(
                            child: DropdownButton<T>(
                              key: _dropdownKey, // Use the GlobalKey here
                              value: _selectedItem,
                              items: [
                                DropdownMenuItem<T>(
                                  value: null,
                                  child: Text(
                                    '',
                                    style: AppTextStyle.mediumBody(context),
                                  ),
                                ),
                                ...widget.items
                                    .map<DropdownMenuItem<T>>((T value) {
                                  return DropdownMenuItem<T>(
                                    value: value,
                                    child: Text(
                                      widget.displayItem(value),
                                      style: AppTextStyle.mediumBody(context),
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (T? newValue) {
                                setState(() {
                                  if (widget.onChanged != null) {
                                    _selectedItem = newValue;
                                    widget.onChanged!(newValue);
                                  }
                                });
                              },
                              isExpanded: true,
                              icon: const SizedBox.shrink(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: context.sp(14),
                              ),
                              dropdownColor: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              if (widget.errorText != null && widget.errorText!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: context.hp(0.6)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.errorText!.value,
                      style: AppTextStyle.mediumError(context),
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

// class CustomDropDownBoxWidget<T> extends StatefulWidget {
//   final String labelText;
//   final double borderRadius;
//   final List<T> items;
//   final String Function(T) displayItem;
//   final T? selectedItem;
//   final Function(T?)? onChanged;
//   final RxString? errorText;
//
//   const CustomDropDownBoxWidget({
//     super.key,
//     required this.labelText,
//     this.borderRadius = 8.0,
//     required this.items,
//     required this.displayItem,
//     this.selectedItem,
//     this.onChanged,
//     this.errorText,
//   });
//
//   @override
//   State<CustomDropDownBoxWidget> createState() =>
//       _CustomDropdownWidgetState<T>();
// }
//
// class _CustomDropdownWidgetState<T> extends State<CustomDropDownBoxWidget<T>> {
//   T? _selectedItem;
//   final GlobalKey _dropdownKey = GlobalKey();
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedItem = widget.selectedItem;
//   }
//
//   void _openDropdown() {
//     GestureDetector? detector;
//     void searchForGestureDetector(Element element) {
//       if (element.widget is GestureDetector) {
//         detector = element.widget as GestureDetector?;
//       }
//       element.visitChildElements(searchForGestureDetector);
//     }
//
//     if (_dropdownKey.currentContext != null) {
//       final element = _dropdownKey.currentContext! as Element;
//       searchForGestureDetector(element);
//       if (detector != null) {
//         detector!.onTap!();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _openDropdown,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(left: 12, right: 20),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(widget.borderRadius),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 6),
//                     Text(widget.labelText,
//                         style: AppTextStyle.mediumHint(context)),
//                     SizedBox(
//                       height: context.hp(4),
//                       child: Obx(() => DropdownButtonHideUnderline(
//                             child: DropdownButton<T>(
//                               key: _dropdownKey,
//                               value: _selectedItem,
//                               items: [
//                                 // DropdownMenuItem<T>(
//                                 //   value: null,
//                                 //   child: Text(
//                                 //     '',
//                                 //     style: AppTextStyle.mediumBody(context),
//                                 //   ),
//                                 // ),
//                                 ...widget.items
//                                     .map<DropdownMenuItem<T>>((T value) {
//                                   return DropdownMenuItem<T>(
//                                     value: value,
//                                     child: Text(
//                                       widget.displayItem(value),
//                                       style: AppTextStyle.mediumBody(context),
//                                     ),
//                                   );
//                                 }),
//                               ],
//                               onChanged: (T? newValue) {
//                                 setState(() {
//                                   _selectedItem = newValue;
//                                   if (widget.onChanged != null) {
//                                     widget.onChanged!(newValue);
//                                   }
//                                 });
//                               },
//                               isExpanded: true,
//                               icon: const SizedBox.shrink(),
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: context.sp(14),
//                               ),
//                               dropdownColor: Colors.white,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               if (widget.errorText != null && widget.errorText!.isNotEmpty)
//                 Padding(
//                   padding: EdgeInsets.only(top: context.hp(0.6)),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       widget.errorText!.value,
//                       style: AppTextStyle.mediumError(context),
//                     ),
//                   ),
//                 ),
//               context.hp(1.4).sbh,
//             ],
//           ),
//           Positioned(
//             top: 0,
//             bottom: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 8),
//               child: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.grey.shade600,
//                 size: context.wp(6),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
