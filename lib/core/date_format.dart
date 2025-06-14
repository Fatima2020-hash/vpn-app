import 'package:intl/intl.dart';

String formatDate(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  } catch (e) {
    return 'Invalid Date';
  }
}