extension StringExtension on String {
  static const String defaultSplitDelimiter = '_';
  static const String defaultJoinDelimiter = '';
  // REF: https://gist.github.com/filiph/d4e0c0a9efb0f869f984317372f5bee8
  String toPascalCase({
    String splitDelimiter = defaultSplitDelimiter,
    String joinDelimiter = defaultJoinDelimiter,
  }) {
    final text = this;

    if (text.isEmpty) return text;

    return text
        .split(splitDelimiter)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(joinDelimiter);
  }
}
