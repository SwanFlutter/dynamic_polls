import 'package:dynamic_polls/src/tools/date_style.dart';
import 'package:dynamic_polls/src/tools/option_style.dart';
import 'package:dynamic_polls/src/tools/show_time_style.dart';
import 'package:dynamic_polls/src/tools/title_style.dart';
import 'package:dynamic_polls/src/tools/votes_text_style.dart';

/// The `Styles` class in Dart contains properties for different text styles used in a user interface
/// design.
/// A comprehensive style configuration class to manage and customize
/// various visual components of a UI widget or screen.
class Styles {
  /// Defines the style for the title of the component.
  /// Use this to customize the appearance of the main heading or title text.
  final TitleStyle? titleStyle;

  /// Defines the style for displaying dates.
  /// Use this to configure the appearance of date-related components.
  final DateStyle? dateStyle;

  /// Defines the style for text showing votes.
  /// Customize how vote counts or percentages are displayed in the UI.
  final VotesTextStyle? votesTextStyle;

  /// Defines the style for options in a list or selection interface.
  /// Use this for configuring the appearance of selectable options.
  final OptionStyle? optionStyle;

  /// Defines the style for showing time-related information.
  /// Configure alignment, padding, text, and decorations for time display widgets.
  final ShowTimeStyle? showTimeStyle;

  /// Creates a style configuration object for various UI components.
  ///
  /// - [titleStyle]: Customizes the title's appearance.
  /// - [dateStyle]: Customizes the date display style.
  /// - [votesTextStyle]: Configures the appearance of vote-related text.
  /// - [optionStyle]: Customizes the appearance of selectable options.
  /// - [showTimeStyle]: Configures the style for time-related components.
  Styles({
    this.titleStyle,
    this.dateStyle,
    this.votesTextStyle,
    this.optionStyle,
    this.showTimeStyle,
  });
}
