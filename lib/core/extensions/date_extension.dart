import 'package:intl/intl.dart';

extension DateExtension on DateTime? {
  String get formatCompletedDate {
    if (this == null) return "Unknown";

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final completed = DateTime(this!.year, this!.month, this!.day);

    if (completed == today) {
      return "Today";
    } else {
      return DateFormat("MMM dd, yyyy").format(this!);
    }
  }
}
