import 'package:dynamic_polls/src/radio_bottom_polls.dart';
import 'package:flutter/material.dart';

class RadioBottomPollOption extends StatefulWidget {
  /// Holds the poll's styling and configuration
  final RadioBottomPolls radioBottomPolls;

  /// The text of the poll option
  final String option;

  /// Indicates if this option is currently selected
  final bool isSelected;

  /// Callback function when the option is tapped
  final VoidCallback onTap;

  /// Number of votes this option has received
  final int votes;

  /// Total number of votes across all options
  final int totalVotes;

  /// Flag to determine if percentages should be shown
  final bool showPercentages;

  /// Indicates if the user has already voted
  final bool hasVoted;

  /// The index of this option in the poll
  final int index;

  const RadioBottomPollOption({
    super.key,
    required this.radioBottomPolls,
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.votes,
    required this.totalVotes,
    required this.showPercentages,
    required this.hasVoted,
    required this.index,
  });

  @override
  State<RadioBottomPollOption> createState() => _RadioBottomPollOptionState();
}

class _RadioBottomPollOptionState extends State<RadioBottomPollOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controller for managing the animation
  late Animation<double> _animation; // Animation for the progress bar

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Provides a ticker for the animation
      duration:
          widget.radioBottomPolls.allStyle?.optionStyle?.animationDuration ??
          const Duration(milliseconds: 1000), // Sets animation duration
    );
    _animation = Tween<double>(
      begin: 0,
      end: _getPercentage(),
    ).animate(_controller); // Initializes the animation with the percentage
    _controller.forward(); // Starts the animation
  }

  @override
  void didUpdateWidget(RadioBottomPollOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Checks if votes or total votes have changed to update the animation
    if (oldWidget.votes != widget.votes ||
        oldWidget.totalVotes != widget.totalVotes) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: _getPercentage(),
      ).animate(_controller); // Updates the animation to the new percentage
      _controller.forward(from: 0); // Restarts the animation from the beginning
    }
  }

  double _getPercentage() {
    // Calculates the percentage of votes this option has received
    return widget.totalVotes > 0
        ? widget.votes / widget.totalVotes
        : 0; // Avoids division by zero
  }

  @override
  void dispose() {
    _controller.dispose(); // Disposes of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final optionStyle = widget
        .radioBottomPolls
        .allStyle
        ?.optionStyle; // Retrieves the option style

    return InkWell(
      onTap: widget.onTap, // Sets the onTap callback for the InkWell
      child: Padding(
        padding: const EdgeInsets.all(16), // Adds padding around the option
        child: Row(
          children: [
            Icon(
              widget.isSelected
                  ? Icons.radio_button_checked
                  : Icons
                        .radio_button_unchecked, // Displays the appropriate radio button icon based on selection
              color: widget.isSelected
                  ? optionStyle?.selectedBorderColor ?? Colors.blue
                  : Colors.grey, // Sets the icon color based on selection
            ),
            const SizedBox(width: 12), // Adds space between the icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Aligns children to the start of the column
                children: [
                  Text(
                    widget.option, // Displays the option text
                    style: TextStyle(
                      fontWeight: widget.isSelected
                          ? FontWeight.bold
                          : FontWeight
                                .normal, // Sets font weight based on selection
                      color: widget.isSelected
                          ? optionStyle?.textSelectColor ?? Colors.blue
                          : Colors.black, // Sets text color based on selection
                    ),
                  ),
                  const SizedBox(height: 4), // Adds space below the option text
                  if (widget.hasVoted &&
                      !widget
                          .radioBottomPolls
                          .private) // Checks if the user has voted and the poll is not private
                    AnimatedBuilder(
                      animation:
                          _animation, // Listens to the animation for updates
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: widget
                                  .radioBottomPolls
                                  .heightProgress, // Sets the height of the progress bar
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  widget.radioBottomPolls.heightProgress!,
                                ), // Rounds the corners of the progress bar
                                color: widget
                                    .radioBottomPolls
                                    .backgroundProgressColor, // Sets the background color of the progress bar
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: _animation
                                  .value, // Sets the width of the filled portion based on animation value
                              child: Container(
                                height: widget
                                    .radioBottomPolls
                                    .heightProgress, // Sets the height of the filled portion
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    widget.radioBottomPolls.heightProgress!,
                                  ), // Rounds the corners of the filled portion
                                  color: widget.isSelected
                                      ? widget.radioBottomPolls.progressColor ??
                                            Colors.blue
                                      : widget.radioBottomPolls.progressColor
                                                ?.withValues(alpha: 0.6) ??
                                            Colors.blue.withValues(
                                              alpha: 0.6,
                                            ), // Sets the color based on selection
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
            if (widget.hasVoted &&
                !widget
                    .radioBottomPolls
                    .private) // Checks if the user has voted and the poll is not private
              AnimatedBuilder(
                animation: _animation, // Listens to the animation for updates
                builder: (context, child) {
                  return Text(
                    '${(_animation.value * 100).toStringAsFixed(1)}%', // Displays the percentage of votes
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold, // Sets the font weight to bold
                      color: widget.isSelected
                          ? optionStyle?.textSelectColor ?? Colors.blue
                          : optionStyle?.otherTextPercentColor ??
                                Colors
                                    .grey, // Sets text color based on selection
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
