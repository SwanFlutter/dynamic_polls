// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// Defines the style configuration for a poll option widget.
class OptionStyle {
  /// The height of the poll option widget.
  final double? height;

  /// The width of the poll option widget.
  final double? width;

  /// The text style for the option text, represented as a string identifier.
  /// Use this to define a custom text style for the option label.
  final String? textOptionStyle;

  /// The text style for the percentage display, represented as a string identifier.
  /// This style applies to the percentage text shown beside each option.
  final String? votedPercentageTextStyle;

  /// The border radius for the poll option widget.
  /// Defines the rounded corners of the option container.
  final BorderRadius? borderRadius;

  /// The background fill color of the poll option.
  /// Use this to set the default background color of the option widget.
  final Color? fillColor;

  /// The default border color of the poll option widget.
  /// This color is used when the option is not selected.
  final Color? borderColor;

  /// The duration of the animation when displaying or updating the poll progress.
  /// This controls how smoothly the progress bar animates.
  final Duration? animationDuration;

  /// The widget to display as a checkmark when the option is selected.
  /// This can be a custom icon or any widget to indicate selection.
  final Widget votedCheckmark;

  /// The height between poll option widgets in a list.
  /// Use this to adjust the vertical spacing between options.
  final double? heightBetweenOptions;

  /// The opacity value for the leading progress bar color when an option is voted.
  /// A value between 0.0 and 1.0 that determines the transparency.
  final double? opacityLeadingVotedProgessColor;

  /// The border color for the selected poll option.
  /// Highlight the selected option with a custom border color.
  final Color? selectedBorderColor;

  /// The border color for the unselected poll option.
  /// This color is applied to options that are not selected.
  final Color? unselectedBorderColor;

  /// The border width for the poll option widget.
  /// This defines the thickness of the border around the option.
  final double? borderWidth;

  /// The border width for the progress bar in the poll option widget.
  /// Use this to set the thickness of the progress bar's border.
  final double? progressBorderWidth;

  /// The color of the text when an option is selected.
  /// Apply this color to emphasize the selected option's text.
  final Color? textSelectColor;

  /// The background color for the poll option when it has received votes.
  /// This color fills the progress bar for voted options.
  final Color? votedBackgroundColor;

  /// The leading color for the progress bar when an option is voted.
  /// This color is applied to the progress bar indicating votes received.
  final Color? leadingVotedProgessColor;

  /// The border color for the progress bar in the voted state.
  /// Use this to add a border around the progress bar.
  final Color? voteBorderProgressColor;

  /// The text color for the percentage display of other options.
  /// This color applies to the percentage value shown for non-selected options.
  final Color? otherTextPercentColor;

  /// The padding for the content inside the poll option widget.
  final EdgeInsetsGeometry? contentPadding;

  /// Creates a style configuration for poll options with customizable parameters.
  ///
  /// All parameters are optional, and the default styles will apply if not provided.
  OptionStyle({
    this.height,
    this.width,
    this.textOptionStyle,
    this.votedPercentageTextStyle,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.leadingVotedProgessColor = Colors.blue,
    this.animationDuration,
    this.votedCheckmark = const Icon(Icons.verified, color: Colors.blue),
    this.heightBetweenOptions,
    this.opacityLeadingVotedProgessColor = 0.2,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.borderWidth,
    this.progressBorderWidth,
    this.textSelectColor,
    this.votedBackgroundColor,
    this.voteBorderProgressColor,
    this.otherTextPercentColor,
    this.contentPadding,
  });
}
