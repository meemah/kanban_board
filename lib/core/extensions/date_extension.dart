import 'package:intl/intl.dart';
import 'package:kanban_board/generated/l10n.dart';

extension DateExtension on DateTime? {
  String get formatCompletedDate {
    if (this == null) return S.current.unknown;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final completed = DateTime(this!.year, this!.month, this!.day);

    if (completed == today) {
      return DateFormat("hh:mm a").format(this!);
    } else {
      return DateFormat("MMM dd, yyyy").format(this!);
    }
  }
}
