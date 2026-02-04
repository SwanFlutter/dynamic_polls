// ignore_for_file: must_be_immutable, duplicate_export

library;

import 'dart:async';

import 'package:dynamic_polls/src/polls.dart';
import 'package:dynamic_polls/src/radio_bottom_polls.dart';
import 'package:dynamic_polls/src/tools/model/user_data_model.dart';
import 'package:dynamic_polls/src/tools/model/vote_data_model.dart';
import 'package:dynamic_polls/src/tools/polls_labels.dart';
import 'package:dynamic_polls/src/tools/style.dart';
import 'package:dynamic_polls/src/tools/utils/poll_data_utils.dart';
import 'package:dynamic_polls/src/tools/utils/poll_timer_manager.dart';
import 'package:dynamic_polls/src/view_only_poll_widget.dart';
import 'package:dynamic_polls/src/widget/poll_options_widget.dart';
import 'package:flutter/material.dart';

export 'package:dynamic_polls/src/multi_select_dynamic_polls.dart';
export 'package:dynamic_polls/src/multi_select_polls.dart';
export 'package:dynamic_polls/src/tools/date_style.dart';
export 'package:dynamic_polls/src/tools/model/user_data_model.dart';
export 'package:dynamic_polls/src/tools/model/vote_data_model.dart';
export 'package:dynamic_polls/src/tools/option_style.dart';
export 'package:dynamic_polls/src/tools/polls_labels.dart';
export 'package:dynamic_polls/src/tools/style.dart';
export 'package:dynamic_polls/src/tools/title_style.dart';
export 'package:dynamic_polls/src/tools/utils/poll_storage.dart';
export 'package:dynamic_polls/src/tools/votes_text_style.dart';

/// A customizable widget for displaying and interacting with a poll.
///
/// Example usage:
/// ```dart
/// DynamicPolls(
///   title: 'What is your favorite color?',
///   options: ['Red', 'Green', 'Blue'],
///   allowReselection: true,
///   showPercentages: true,
///   startDate: DateTime.now(),
///   endDate: DateTime.now().add(Duration(days: 1)),
///   backgroundDecoration: BoxDecoration(
///     color: Colors.white,
///     borderRadius: BorderRadius.circular(10),
///   ),
///   votesText: 'Votes',
///   createdBy: 'John Doe',
///   userToVote: 'John Doe',
///   private: false,
///   loadingWidget: CircularProgressIndicator(),
///   onOptionSelected: (index) {
///}
///)
///

class DynamicPolls extends StatefulWidget {
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

  /// The start date of the poll.
  final DateTime startDate;

  /// The end date of the poll.
  final DateTime endDate;

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

  /// Whether to show a timer for the poll duration.
  late final bool showTimer;

  /// Creates a new `DynamicPolls` widget.
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

  DynamicPolls({
    super.key,
    required this.title,
    required this.options,
    required this.startDate,
    required this.endDate,
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
    this.showTimer = false,
    this.voteNotifier,
    this.pollsLabels,
  }) : assert(
         options.length <= maximumOptions!,
         'Maximum $maximumOptions options allowed',
       ),
       assert(
         maximumOptions != null && maximumOptions > 0,
         'maximumOptions must be greater than zero.',
       );

  static Widget polls({
    /// The ID of the poll.
    final int? id,

    /// Whether users can reselect an option after voting.
    final bool allowReselection = false,

    /// The title of the poll.
    required final String title,

    /// The list of options for the poll.
    required final List<String> options,

    /// Whether the poll is private.
    final bool private = false,

    /// The function takes the index of the selected option as an argument.
    required final Function(int) onOptionSelected,

    /// The total number of votes cast in the poll.
    final int? totalVotes,

    /// The maximum number of options allowed in the poll.
    final num? maximumOptions = 20,

    /// The decoration applied to the background of the poll.
    final Decoration? backgroundDecoration,

    /// The height between the title and the options.
    final double? heightBetweenTitleAndOptions = 10,

    /// The text displayed next to the vote count.
    final double? heightBetweenOptions = 12,

    /// The text displayed next to the vote count.
    final String? votesText = 'Votes',

    /// The name of the user who created the poll.
    final String? createdBy,

    /// The name of the user who is allowed to vote.
    final UserDataModel? userData,

    /// The widget to display while the poll is loading.
    final Widget? loadingWidget,

    /// Whether to show a timer for the poll duration.
    final Styles? allStyle,

    /// A stream controller for handling vote updates.
    final StreamController<VoteData>? voteStream,

    /// A notifier for handling vote updates.
    final ValueNotifier<VoteData>? voteNotifier,

    /// The height of the poll widget.
    final double? height,

    /// The width of the poll widget.
    final double? width,

    /// Whether to display the percentage of votes for each option.
    final bool showPercentages = true,

    /// The labels for the poll.
    final PollsLabels? pollsLabels,
  }) {
    return Polls(
      id: id,
      title: title,
      options: options,
      totalVotes: totalVotes,
      allowReselection: allowReselection,
      maximumOptions: maximumOptions,
      backgroundDecoration: backgroundDecoration,
      heightBetweenTitleAndOptions: heightBetweenTitleAndOptions,
      heightBetweenOptions: heightBetweenOptions,
      votesText: votesText,
      createdBy: createdBy,
      userData: userData,
      loadingWidget: loadingWidget,
      onOptionSelected: onOptionSelected,
      allStyle: allStyle,
      voteStream: voteStream,
      private: private,
      height: height,
      width: width,
      showPercentages: showPercentages,
      pollsLabels: pollsLabels,
    );
  }

