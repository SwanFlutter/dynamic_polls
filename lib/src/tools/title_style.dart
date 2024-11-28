import 'package:flutter/material.dart';

class TitleStyle {
  final AlignmentGeometry? alignment;
  TextStyle? style;
  int? maxLines;
  int? minLines;
  TextAlign? textAlign;
  TextDirection? textDirection;

  TitleStyle({
    this.alignment = Alignment.centerLeft,
    this.style,
    this.maxLines,
    this.minLines,
    this.textAlign,
    this.textDirection,
  });
}
