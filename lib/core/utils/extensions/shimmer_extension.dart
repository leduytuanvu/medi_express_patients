// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// /// Extension class to apply shimmer effect to any widget.
// extension ShimmerExtension on Widget {
//   /// Apply shimmer effect to the widget.
//   ///
//   /// [height] is the height of the shimmer container. Default is 200.0.
//   /// [width] is the width of the shimmer container. Default is double.infinity.
//   /// [highlightColor] is the highlight color of the shimmer effect. Default is FxColor.gray300.
//   /// [baseColor] is the base color of the shimmer effect. Default is FxColor.gray400.
//   ///
//   /// Returns a [Container] widget with the shimmer effect applied to the original widget.
//   Widget shimmer({
//     bool enable = false,
//     double height = 200.0,
//     double width = double.infinity,
//     Color highlightColor = const Color(0XFFd1d5db),
//     Color baseColor = const Color(0XFF9ca3af),
//     Duration period = const Duration(seconds: 3),
//     Gradient? gradient,
//     Axis direction = Axis.horizontal,
//   }) {
//     return (!enable)
//         ? Shimmer.fromColors(
//             baseColor: baseColor,
//             highlightColor: highlightColor,
//             period: const Duration(seconds: 3),
//             direction: direction == Axis.horizontal
//                 ? ShimmerDirection.ltr
//                 : ShimmerDirection.ttb,
//             child: this,
//           )
//         : this;
//   }
// }
