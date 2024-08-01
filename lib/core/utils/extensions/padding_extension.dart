import 'package:flutter/material.dart';

/// Padding extension on widget to directly get padding
extension PaddingExtension on Widget {
  /// Get padding only on given values non-zero.
  Padding pOnly({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) =>
      _pad(top: top, bottom: bottom, left: left, right: right);

  /// Get padding except left on given values non-zero.
  Padding pnl(double value) => _pad(top: value, bottom: value, right: value);

  /// Get padding except right on given values non-zero.
  Padding pnr(double value) => _pad(top: value, bottom: value, left: value);

  /// Get padding except top on given values non-zero.
  Padding pnt(double value) => _pad(left: value, bottom: value, right: value);

  /// Get padding except bottom on given values non-zero.
  Padding pnb(double value) => _pad(top: value, left: value, right: value);

  /// Get all side padding
  Padding p(double all) => _pad(all: all);

  /// Get horizontally padding
  Padding px(double h) => _pad(h: h);

  /// Get vertically padding
  Padding py(double v) => _pad(v: v);

  /// Get [symmetric] vertically and horizontally padding
  Padding pxy({required double h, required double v}) => _pad(h: h, v: v);

  /// Get right side padding
  Padding pr(double right) => _pad(right: right);

  /// Get left side padding
  Padding pl(double left) => _pad(left: left);

  /// Get top side padding
  Padding pt(double top) => _pad(top: top);

  /// Get bottom side padding
  Padding pb(double bottom) => _pad(bottom: bottom);

  /// Gives 0dp padding from all sides
  Padding get p0 => p(0);

  /// Gives 1dp padding from all sides
  Padding get p1 => p(1);

  /// Gives 2dp padding from all sides
  Padding get p2 => p(2);

  /// Gives 3dp padding from all sides
  Padding get p3 => p(3);

  /// Gives 4dp padding from all sides
  Padding get p4 => p(4);

  /// Gives 5dp padding from all sides
  Padding get p5 => p(5);

  /// Gives 6dp padding from all sides
  Padding get p6 => p(6);

  /// Gives 7dp padding from all sides
  Padding get p7 => p(7);

  /// Gives 8dp padding from all sides
  Padding get p8 => p(8);

  /// Gives 9dp padding from all sides
  Padding get p9 => p(9);

  /// Gives 10dp padding from all sides
  Padding get p10 => p(10);

  /// Gives 11dp padding from all sides
  Padding get p11 => p(11);

  ///Gives 12dp padding from all sides
  Padding get p12 => p(12);

  /// Gives 16dp padding from all sides
  Padding get p16 => p(16);

  /// Gives 20dp padding from all sides
  Padding get p20 => p(20);

  /// Gives 24dp padding from all sides
  Padding get p24 => p(24);

  /// Gives 32dp padding from all sides
  Padding get p32 => p(32);

  /// Gives 36dp padding from all sides
  Padding get p36 => p(36);

  /// Gives 48dp padding from all sides
  Padding get p48 => p(48);

  /// Gives 64dp padding from all sides
  Padding get p64 => p(64);

  /// Gives 0dp padding from right side
  Padding get pr0 => pr(0);

  /// Gives 4dp padding from right side
  Padding get pr4 => pr(4);

  /// Gives 8dp padding from right side
  Padding get pr8 => pr(8);

  /// Gives 12dp padding from right side
  Padding get pr12 => pr(12);

  /// Gives 16dp padding from right side
  Padding get pr16 => pr(16);

  /// Gives 20dp padding from right side
  Padding get pr20 => pr(20);

  /// Gives 24dp padding from right side
  Padding get pr24 => pr(24);

  /// Gives 32dp padding from right side
  Padding get pr32 => pr(32);

  /// Gives 48dp padding from right side
  Padding get pr48 => pr(48);

  /// Gives 64dp padding from right side
  Padding get pr64 => pr(64);

  /// Gives 0dp padding from left side
  Padding get pl0 => pl(0);

  /// Gives 4dp padding from left side
  Padding get pl4 => pl(4);

  /// Gives 8dp padding from left side
  Padding get pl8 => pl(8);

  /// Gives 12dp padding from left side
  Padding get pl12 => pl(12);

  /// Gives 16dp padding from left side
  Padding get pl16 => pl(16);

  /// Gives 20dp padding from left side
  Padding get pl20 => pl(20);

  /// Gives 24dp padding from left side
  Padding get pl24 => pl(24);

  /// Gives 32dp padding from left side
  Padding get pl32 => pl(32);

  /// Gives 48dp padding from left side
  Padding get pl48 => pl(48);

  /// Gives 64dp padding from left side
  Padding get pl64 => pl(64);

  /// Gives 0dp padding from top side
  Padding get pt0 => pt(0);

  /// Gives 4dp padding from top side
  Padding get pt4 => pt(4);

  /// Gives 8dp padding from top side
  Padding get pt8 => pt(8);

  /// Gives 12dp padding from top side
  Padding get pt12 => pt(12);

  /// Gives 16dp padding from top side
  Padding get pt16 => pt(16);

  /// Gives 20dp padding from top side
  Padding get pt20 => pt(20);

  /// Gives 24dp padding from top side
  Padding get pt24 => pt(24);

  /// Gives 32dp padding from top side
  Padding get pt32 => pt(32);

  /// Gives 48dp padding from top side
  Padding get pt48 => pt(48);

  /// Gives 64dp padding from top side
  Padding get pt64 => pt(64);

  /// Gives 0dp padding from bottom side
  Padding get pb0 => pb(0);

  /// Gives 4dp padding from bottom side
  Padding get pb4 => pb(4);

  /// Gives 8dp padding from bottom side
  Padding get pb8 => pb(8);

  /// Gives 8dp padding from bottom side
  Padding get pb10 => pb(10);

  /// Gives 12dp padding from bottom side
  Padding get pb12 => pb(12);

  /// Gives 16dp padding from bottom side
  Padding get pb16 => pb(16);

  /// Gives 20dp padding from bottom side
  Padding get pb20 => pb(20);

  /// Gives 24dp padding from bottom side
  Padding get pb24 => pb(24);

  /// Gives 32dp padding from bottom side
  Padding get pb32 => pb(32);

  /// Gives 48dp padding from bottom side
  Padding get pb48 => pb(48);

  /// Gives 64dp padding from bottom side
  Padding get pb64 => pb(64);

  /// Gives 4dp padding horizontally
  Padding get px4 => px(4);

  /// Gives 8dp padding horizontally
  Padding get px8 => px(8);

  /// Gives 12dp padding horizontally
  Padding get px12 => px(12);

  /// Gives 16dp padding horizontally
  Padding get px16 => px(16);

  /// Gives 20dp padding horizontally
  Padding get px20 => px(20);

  /// Gives 24dp padding horizontally
  Padding get px24 => px(24);

  /// Gives 32dp padding horizontally
  Padding get px32 => px(32);

  /// Gives 48dp padding horizontally
  Padding get px48 => px(48);

  /// Gives 64dp padding horizontally
  Padding get px64 => px(64);

  /// Gives 4dp padding vertically
  Padding get py4 => py(4);

  /// Gives 8dp padding vertically
  Padding get py8 => py(8);

  /// Gives 12dp padding vertically
  Padding get py12 => py(12);

  /// Gives 16dp padding vertically
  Padding get py16 => py(16);

  /// Gives 20dp padding vertically
  Padding get py20 => py(20);

  /// Gives 24dp padding vertically
  Padding get py24 => py(24);

  /// Gives 32dp padding vertically
  Padding get py32 => py(32);

  /// Gives 48dp padding vertically
  Padding get py48 => py(48);

  /// Gives 64dp padding vertically
  Padding get py64 => py(64);

  Padding _pad({
    double? all,
    double? h,
    double? v,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left ?? h ?? all ?? 0.0,
        top: top ?? v ?? all ?? 0.0,
        right: right ?? h ?? all ?? 0.0,
        bottom: bottom ?? v ?? all ?? 0.0,
      ),
      child: this,
    );
  }
}
