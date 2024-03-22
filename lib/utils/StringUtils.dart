class StringUtils {
  static String insertStringAtIndex(String originalString, int index, String stringToInsert) {
    final strings = <String>[];
    strings.add(originalString.substring(0, index));
    strings.add(stringToInsert);
    strings.add(originalString.substring(index, originalString.length));
    return strings.join('');
  }
}