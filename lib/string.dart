extension StringExtension on String {
  static const String defaultWordDelimiter = '_';
  static const String space = ' ';
  // REF: https://gist.github.com/filiph/d4e0c0a9efb0f869f984317372f5bee8
  String toTitleCase({String wordDelimiter = defaultWordDelimiter}) {
    final text = this;

    if (text.isEmpty) return text;

    return text
        .split(wordDelimiter)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(space);
  }
}
