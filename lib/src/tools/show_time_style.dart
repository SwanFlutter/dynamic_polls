import 'package:flutter/material.dart';

/// Defines the style configuration for displaying a time-related widget.
class ShowTimeStyle {
  /// The alignment of the time display widget within its parent container.
  /// Default is [Alignment.center].
  final AlignmentGeometry? alignment;

  /// The padding inside the widget around the time display.
  /// Default is [EdgeInsets.all(16.0)] for uniform padding.
  final EdgeInsetsGeometry? padding;

  /// The height of the time display widget.
  /// If null, it adjusts to fit its content.
  final double? height;

  /// The width of the time display widget.
  /// If null, it adjusts to fit its content.
  final double? width;

  /// The decoration applied to the background of the time display widget.
  /// Use this for customizing borders, colors, shadows, and more.
  final Decoration? decoration;

  /// The text displayed alongside the time.
  /// Default value is `"Start by :"`.
  final String text;

  /// The text style for the displayed text.
  /// Apply this to customize font size, weight, color, etc.
  final TextStyle? style;

  /// Creates a style configuration for a time display widget.
  ///
  /// - [alignment]: Controls the alignment of the content.
  /// - [padding]: Adds spacing between the content and the edges of the widget.
  /// - [height]: Sets the height of the widget.
  /// - [width]: Sets the width of the widget.
  /// - [decoration]: Adds visual styling to the widget's background.
  /// - [text]: Specifies the default text displayed with the time.
  /// - [style]: Customizes the text's appearance.
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
