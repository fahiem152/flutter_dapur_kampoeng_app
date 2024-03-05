class DateFormatter {
  static String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${_addZeroPrefix(dateTime.month)}-${_addZeroPrefix(dateTime.day)}';
  }

  static String _addZeroPrefix(int value) {
    return value.toString().padLeft(2, '0');
  }
}
