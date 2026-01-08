// ignore_for_file: unnecessary_cast

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/material.dart';

/// A widget representing a single poll option in a dynamic polling system.
class PollOptionWidget extends StatefulWidget {
  /// The poll object containing the dynamic data for the poll.
  final DynamicPolls dynamicPoll;

  /// The text for the poll option.
  final String option;

  /// The number of votes received for this option.
  final int votes;

  /// The total number of votes in the poll, used to calculate percentage.
  final int totalVotes;

  /// The callback triggered when the option is tapped.
  final VoidCallback onTap;

  /// Whether this option is currently selected. Defaults to `false`.
  final bool isSelected;

  /// Whether the user has already voted in the poll.
  final bool hasVoted;

  /// The index of this option in the poll options list.
  final int index;

  /// Whether the option is clickable.
  final bool isClickable;

  /// Creates an instance of [PollOptionWidget].

  const PollOptionWidget({
    super.key,
    required this.dynamicPoll,
    required this.option,
    required this.votes,
    required this.totalVotes,
    required this.onTap,
    required this.index,
    required this.hasVoted,
    required this.isClickable,
    this.isSelected = false,
  });

  @override
  State<PollOptionWidget> createState() => _PollOptionWidgetState();
}

class _PollOptionWidgetState extends State<PollOptionWidget>
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
  void didUpdateWidget(PollOptionWidget oldWidget) {
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
    final borderRadius = optionStyle?.borderRadius ?? BorderRadius.circular(8);
    final progressBorderWidth = optionStyle?.progressBorderWidth ?? 0;

    return IgnorePointer(
      ignoring: !widget.isClickable,
      child: GestureDetector(
        onTap: widget.isClickable ? widget.onTap : null,
        child: Opacity(
          opacity: widget.isClickable ? 1.0 : 0.5,
          child: Container(
            height: optionStyle?.height ?? 36,
            width: optionStyle?.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: widget.isSelected
                    ? optionStyle?.selectedBorderColor ?? Colors.blue
                    : optionStyle?.unselectedBorderColor ?? Colors.grey,
                width: optionStyle?.borderWidth ?? 2.0,
              ),
              color: optionStyle?.fillColor ?? Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (widget.hasVoted && !widget.dynamicPoll.private)
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return FractionallySizedBox(
                          widthFactor: _animation.value,
                          alignment: Alignment.centerLeft,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: progressBorderWidth > 0
                                  ? BorderRadius.horizontal(
                                      right: Radius.circular(
                                          borderRadius.topRight.y),
                                    )
                                  : null,
                              color: widget.isSelected
                                  ? optionStyle?.leadingVotedProgessColor
                                          ?.withValues(
                                              alpha: optionStyle
                                                      .opacityLeadingVotedProgessColor ??
                                                  0.2) ??
                                      Colors.blue.withValues(alpha: 0.2)
                                  : optionStyle?.votedBackgroundColor
                                          ?.withValues(alpha: 0.8) ??
                                      Colors.blue.withValues(alpha: 0.8),
                              border: progressBorderWidth > 0
                                  ? Border.symmetric(
                                      vertical: BorderSide(
                                        color: widget.isSelected
                                            ? optionStyle
                                                    ?.voteBorderProgressColor ??
                                                Colors.blue
                                            : Colors.transparent,
                                        width: progressBorderWidth,
                                      ),
                                    )
                                  : null,
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
                              optionStyle?.votedCheckmark != null) ...[
                            optionStyle!.votedCheckmark,
                            const SizedBox(width: 5),
                          ],
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
                                        Colors.blue.withValues(alpha: 0.8)
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
                                            Colors.blue.withValues(alpha: 0.8)
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
      ),
    );
  }
}
