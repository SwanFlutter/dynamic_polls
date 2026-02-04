// ignore_for_file: must_be_immutable

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/material.dart';

/// A poll widget that supports multiple selections
/// در این نوع نظرسنجی، تعداد آرا و درصد نمایش داده نمیشه
/// فقط گزینه‌ها انتخاب میشن
class MultiSelectPolls extends StatefulWidget {
  /// The ID of the poll.
  final int? id;

  /// The title of the poll.
  final String title;

  /// The list of options for the poll.
  final List<String> options;

  /// The decoration applied to the background of the poll.
  final Decoration? backgroundDecoration;

  /// The height between the title and the options.
  final double? heightBetweenTitleAndOptions;

  /// The name of the user who created the poll.
  final String? createdBy;

  /// The name of the user who is allowed to vote.
  final UserDataModel? userData;

  /// The widget to display while the poll is loading.
  final Widget? loadingWidget;

  /// A callback function that is called when options are selected.
  ///
  /// The function takes a list of selected option indices as an argument.
  final Function(List<int>) onOptionsSelected;

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

  MultiSelectPolls({
    super.key,
    required this.title,
    required this.options,
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
  State<MultiSelectPolls> createState() => _MultiSelectPollsState();
}

class _MultiSelectPollsState extends State<MultiSelectPolls> {
  Set<int> selectedOptions = {};

  void _selectOption(int index) {
    setState(() {
      if (selectedOptions.contains(index)) {
        // Deselect option
        selectedOptions.remove(index);
      } else {
        // Check max selections limit
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

        // Select option
        selectedOptions.add(index);
      }
    });

    if (widget.id != null) {
      PollStorage().saveMultipleVotes(
        widget.id.toString(),
        selectedOptions.toList(),
      );
    }

    widget.onOptionsSelected(selectedOptions.toList());
  }

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      final savedVotes = PollStorage().getMultipleVotes(widget.id.toString());
      if (savedVotes != null) {
        selectedOptions = savedVotes.toSet();
      }
    }
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
                            height: widget.allStyle?.optionStyle?.height ?? 36,
                            width:
                                widget.allStyle?.optionStyle?.width ??
                                double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  widget.allStyle?.optionStyle?.borderRadius ??
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
                                    widget.allStyle?.optionStyle?.borderWidth ??
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
                                  const EdgeInsets.symmetric(horizontal: 14),
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
                      height: widget.allStyle?.votesTextStyle?.paddingTop ?? 10,
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
      ],
    );
  }
}
