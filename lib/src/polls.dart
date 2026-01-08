// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:dynamic_polls/src/tools/utils/poll_data_utils.dart';
import 'package:dynamic_polls/src/widget/polls_option_widget.dart';
import 'package:flutter/material.dart';

class Polls extends StatefulWidget {
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

  /// The labels for the poll.
  final PollsLabels? pollsLabels;

  /// The total number of votes cast in the poll.
  int? totalVotes;

  /// Creates a new `CustomPoll` widget.
  ///
  /// The [title], [options], [startDate], and [endDate]
  /// parameters are required.
  ///
  /// The [showPercentages] parameter defaults to `true`.
  ///
  /// The [maximumOptions] parameter defaults to `20`.
  ///
  /// The other parameters are optional and can be used to customize the
  /// appearance and behavior of the poll.

  Polls({
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
    this.voteNotifier,
    this.pollsLabels,
    double? heightBetweenOptions,
  }) : assert(
         options.length <= maximumOptions!,
         'Maximum $maximumOptions options allowed',
       ),
       assert(
         maximumOptions != null && maximumOptions > 0,
         'maximumOptions must be greater than zero.',
       );

  @override
  State<Polls> createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  bool get hasVoted => selectedOption != null;

  Map<int, int> votes = {};
  int totalVotes = 0;
  int? selectedOption;

  int totalVote() {
    return votes.values.fold(0, (sum, count) => sum + count);
  }

  void _updateVoteData() {
    final voteData = VoteData(
      totalVotes: totalVote(),
      optionVotes: Map<int, int>.from(votes),
      percentages: PollDataUtils.calculatePercentages(
        totalVotes: totalVotes,
        votes: votes,
        options: widget.options,
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
    widget.voteStream?.add(voteData);
  }

  void _selectOption(int index) {
    setState(() {
      if (!widget.allowReselection && selectedOption != null) {
        // If reselection is not allowed and an option is already selected, do nothing
        return;
      }

      if (selectedOption == index) {
        if (widget.allowReselection) {
          // If reselection is allowed, cancel the option
          votes[index] = (votes[index] ?? 0) - 1;
          selectedOption = null;
        }
      } else {
        // If a new option is selected
        if (selectedOption != null) {
          // If an option was already selected, decrease its vote
          votes[selectedOption!] = (votes[selectedOption!] ?? 0) - 1;
        }

        // Select the new option and increase its vote
        selectedOption = index;
        votes[index] = (votes[index] ?? 0) + 1;
      }

      // Recalculate the total votes
      totalVotes = totalVote();
    });

    if (widget.id != null) {
      if (selectedOption != null) {
        PollStorage().saveVote(widget.id.toString(), selectedOption!);
      } else {
        PollStorage().clearVote(widget.id.toString());
      }
    }

    widget.onOptionSelected(selectedOption ?? -1);
    _updateVoteData();
  }

  @override
  void initState() {
    super.initState();
    votes = Map<int, int>.from(votes);

    if (widget.id != null) {
      selectedOption = PollStorage().getVote(widget.id.toString());
      if (selectedOption != null) {
        votes[selectedOption!] = (votes[selectedOption!] ?? 0) + 1;
      }
    }

    totalVotes = totalVote();
  }

  Decoration decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24.0),
    color: Colors.grey.shade200,
    border: Border.all(style: BorderStyle.none),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: widget.height != 0
                  ? widget.height
                  : constraints.maxHeight * 0.4,
              width: widget.width != 0
                  ? widget.width
                  : constraints.maxWidth * 0.8,
              decoration: widget.backgroundDecoration ?? decoration,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment:
                          widget.allStyle?.titleStyle?.alignment ??
                          Alignment.centerLeft,
                      child: SelectableText(
                        maxLines: widget.allStyle?.titleStyle?.maxLines,
                        minLines: widget.allStyle?.titleStyle?.minLines,
                        textAlign:
                            widget.allStyle?.titleStyle?.textAlign ??
                            TextAlign.center,
                        textDirection:
                            widget.allStyle?.titleStyle?.textDirection ??
                            TextDirection.ltr,
                        widget.title,
                        style:
                            widget.allStyle?.titleStyle?.style ??
                            const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(height: widget.heightBetweenTitleAndOptions),
                    ...widget.options.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              widget
                                  .allStyle
                                  ?.optionStyle
                                  ?.heightBetweenOptions ??
                              8,
                        ),
                        child: PollsOptionWidget(
                          dynamicPoll: widget,
                          option: option,
                          votes: votes[index] ?? 0,
                          totalVotes: totalVote(),
                          onTap: () => _selectOption(index),
                          isSelected: selectedOption == index,
                          index: index,
                          hasVoted: hasVoted,
                        ),
                      );
                    }),
                    SizedBox(
                      height: widget.allStyle?.votesTextStyle?.paddingTop ?? 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment:
                              widget.allStyle?.votesTextStyle?.alignment ??
                              Alignment.centerLeft,
                          child: Text(
                            '${widget.pollsLabels?.votesText ?? widget.votesText} ${totalVote()}',
                            style:
                                widget.allStyle?.votesTextStyle?.style ??
                                const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