  static Widget radioBottomPolls({
    /// The ID of the poll.
    final int? id,

    /// Whether users can reselect an option after voting.
    required final bool allowReselection,

    /// The title of the poll.
    required final String title,

    /// The list of options for the poll.
    required final List<String> options,

    /// The decoration applied to the background of the poll.
    final Decoration? backgroundDecoration,

    /// Whether to display the percentage of votes for each option.
    final bool showPercentages = true,

    /// The height between the title and the options.
    final double? heightBetweenTitleAndOptions = 10,

    /// The text displayed next to the vote count.
    final String? votesText = 'Votes',

    /// The name of the user who created the poll.
    final String? createdBy,

    /// The name of the user who is allowed to vote.
    final UserDataModel? userData,

    /// Whether the poll is private.
    final bool private = false,

    /// The widget to display while the poll is loading.
    final Widget? loadingWidget,

    /// A callback function that is called when an option is selected.
    ///
    /// The function takes the index of the selected option as an argument.
    required final Function(int) onOptionSelected,

    /// The styles to apply to the poll.
    final Styles? allStyle,

    /// The maximum number of options allowed in the poll.
    final num? maximumOptions = 20,

    /// A stream controller for handling vote updates.
    final StreamController<VoteData>? voteStream,

    /// A notifier for handling vote updates.
    final ValueNotifier<VoteData>? voteNotifier,

    /// The height of the poll widget.
    final double? height,

    /// The width of the poll widget.
    final double? width,

    /// The height of the progress bar.
    final double? heightProgress = 15,

    /// The color of the progress bar.
    final Color? progressColor = Colors.blue,

    /// The color of the background of the progress bar.
    final Color? backgroundProgressColor = const Color.fromRGBO(
      224,
      224,
      224,
      1,
    ),

    /// The total number of votes cast in the poll.
    int? totalVotes,

    /// The height of the progress bar.
    final double? heightBetweenOptions = 10,

    /// The labels for the poll.
    final PollsLabels? pollsLabels,
  }) {
    return RadioBottomPolls(
      id: id,
      allowReselection: allowReselection,
      title: title,
      options: options,
      backgroundDecoration: backgroundDecoration,
      showPercentages: showPercentages,
      heightBetweenTitleAndOptions: heightBetweenTitleAndOptions,
      votesText: votesText,
      createdBy: createdBy,
      userData: userData,
      private: private,
      loadingWidget: loadingWidget,
      onOptionSelected: onOptionSelected,
      allStyle: allStyle,
      maximumOptions: maximumOptions,
      voteStream: voteStream,
      height: height,
      width: width,
      heightProgress: heightProgress,
      progressColor: progressColor,
      backgroundProgressColor: backgroundProgressColor,
      totalVotes: totalVotes,
      heightBetweenOptions: heightBetweenOptions,
      pollsLabels: pollsLabels,
    );
  }

