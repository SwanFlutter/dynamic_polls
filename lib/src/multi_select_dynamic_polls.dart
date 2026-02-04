// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:dynamic_polls/src/tools/utils/poll_timer_manager.dart';
import 'package:flutter/material.dart';

/// A dynamic poll widget with timer that supports multiple selections
/// در این نوع نظرسنجی، تعداد آرا و درصد نمایش داده نمیشه
/// فقط گزینه‌ها انتخاب میشن و تایمر و callback اتمام داره
class MultiSelectDynamicPolls extends StatefulWidget {
  /// The ID of the poll.
  final int? id;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The decoration applied to the background of the poll.
  final Decoration? backgroundDecoration;

  /// The start date of the poll.
  final DateTime startDate;

  /// The end date of the poll.
  final DateTime endDate;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final UserDataModel? userData;

  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// A callback function that is called when options are selected.
  final Function(List<int>) onOptionsSelected;

  /// A callback function that is called when the poll ends.
  final Function(bool)? onPollEnded;

  /// The styles to apply to the poll.
  final Styles? allStyle;

  /// The maximum number of options allowed in the poll.
  final num? maximumOptions;

  /// Maximum number of selections allowed (null = unlimited)
  final int? maxSelections;

  /// The height of the poll widget.
  final double? height;

  /// The width of the poll widget.
  final double? width;

  /// The labels for the poll.
  final PollsLabels? pollsLabels;

  /// Whether to show a timer for the poll duration.
  late final bool showTimer;

  MultiSelectDynamicPolls({
    super.key,
    required this.title,
    required this.options,
    required this.startDate,
    required this.endDate,
    required this.onOptionsSelected,
    this.id,
    this.maximumOptions = 20,
    this.maxSelections,
    this.backgroundDecoration,
    this.heightBetweenTitleAndOptions = 10,
    this.createdBy,
    this.userData,
    this.loadingWidget,
    this.allStyle,
    this.height,
    this.width,
    this.showTimer = false,
    this.pollsLabels,
    this.onPollEnded,
  }) : assert(
         options.length <= maximumOptions!,
         'Maximum $maximumOptions options allowed',
       ),
       assert(
         maximumOptions != null && maximumOptions > 0,
         'maximumOptions must be greater than zero.',
       );

  @override
  State<MultiSelectDynamicPolls> createState() =>
      _MultiSelectDynamicPollsState();
}

class _MultiSelectDynamicPollsState extends State<MultiSelectDynamicPolls> {
  late Duration remainingTime = Duration.zero;
  Timer? _timer;
  String formattedTime = "00:00";
  Set<int> selectedOptions = {};
  bool isClickable = false;
  bool _showTimer = true;
  bool _pollEnded = false;

  void _selectOption(int index) {
    if (!isClickable) return;

    setState(() {
      if (selectedOptions.contains(index)) {
        selectedOptions.remove(index);
      } else {
        if (widget.maxSelections != null &&
            selectedOptions.length >= widget.maxSelections!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'حداکثر ${widget.maxSelections} گزینه می‌توانید انتخاب کنید',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          return;
        }
        selectedOptions.add(index);
      }
    });

    widget.onOptionsSelected(selectedOptions.toList());
  }

  void _updatePollStatus() {
    final now = DateTime.now();
    bool newIsClickable = false;

    if (now.isBefore(widget.startDate)) {
      _showTimer = widget.showTimer;
    } else if (now.isAfter(widget.endDate)) {
      _showTimer = false;
    } else {
      _showTimer = false;
    }

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

      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
        _timer = null;
        setState(() {
          isClickable = false;
        });

        if (!_pollEnded && widget.onPollEnded != null) {
          _pollEnded = true;
          widget.onPollEnded!(true);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
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
                        if (widget.maxSelections != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'حداکثر ${widget.maxSelections} گزینه',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        SizedBox(height: widget.heightBetweenTitleAndOptions),
                        ...widget.options.asMap().entries.map((entry) {
                          int index = entry.key;
                          String option = entry.value;
                          bool isSelected = selectedOptions.contains(index);

                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  widget
                                      .allStyle
                                      ?.optionStyle
                                      ?.heightBetweenOptions ??
                                  8,
                            ),
                            child: GestureDetector(
                              onTap: () => _selectOption(index),
                              child: Container(
                                height:
                                    widget.allStyle?.optionStyle?.height ?? 36,
                                width:
                                    widget.allStyle?.optionStyle?.width ??
                                    double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      widget
                                          .allStyle
                                          ?.optionStyle
                                          ?.borderRadius ??
                                      BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? widget
                                                  .allStyle
                                                  ?.optionStyle
                                                  ?.selectedBorderColor ??
                                              Colors.blue
                                        : widget
                                                  .allStyle
                                                  ?.optionStyle
                                                  ?.unselectedBorderColor ??
                                              Colors.grey,
                                    width:
                                        widget
                                            .allStyle
                                            ?.optionStyle
                                            ?.borderWidth ??
                                        2.0,
                                  ),
                                  color:
                                      widget.allStyle?.optionStyle?.fillColor ??
                                      Colors.white,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding:
                                      widget
                                          .allStyle
                                          ?.optionStyle
                                          ?.contentPadding ??
                                      const EdgeInsets.symmetric(
                                        horizontal: 14,
                                      ),
                                  child: Row(
                                    children: [
                                      if (isSelected &&
                                          widget
                                                  .allStyle
                                                  ?.optionStyle
                                                  ?.votedCheckmark !=
                                              null) ...[
                                        widget
                                            .allStyle!
                                            .optionStyle!
                                            .votedCheckmark,
                                        const SizedBox(width: 5),
                                      ],
                                      Expanded(
                                        child: Text(
                                          option,
                                          style: TextStyle(
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: isSelected
                                                ? widget
                                                          .allStyle
                                                          ?.optionStyle
                                                          ?.textSelectColor ??
                                                      Colors.blue.withValues(
                                                        alpha: 0.8,
                                                      )
                                                : Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle,
                                          color:
                                              widget
                                                  .allStyle
                                                  ?.optionStyle
                                                  ?.selectedBorderColor ??
                                              Colors.blue,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height:
                              widget.allStyle?.votesTextStyle?.paddingTop ?? 10,
                        ),
                        if (selectedOptions.isNotEmpty)
                          Text(
                            '${selectedOptions.length} گزینه انتخاب شده',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
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
