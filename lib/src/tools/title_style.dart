import 'package:flutter/material.dart';

/// A style configuration class to customize the appearance of the title
/// in a user interface component.
class TitleStyle {
  /// The alignment of the title within its container.
  ///
  /// Default is [Alignment.centerLeft], which aligns the title to the start.
  final AlignmentGeometry? alignment;

  /// The [TextStyle] to apply to the title text.
  /// Use this to customize font size, weight, color, and other text attributes.
  TextStyle? style;

  /// The maximum number of lines for the title text.
  ///
  /// If the text exceeds this number, it will be truncated or ellipsized.
  final int? maxLines;

  /// The minimum number of lines for the title text.
  ///
  /// Useful for ensuring consistent vertical spacing, even with short text.
  final int? minLines;

  /// How the title text should be aligned horizontally.
  ///
  /// Examples include [TextAlign.start], [TextAlign.center], or [TextAlign.end].
  final TextAlign? textAlign;

  /// The reading direction of the title text.
  ///
  /// This can be [TextDirection.ltr] (left-to-right) or [TextDirection.rtl] (right-to-left).
  final TextDirection? textDirection;

  /// Creates a style configuration for a title.
  ///
  /// - [alignment]: Aligns the title within its container (default: [Alignment.centerLeft]).
  /// - [style]: Customizes the text style of the title.
  /// - [maxLines]: Sets the maximum number of lines for the title text.
  /// - [minLines]: Sets the minimum number of lines for the title text.
  /// - [textAlign]: Aligns the title text horizontally.
  /// - [textDirection]: Defines the text direction for the title.
  TitleStyle({
    this.alignment = Alignment.centerLeft,
    this.style,
    this.maxLines,
    this.minLines,
    this.textAlign,
    this.textDirection,
  });
}
