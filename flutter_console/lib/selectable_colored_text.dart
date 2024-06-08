import 'package:flutter/material.dart';
import 'dart:math';

// REF: https://stackoverflow.com/questions/68604853/set-the-color-of-selected-text
class SelectableColoredText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color selectedTextColor;
  final Color selectedTextBackgroundColor;

  const SelectableColoredText(
    this.text, {
    Key? key,
    this.style,
    required this.selectedTextColor,
    required this.selectedTextBackgroundColor,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SelectableColoredTextState createState() => _SelectableColoredTextState();
}

class _SelectableColoredTextState extends State<SelectableColoredText> {
  int? _start;
  int? _end;

  @override
  Widget build(BuildContext context) {
    final int start = _start ?? widget.text.length;
    final int end = _end ?? widget.text.length;
    return SelectableText.rich(
      TextSpan(
        style: widget.style ?? Theme.of(context).textTheme.bodyMedium,
        children: [
          // Text before the selection
          TextSpan(text: widget.text.substring(0, start)),
          // Selected text
          TextSpan(
            text: widget.text.substring(start, end),
            style: TextStyle(
              color: widget.selectedTextColor,
              backgroundColor: widget.selectedTextBackgroundColor,
            ),
          ),
          // Text after the selection
          TextSpan(text: widget.text.substring(end, widget.text.length)),
        ],
      ),
      // Update the start and end positions of the selection
      onSelectionChanged: (selection, _) {
        final int newStart = min(selection.baseOffset, selection.extentOffset);
        final int newEnd = max(selection.baseOffset, selection.extentOffset);
        if (_start == newStart && _end == newEnd) return;
        setState(() {
          _start = newStart;
          _end = newEnd;
        });
      },
    );
  }
}
