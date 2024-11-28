import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A widget for displaying a poll in a view-only mode.
///
/// This widget presents the poll results without allowing user interaction.
/// It provides various customization options for styling and displaying
/// the poll data.
class ViewOnlyPollWidget extends StatelessWidget {
  /// Whether reselection of options is allowed (not applicable in view-only mode).
  final bool allowReselection;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The votes for each option, represented as a map of option index to vote count.
  final Map<int, int> votes;

  /// The total number of votes cast in the poll.
  final int totalVotes;

  /// Whether to display the percentage of votes for each option.
  final bool showPercentages;

  /// The start date of the poll.
  final DateTime startDate;

  /// The end date of the poll.
  final DateTime endDate;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The height between each option.
  final double? heightBetweenOptions;

  /// The text displayed next to the vote count.
  final String? votesText;

  /// The text style for the votes text.
  final TextStyle? votesTextStyle;

  /// An optional widget to display metadata about the poll.
  final Widget? metaWidget;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final String? userToVote;

  /// The height of each poll option.
  final double? pollOptionsHeight;

  /// The width of each poll option.
  final double? pollOptionsWidth;

  /// The border for each poll option.
  final BoxBorder? pollOptionsBorder;

  /// The border radius for each poll option.
  final BorderRadius? pollOptionsBorderRadius;

  /// The fill color for each poll option.
  final Color? pollOptionsFillColor;

  /// The splash color for each poll option.
  final Color? pollOptionsSplashColor;

  /// The border for voted poll options.
  final BoxBorder? votedPollOptionsBorder;

  /// The radius for voted poll options.
  final Radius? votedPollOptionsRadius;

  /// The background color for voted poll options.
  final Color? votedBackgroundColor;

  /// The progress color for voted poll options.
  final Color? votedProgressColor;

  /// The leading progress color for voted poll options.
  final Color? leadingVotedProgessColor;

  /// The color for vote in progress.
  final Color? voteInProgressColor;

  /// The checkmark widget for voted poll options.
  final Widget? votedCheckmark;

  /// The text style for the percentage of voted poll options.
  final TextStyle? votedPercentageTextStyle;

  /// The animation duration for voted poll options.
  final int votedAnimationDuration;

  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// Creates a new `ViewOnlyPollWidget`.
  const ViewOnlyPollWidget({
    super.key,
    required this.title,
    required this.options,
    required this.votes,
    required this.totalVotes,
    this.showPercentages = true,
    required this.startDate,
    required this.endDate,
    this.allowReselection = false,
    this.heightBetweenTitleAndOptions = 10,
    this.heightBetweenOptions = 12,
    this.votesText = 'Votes',
    this.votesTextStyle,
    this.metaWidget,
    this.createdBy,
    this.userToVote,
    this.pollOptionsHeight = 48,
    this.pollOptionsWidth,
    this.pollOptionsBorderRadius,
    this.pollOptionsFillColor = Colors.white,
    this.pollOptionsSplashColor = Colors.grey,
    this.pollOptionsBorder,
    this.votedPollOptionsBorder,
    this.votedPollOptionsRadius,
    this.votedBackgroundColor = const Color(0xffEEF0EB),
    this.votedProgressColor = const Color(0xff84D2F6),
    this.leadingVotedProgessColor = const Color(0xff0496FF),
    this.voteInProgressColor = const Color(0xffEEF0EB),
    this.votedCheckmark,
    this.votedPercentageTextStyle,
    this.votedAnimationDuration = 1000,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat =
        DateFormat('yyyy/MM/dd HH:mm'); // Format for displaying dates
    return Card(
      elevation: 4, // Elevation for shadow effect
      margin: const EdgeInsets.all(12), // Margin around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for the card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align children to the start
          children: [
            // Poll Title
            Text(
              title, // Display the poll title
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold), // Title style
            ),
            SizedBox(
                height:
                    heightBetweenTitleAndOptions), // Space between title and options

            // Poll Options
            ...options.asMap().entries.map((entry) {
              final index = entry.key; // Get the index of the option
              final option = entry.value; // Get the option text
              final optionVotes =
                  votes[index] ?? 0; // Get the votes for the option
              final percentage = totalVotes > 0
                  ? (optionVotes / totalVotes * 100)
                  : 0; // Calculate percentage

              return Padding(
                padding: EdgeInsets.only(
                    bottom:
                        heightBetweenOptions ?? 12), // Space between options
                child: Container(
                  height: pollOptionsHeight, // Height of the option container
                  decoration: BoxDecoration(
                    color:
                        pollOptionsFillColor, // Background color of the option
                    borderRadius: pollOptionsBorderRadius ??
                        BorderRadius.circular(8), // Border radius
                    border: pollOptionsBorder ??
                        Border.all(
                            color: Colors.grey, width: 1.0), // Border style
                  ),
                  child: Stack(
                    children: [
                      // Progress Background
                      FractionallySizedBox(
                        widthFactor:
                            percentage / 100, // Width based on percentage
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: pollOptionsBorderRadius ??
                                BorderRadius.circular(8), // Border radius
                            color: votedProgressColor?.withOpacity(0.3) ??
                                Colors.blue.withOpacity(0.3), // Progress color
                          ),
                        ),
                      ),
                      // Option Text and Percentage
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12), // Padding for option text
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content vertically
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Space between text and percentage
                              children: [
                                // Option Text
                                Text(
                                  option, // Display the option text
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.w500), // Option text style
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                  maxLines: 1, // Limit to one line
                                ),
                                // Percentage
                                if (showPercentages) // Show percentage if enabled
                                  Text(
                                    '${percentage.toStringAsFixed(1)}%', // Display percentage
                                    style: votedPercentageTextStyle ??
                                        const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .black87), // Percentage text style
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Divider(
                height: 24), // Divider between options and meta information

            // Meta Information
            if (metaWidget != null)
              metaWidget!, // Display meta widget if provided
            const SizedBox(height: 8), // Space after meta information

            // Total Votes and Dates
            Text(
              '$totalVotes $votesText', // Display total votes
              style: votesTextStyle ??
                  const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87), // Votes text style
            ),
            Text(
              'Start : ${dateFormat.format(startDate)}', // Display start date
              style: const TextStyle(
                  fontSize: 12, color: Colors.black54), // Start date style
            ),
            Text(
              'Ends : ${dateFormat.format(endDate)}', // Display end date
              style: const TextStyle(
                  fontSize: 12, color: Colors.black54), // End date style
            ),
          ],
        ),
      ),
    );
  }
}
