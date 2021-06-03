class InputConverter {
  int stringToUnsignedInteger(String string) {
    final integer = int.parse(string);
    if (integer < 0) throw FormatException();
    return integer;
  }
}
