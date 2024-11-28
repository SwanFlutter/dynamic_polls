// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OptionStyle {
  final double? height;
  final double? width;
  final String? textOption;
  final String? textOptionStyle;
  final String? votedPercentageTextStyle;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Duration? animationDuration;
  final Widget votedCheckmark;
  final double? heightBetweenOptions;
  final double? opacityLeadingVotedProgessColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final double? borderWidth;
  final double? progressBorderWidth;
  final Color? textSelectColor;
  final Color? votedBackgroundColor;
  final Color? leadingVotedProgessColor;
  final Color? voteBorderProgressColor;
  final Color? otherTextPercentColor;

  OptionStyle({
    this.height,
    this.width,
    this.textOption,
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
    this.borderWidth = 2,
    this.progressBorderWidth = 1,
    this.textSelectColor,
    this.votedBackgroundColor,
    this.voteBorderProgressColor = Colors.blue,
    this.otherTextPercentColor = Colors.black,
  });
}
