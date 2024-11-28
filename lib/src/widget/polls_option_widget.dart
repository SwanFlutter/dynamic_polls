import 'package:dynamic_polls/src/polls.dart';
import 'package:flutter/material.dart';

/// The `PollOptionWidget` class represents a widget for displaying a poll option with relevant data and
/// functionality.

class PollsOptionWidget extends StatefulWidget {
  /// The dynamic data for the poll.
  final Polls dynamicPoll;

  /// The text of the poll option.
  final String option;

  /// The number of votes for this option.
  final int votes;

  /// The total number of votes for the poll.
  final int totalVotes;

  /// A callback function that is called when the user taps on the option.
  final VoidCallback onTap;

  /// A boolean indicating whether this option is currently selected.
  final bool isSelected;

  /// A boolean indicating whether the user has already voted.
  final bool hasVoted;

  /// The index of this option in the poll.
  final int index;

  /// Creates a new instance of [PollsOptionWidget].
  const PollsOptionWidget({
    super.key,
    required this.dynamicPoll,
    required this.option,
    required this.votes,
    required this.totalVotes,
    required this.onTap,
    required this.index,
    required this.hasVoted,
    this.isSelected = false,
  });

  @override
  State<PollsOptionWidget> createState() => _PollsOptionWidgetState();
}

class _PollsOptionWidgetState extends State<PollsOptionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.dynamicPoll.allStyle?.optionStyle?.animationDuration ??
          const Duration(milliseconds: 1000),
    );
    _animation =
        Tween<double>(begin: 0, end: _getPercentage()).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(PollsOptionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.votes != widget.votes ||
        oldWidget.totalVotes != widget.totalVotes) {
      _animation = Tween<double>(begin: _animation.value, end: _getPercentage())
          .animate(_controller);
      _controller.forward(from: 0);
    }
  }

  double _getPercentage() {
    return widget.totalVotes > 0 ? widget.votes / widget.totalVotes : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optionStyle = widget.dynamicPoll.allStyle?.optionStyle;

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: optionStyle?.borderRadius ?? BorderRadius.circular(8),
        child: Container(
          height: optionStyle?.height ?? 36,
          width: optionStyle?.width ?? double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: optionStyle?.borderRadius ?? BorderRadius.circular(8),
            border: Border.all(
              color: widget.isSelected
                  ? optionStyle?.selectedBorderColor ?? Colors.blue
                  : optionStyle?.unselectedBorderColor ?? Colors.grey,
              width: optionStyle?.borderWidth ?? 2.0,
            ),
            color: optionStyle?.fillColor ?? Colors.white,
          ),
          child: Stack(
            children: [
              if (widget.hasVoted &&
                  !widget.dynamicPoll
                      .private) // Only show progress bar if not private
                ClipRRect(
                  borderRadius:
                      optionStyle?.borderRadius ?? BorderRadius.circular(8.0),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        widthFactor: _animation.value,
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: optionStyle?.borderRadius ??
                              BorderRadius.circular(8.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: optionStyle?.borderRadius ??
                                  BorderRadius.only(
                                      topRight: Radius.circular(optionStyle
                                              ?.borderRadius?.topLeft.x ??
                                          8.0),
                                      bottomRight: Radius.circular(optionStyle
                                              ?.borderRadius?.topLeft.x ??
                                          8.0)),
                              color: widget.isSelected
                                  ? optionStyle?.leadingVotedProgessColor!
                                          .withOpacity(optionStyle
                                                  .opacityLeadingVotedProgessColor ??
                                              0.2) ??
                                      Colors.blue.withOpacity(0.2)
                                  : optionStyle?.votedBackgroundColor
                                          ?.withOpacity(0.8) ??
                                      Colors.blue.withOpacity(0.8),
                              border: Border.all(
                                color: widget.isSelected
                                    ? optionStyle?.voteBorderProgressColor ??
                                        Colors.blue
                                    : Colors.transparent,
                                width: optionStyle?.progressBorderWidth ??
                                    0, // Set progress bar border width
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.isSelected &&
                            optionStyle?.votedCheckmark != null)
                          optionStyle!.votedCheckmark,
                        const SizedBox(width: 5),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.40,
                          child: Text(
                            widget.option,
                            style: TextStyle(
                              fontWeight: widget.isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: widget.isSelected
                                  ? optionStyle?.textSelectColor ??
                                      Colors.blue.withOpacity(0.8)
                                  : Colors.black,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const Spacer(),
                        if (widget.hasVoted && !widget.dynamicPoll.private)
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Text(
                                '${(_animation.value * 100).toStringAsFixed(1)}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.isSelected
                                      ? optionStyle?.textSelectColor ??
                                          Colors.blue.withOpacity(0.8)
                                      : optionStyle?.otherTextPercentColor,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
