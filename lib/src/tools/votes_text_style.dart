import 'package:flutter/material.dart';

/// A style configuration class to customize the appearance of the votes text
/// in a user interface component.
class VotesTextStyle {
  /// The amount of padding to apply above the votes text.
  ///
  /// Use this to control the spacing between the votes text and the component above it.
  /// Default is `null`, meaning no additional top padding is applied.
  final double? paddingTop;

  /// The amount of padding to apply below the votes text.
  ///
  /// Use this to control the spacing between the votes text and the component below it.
  /// Default is `null`, meaning no additional bottom padding is applied.
  final double? paddingBottom;

  /// The [TextStyle] to apply to the votes text.
  ///
  /// Use this to customize the font size, weight, color, and other text attributes.
  final TextStyle? style;

  /// The alignment of the votes text within its container.
  ///
  /// Use this to position the votes text relative to its parent container.
  /// Default is `null`, meaning no specific alignment is applied.
  final AlignmentGeometry? alignment;

  /// Creates a style configuration for votes text.
  ///
  /// - [paddingTop]: Controls the space above the votes text.
  /// - [paddingBottom]: Controls the space below the votes text.
  /// - [style]: Customizes the text style of the votes text.
  /// - [alignment]: Defines the alignment of the votes text within its container.
  VotesTextStyle({
    this.paddingTop,
    this.paddingBottom,
    this.style,
    this.alignment,
  });
}
