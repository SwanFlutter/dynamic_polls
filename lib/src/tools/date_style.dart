import 'package:flutter/material.dart';

class DateStyle {
  /// The alignment of the date text.
  MainAxisAlignment? mainAxisAlignment;

  /// The text to be displayed at the start of the date.
  String? textStart;

  /// The text to be displayed at the end of the date.
  String? textEnd;

  /// The style of the date text.
  TextStyle? textStyle;

  /// Creates a new `DateStyle` object with the specified properties.
  DateStyle({
    this.mainAxisAlignment,
    this.textStart,
    this.textEnd,
    this.textStyle,
  });
}
