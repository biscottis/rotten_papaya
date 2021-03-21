import 'package:intl/intl.dart';

DateFormat dateFormatMMMyyyy(String locale) {
  return DateFormat('MMM yyyy', locale);
}

DateFormat dateFormatddMMMyyyy(String locale) {
  return DateFormat('dd MMM yyyy', locale);
}