  /// Creates a view-only poll widget.
  ///
  /// This widget displays the poll results without allowing users to vote.
  ///
  /// The [title], [options], [votes], and [totalVotes] parameters are required.
  ///
  /// The [showPercentages] parameter defaults to `true`.
  ///
  /// The other parameters are optional and can be used to customize the
  /// appearance of the poll.
  static Widget viewOnlyPollWidget({
    final bool allowReselection = false,
    required final String title,
    required final List<String> options,
    required final Map<int, int> votes,
    required final int totalVotes,
    final bool showPercentages = true,
    required final DateTime startDate,
    required final DateTime endDate,
    final double? heightBetweenTitleAndOptions = 10,
    final double? heightBetweenOptions = 12,
    final String? votesText = 'Votes',
    final TextStyle? votesTextStyle,
    final Widget? metaWidget,
    final String? createdBy,
    final String? userToVote,
    final double? pollOptionsHeight = 48,
    final double? pollOptionsWidth,
    final BorderRadius? pollOptionsBorderRadius,
    final Color? pollOptionsFillColor = Colors.white,
    final Color? pollOptionsSplashColor = Colors.grey,
    final BoxBorder? pollOptionsBorder,
    final BoxBorder? votedPollOptionsBorder,
    final Radius? votedPollOptionsRadius,
    final Color? votedBackgroundColor = const Color(0xffEEF0EB),
    final Color? votedProgressColor = const Color(0xff84D2F6),
    final Color? leadingVotedProgessColor = const Color(0xff0496FF),
    final Color? voteInProgressColor = const Color(0xffEEF0EB),
    final Widget? votedCheckmark,
    final TextStyle? votedPercentageTextStyle,
    final int votedAnimationDuration = 1000,
    final Widget? loadingWidget,
  }) {
    return ViewOnlyPollWidget(
      allowReselection: allowReselection,
      title: title,
      options: options,
      votes: votes,
      totalVotes: totalVotes,
      showPercentages: showPercentages,
      startDate: startDate,
      endDate: endDate,
      heightBetweenTitleAndOptions: heightBetweenTitleAndOptions,
      heightBetweenOptions: heightBetweenOptions,
      votesText: votesText,
      votesTextStyle: votesTextStyle,
      metaWidget: metaWidget,
      createdBy: createdBy,
      userToVote: userToVote,
      pollOptionsHeight: pollOptionsHeight,
      pollOptionsWidth: pollOptionsWidth,
      pollOptionsBorderRadius: pollOptionsBorderRadius,
      pollOptionsFillColor: pollOptionsFillColor,
      pollOptionsSplashColor: pollOptionsSplashColor,
      pollOptionsBorder: pollOptionsBorder,
      votedPollOptionsBorder: votedPollOptionsBorder,
      votedPollOptionsRadius: votedPollOptionsRadius,
      votedBackgroundColor: votedBackgroundColor,
      votedProgressColor: votedProgressColor,
      voteInProgressColor: voteInProgressColor,
      votedCheckmark: votedCheckmark,
      votedAnimationDuration: votedAnimationDuration,
      loadingWidget: loadingWidget,
    );
  }

  @override
  State<DynamicPolls> createState() => _DynamicPollsState();
}

class _DynamicPollsState extends State<DynamicPolls> {
  bool get hasVoted => selectedOption != null;

  late Duration remainingTime = Duration.zero;
  Timer? _timer;
  String formattedTime = "00:00";
  Map<int, int> votes = {};
  int totalVotes = 0;
  int? selectedOption;
  bool isClickable = false;
  bool _showTimer = true;

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

      /// The name of the user who is allowed to vote.
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
    if (!isClickable) return;

    setState(() {
      if (!widget.allowReselection && selectedOption != null) {
        // If reselection is not allowed and an option is already selected, do nothing
        return;
      }

      // Always increment/decrement to force a change
      if (selectedOption == index) {
        // Deselect or reduce vote
        votes[index] = (votes[index] ?? 0) - 1;
        selectedOption = null;
      } else {
        // If a previous option was selected, reduce its votes
        if (selectedOption != null) {
          votes[selectedOption!] = (votes[selectedOption!] ?? 0) - 1;
        }

        // Select new option and increment its votes
        selectedOption = index;
        votes[index] = (votes[index] ?? 0) + 1;
      }

      // Force recalculation of total votes
      totalVotes = totalVote();
    });

