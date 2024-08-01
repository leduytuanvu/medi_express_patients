import 'package:flutter/material.dart';

extension AlignExtension on Widget {
  Align align([Alignment alignment = Alignment.center]) => _align(alignment);

  Align get bottomRight => _align(Alignment.bottomRight);

  Align get bottomLeft => _align(Alignment.bottomLeft);

  Align get bottomCenter => _align(Alignment.bottomCenter);

  Align get topRight => _align(Alignment.topRight);

  Align get topLeft => _align(Alignment.topLeft);

  Align get topCenter => _align(Alignment.topCenter);

  Align get centerRight => _align(Alignment.centerRight);

  Align get centerLeft => _align(Alignment.centerLeft);

  Align _align(Alignment alignment) => Align(alignment: alignment, child: this);
}
