import 'package:flutter/material.dart';

class ShowTimeStyle {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Decoration? decoration;
  final String text;
  final TextStyle? style;

  ShowTimeStyle({
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(16.0),
    this.decoration,
    this.text = "Start by :",
    this.style,
    this.height,
    this.width,
  });
}