    widget.onOptionSelected(selectedOption ?? -1);
    _updateVoteData();
  }

  void _updatePollStatus() {
    final now = DateTime.now();
    bool newIsClickable = false;

    // Determine if the timer should be shown
    if (now.isBefore(widget.startDate)) {
      _showTimer = widget.showTimer; // Show timer before the poll starts
    } else if (now.isAfter(widget.endDate)) {
      _showTimer = false; // Hide timer after the poll ends
    } else {
      _showTimer = false; // Hide timer when the poll is active
    }

    // Update remaining time and clickable status
    if (now.isAfter(widget.startDate.subtract(const Duration(seconds: 1))) &&
        now.isBefore(widget.endDate.add(const Duration(seconds: 1)))) {
      remainingTime = widget.endDate.difference(now);
      newIsClickable = true;
    } else if (now.isBefore(widget.startDate)) {
      remainingTime = widget.startDate.difference(now);
      newIsClickable = false;
    } else {
      remainingTime = Duration.zero;
      newIsClickable = false;
    }

    String newFormattedTime = PollTimerManager.formatTimer(remainingTime);
    if (isClickable != newIsClickable ||
        formattedTime != newFormattedTime ||
        _showTimer != widget.showTimer) {
      isClickable = newIsClickable;
      formattedTime = newFormattedTime;

      setState(() {});
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updatePollStatus();

      // اگر زمان به پایان رسید، توقف تایمر
      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
        _timer = null;
        setState(() {
          isClickable = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    votes = Map<int, int>.from(votes);
    totalVotes = totalVote();

    final now = DateTime.now();
    // محاسبه دقیق‌تر وضعیت اولیه
    isClickable = now.isAfter(widget.startDate) && now.isBefore(widget.endDate);

    _updatePollStatus();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Decoration decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24.0),
    color: Colors.grey.shade200,
    border: Border.all(style: BorderStyle.none),
  );

  @override
  Widget build(BuildContext context) {
    final showTimeStyle = widget.allStyle?.showTimeStyle;

    return Stack(
      children: [
        Opacity(
          opacity: isClickable ? 1.0 : 0.5,
          child: IgnorePointer(
            ignoring: !isClickable,
            child: LayoutBuilder(
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
                              widget.allStyle?.titleStyle!.alignment ??
                              Alignment.centerLeft,
                          child: SelectableText(
                            maxLines: widget.allStyle?.titleStyle!.maxLines,
                            minLines: widget.allStyle?.titleStyle!.minLines,
                            textAlign:
                                widget.allStyle?.titleStyle!.textAlign ??
                                TextAlign.center,
                            textDirection:
                                widget.allStyle?.titleStyle!.textDirection ??
                                TextDirection.ltr,
                            widget.title,
                            style:
                                widget.allStyle?.titleStyle!.style ??
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
                            child: PollOptionWidget(
                              dynamicPoll: widget,
                              option: option,
                              votes: votes[index] ?? 0,
                              totalVotes: totalVote(),
                              onTap: () => _selectOption(index),
                              isSelected: selectedOption == index,
                              index: index,
                              hasVoted: hasVoted,
                              isClickable: isClickable,
                            ),
                          );
                        }),
                        SizedBox(
                          height:
                              widget.allStyle?.votesTextStyle?.paddingTop ?? 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment:
                                  widget.allStyle?.votesTextStyle?.alignment ??
                                  Alignment.centerLeft,
                              child: Text(
                                '${widget.votesText} ${totalVote()}',
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
          ),
        ),
        if (_showTimer && remainingTime.inSeconds > 0)
          Positioned.fill(
            child: Align(
              alignment:
                  widget.allStyle?.showTimeStyle?.alignment ?? Alignment.center,
              child: Container(
                height: showTimeStyle?.height,
                width: showTimeStyle?.width,
                padding: const EdgeInsets.all(16.0),
                decoration:
                    showTimeStyle?.decoration ??
                    BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                child: Text(
                  '${widget.allStyle?.showTimeStyle?.text ?? "Time remaining: "} $formattedTime',
                  style:
                      widget.allStyle?.showTimeStyle?.style ??
                      const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
    super.key,
    required this.widget,
    required this.constraints,
  });

  final DynamicPolls widget;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.allStyle?.dateStyle?.textStart ?? 'Started by: ',
                  children: [
                    TextSpan(
                      text: widget.startDate.toLocal().toString().split(' ')[0],
                    ),
                  ],
                  style:
                      widget.allStyle?.dateStyle?.textStyle ??
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.allStyle?.dateStyle?.textStart ?? 'Ends by: ',
                  children: [
                    TextSpan(
                      text: widget.endDate.toLocal().toString().split(' ')[0],
                    ),
                  ],
                  style:
                      widget.allStyle?.dateStyle?.textStyle ??
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
