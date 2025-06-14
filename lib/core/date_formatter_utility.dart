class DateFormatterUtility {
  static String toHumanFriendlyDate(String isoDateString) {
    try {
      final dateTime = DateTime.parse(isoDateString).toLocal();
      final day = dateTime.day;
      final suffix = _getDaySuffix(day);
      final month = _monthAbbreviation(dateTime.month);
      return '$day$suffix $month';
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String toHumanFriendlyDateTime(String isoDateString) {
    try {
      final dateTime = DateTime.parse(isoDateString).toLocal();
      final day = dateTime.day;
      final suffix = _getDaySuffix(day);
      final month = _monthAbbreviation(dateTime.month);
      final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final period = dateTime.hour >= 12 ? 'PM' : 'AM';

      return '$day$suffix $month $hour:$minute $period';
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static int dateTimeToDD(DateTime datetime) {
    try {
      int date = datetime.day;
      return date;
    } catch (e) {
      return 0;
    }
  }

  static String dateTimeToDDMMYY(DateTime datetime) {
    try {
      final List<String> monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

      String day = datetime.day.toString().padLeft(2, '0');
      String month = monthNames[datetime.month - 1];
      String year = datetime.year.toString();

      return '$day $month $year';
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String _monthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
