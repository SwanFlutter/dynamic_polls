// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:dynamic_polls/src/tools/utils/poll_data_utils.dart';
import 'package:dynamic_polls/src/widget/radio_bottom_poll_option_widget.dart';
import 'package:flutter/material.dart';

class RadioBottomPolls extends StatefulWidget {
  /// The ID of the poll.
  final int? id;

  /// Whether users can reselect an option after voting.
  final bool allowReselection;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The decoration applied to the background of the poll.
  final Decoration? backgroundDecoration;

  /// Whether to display the percentage of votes for each option.
  final bool showPercentages;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The text displayed next to the vote count.
  final String? votesText;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final UserDataModel? userData;

  /// Whether the poll is private.
  final bool private;

  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// A callback function that is called when an option is selected.
  ///
  /// The function takes the index of the selected option as an argument.
  final Function(int) onOptionSelected;

  /// The styles to apply to the poll.
  final Styles? allStyle;

  /// The maximum number of options allowed in the poll.
  final num? maximumOptions;

  /// A stream controller for handling vote updates.
  final StreamController<VoteData>? voteStream;

  /// A notifier for handling vote updates.
  final ValueNotifier<VoteData>? voteNotifier;

  /// The height of the poll widget.
  final double? height;

  /// The width of the poll widget.
  final double? width;

  /// The height of the progress bar.
  final double? heightProgress;

  /// The color of the progress bar.
  final Color? progressColor;

  /// The color of the background of the progress bar.
  final Color? backgroundProgressColor;

  /// The total number of votes cast in the poll.
  int? totalVotes;

  /// The labels for the poll.
  final PollsLabels? pollsLabels;

  RadioBottomPolls({
    super.key,
    required this.title,
    required this.options,
    required this.onOptionSelected,
    this.totalVotes,
    this.id,
    this.showPercentages = true,
    this.maximumOptions = 20,
    this.backgroundDecoration,
    this.allowReselection = false,
    this.heightBetweenTitleAndOptions = 10,
    this.votesText = 'Votes',
    this.createdBy,
    this.userData,
    this.private = false,
    this.loadingWidget,
    this.voteStream,
    this.allStyle,
    this.height,
    this.width,
    this.heightProgress = 15,
    this.progressColor = Colors.blue,
    this.voteNotifier,
    this.backgroundProgressColor = const Color.fromRGBO(224, 224, 224, 1),
    this.pollsLabels,
    double? heightBetweenOptions,
  })  : assert(options.length <= maximumOptions!,
            'Maximum $maximumOptions options allowed'),
        assert(maximumOptions != null && maximumOptions > 0,
            'maximumOptions must be greater than zero.');

  @override
  State<RadioBottomPolls> createState() => _RadioBottomPollsState();
}

class _RadioBottomPollsState extends State<RadioBottomPolls> {
  // Getter to check if the user has voted
  bool get hasVoted => selectedOption != null;

  // Map to store votes for each option
  Map<int, int> votes = {};
  int totalVotes = 0; // Total votes cast
  int? selectedOption; // Currently selected option

  // Function to calculate the total votes
  int totalVote() {
    return votes.values.fold(0, (sum, count) => sum + count);
  }

  // Function to update vote data and notify listeners
  void _updateVoteData() {
    final voteData = VoteData(
      totalVotes: totalVote(), // Total votes calculated
      optionVotes: Map<int, int>.from(votes), // Current votes for each option
      percentages: PollDataUtils.calculatePercentages(
        totalVotes: totalVotes, // Total votes for percentage calculation
        votes: votes, // Current votes
        options: widget.options, // Poll options
        /// The name of the user who is allowed to vote.
      ),
      userToVote: widget.userData?.userToVote,
      selectedOption: selectedOption,
      age: widget.userData?.age,
      country: widget.userData?.country,
      gender: widget.userData?.gender,
      phone: widget.userData?.phone,
      userId: widget.userData?.userId,
    );

    widget.voteNotifier?.value = voteData;

    widget.voteStream?.add(voteData); // Add updated vote data to stream
  }

  // Function to handle option selection
  void _selectOption(int index) {
    setState(() {
      if (!widget.allowReselection && selectedOption != null) {
        // If reselection is not allowed and an option is already selected, do nothing
        return;
      }

      if (selectedOption == index) {
        if (widget.allowReselection) {
          // If reselection is allowed, cancel the option
          votes[index] = (votes[index] ?? 0) - 1; // Decrease vote count
          selectedOption = null; // Deselect option
        }
      } else {
        // If a new option is selected
        if (selectedOption != null) {
          // If an option was already selected, decrease its vote
          votes[selectedOption!] = (votes[selectedOption!] ?? 0) - 1;
        }

        // Select the new option and increase its vote
        selectedOption = index; // Set new selected option
        votes[index] = (votes[index] ?? 0) + 1; // Increase vote count
      }

      // Recalculate the total votes
      totalVotes = totalVote(); // Update total votes
    });

    if (widget.id != null) {
      if (selectedOption != null) {
        PollStorage().saveVote(widget.id.toString(), selectedOption!);
      } else {
        PollStorage().clearVote(widget.id.toString());
      }
    }

    widget.onOptionSelected(selectedOption ?? -1); // Notify the selected option
    _updateVoteData(); // Update vote data
  }

  @override
  void initState() {
    super.initState();
    votes = Map<int, int>.from(votes); // Initialize votes map

    if (widget.id != null) {
      selectedOption = PollStorage().getVote(widget.id.toString());
      if (selectedOption != null) {
        votes[selectedOption!] = (votes[selectedOption!] ?? 0) + 1;
      }
    }

    totalVotes = totalVote(); // Calculate initial total votes
  }

  // Decoration for the poll widget
  Decoration decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24.0), // Rounded corners
    color: Colors.grey.shade600, // Background color
    border: Border.all(style: BorderStyle.none), // No border
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          widget.backgroundDecoration ?? // Use provided decoration or default
              decoration,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding around title
            child: Text(
              widget.title, // Display poll title
              style: widget.allStyle?.titleStyle?.style ??
                  const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold), // Title style
            ),
          ),
          ...widget.options.asMap().entries.map((entry) {
            int index = entry.key; // Get index of option
            String option = entry.value; // Get option text
            return RadioBottomPollOption(
              option: option, // Pass option text
              isSelected:
                  selectedOption == index, // Check if option is selected
              onTap: () => _selectOption(index), // Handle option tap
              votes: votes[index] ?? 0, // Get vote count for option
              totalVotes: totalVote(), // Pass total votes
              showPercentages: widget.showPercentages &&
                  hasVoted, // Show percentages if applicable
              hasVoted: hasVoted, // Pass whether user has voted
              index: index, // Pass option index
              radioBottomPolls: widget, // Pass parent widget
            );
          }),
          if (widget.votesText != null) // Check if votes text is provided
            Padding(
              padding: const EdgeInsets.all(16.0), // Padding around votes text
              child: Text(
                '${widget.pollsLabels?.votesText ?? widget.votesText} ${totalVote()}', // Display votes text and total votes
                style: widget.allStyle?.votesTextStyle?.style ??
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold), // Votes text style
              ),
            ),
        ],
      ),
    );
  }
}
