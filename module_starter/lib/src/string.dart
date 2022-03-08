extension StringExtension on String {
  static const String DEFAULT_SPLIT_DELIMITER = '_';
  static const String DEFAULT_JOIN_DELIMITER = '';
  // REF: https://gist.github.com/filiph/d4e0c0a9efb0f869f984317372f5bee8
  String toPascalCase({
    String splitDelimiter = DEFAULT_SPLIT_DELIMITER,
    String joinDelimiter = DEFAULT_JOIN_DELIMITER,
  }) {
    final text = this;

    if (text == null) throw ArgumentError('string: $text');

    if (text.isEmpty) return text;

    return text
        .split(splitDelimiter)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(joinDelimiter);
  }
}
