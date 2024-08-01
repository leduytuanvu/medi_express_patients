import 'package:flutter/material.dart';

extension GestureExtension on Widget {
  GestureDetector onTap(VoidCallback callback) =>
      GestureDetector(onTap: callback, child: this);

  GestureDetector onDoubleTap(VoidCallback callback) =>
      GestureDetector(onDoubleTap: callback, child: this);

  GestureDetector onLongPress(VoidCallback callback) =>
      GestureDetector(onLongPress: callback, child: this);

  InkWell onInkDoubleTap(
    VoidCallback callback, {
    Color? splashColor,
    Color? focusColor,
    Color? hoverColor,
    bool? enableFeedback,
    double? radius,
    BorderRadius? borderRadius,
    MouseCursor? mouseCursor,
  }) {
    return InkWell(
      onDoubleTap: callback,
      splashColor: splashColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      enableFeedback: enableFeedback,
      radius: radius,
      borderRadius: borderRadius,
      mouseCursor: mouseCursor,
      child: this,
    );
  }

  InkWell onInkTap(
    VoidCallback callback, {
    Color? splashColor,
    Color? focusColor,
    Color? hoverColor,
    bool? enableFeedback,
    double? radius,
    BorderRadius? borderRadius,
    MouseCursor? mouseCursor,
  }) {
    return InkWell(
      onTap: callback,
      splashColor: splashColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      enableFeedback: enableFeedback,
      radius: radius,
      borderRadius: borderRadius,
      mouseCursor: mouseCursor,
      child: this,
    );
  }
}
